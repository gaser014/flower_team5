import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/checkout/data/datasources/checkout_remote_data_source_contract.dart';
import 'package:flowers_app/features/checkout/data/datasources/order_firestore_data_source_contract.dart';
import 'package:flowers_app/features/checkout/data/models/response/cash_on_delivery_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/credit_card_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/get_orders_dto.dart';
import 'package:flowers_app/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:flowers_app/features/checkout/domain/entities/cash_on_delivery_entity.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_repository_impl_test.mocks.dart';

@GenerateMocks([
  CheckoutRemoteDataSourceContract,
  OrderFirestoreDataSourceContract,
  AuthLocalDataSourceContract,
])
void main() {
  provideDummy<Result<CashOnDeliveryDto>>(const Success<CashOnDeliveryDto>());
  provideDummy<Result<CreditCardDto>>(const Success<CreditCardDto>());
  provideDummy<Result<GetOrdersDto>>(const Success<GetOrdersDto>());

  late CheckoutRepositoryImpl repository;
  late MockCheckoutRemoteDataSourceContract mockRemoteDataSource;
  late MockOrderFirestoreDataSourceContract mockFirestoreDataSource;
  late MockAuthLocalDataSourceContract mockAuthLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockCheckoutRemoteDataSourceContract();
    mockFirestoreDataSource = MockOrderFirestoreDataSourceContract();
    mockAuthLocalDataSource = MockAuthLocalDataSourceContract();
    repository = CheckoutRepositoryImpl(
      mockRemoteDataSource,
      mockFirestoreDataSource,
      mockAuthLocalDataSource,
    );
  });

  const tParams = CheckoutParams(
    street: 'street',
    phone: 'phone',
    city: 'city',
    lat: '30.0',
    long: '31.0',
  );

  void verifyNeverMirrored() {
    verifyNever(
      mockFirestoreDataSource.createOrder(
        order: anyNamed('order'),
        params: anyNamed('params'),
        userId: anyNamed('userId'),
        userName: anyNamed('userName'),
      ),
    );
  }

  group('checkoutWithCashOnDelivery', () {
    test('should return Success<CashOnDeliveryEntity> when remote succeeds',
        () async {
      when(mockRemoteDataSource.checkoutWithCashOnDelivery(any)).thenAnswer(
        (_) async => Success<CashOnDeliveryDto>(
          data: CashOnDeliveryDto(message: 'ok', orderNumber: '123'),
        ),
      );

      final result = await repository.checkoutWithCashOnDelivery(tParams);

      expect(result, isA<Success<CashOnDeliveryEntity>>());
      expect(
        (result as Success<CashOnDeliveryEntity>).data?.orderNumber,
        '123',
      );
      verify(mockRemoteDataSource.checkoutWithCashOnDelivery(any)).called(1);
    });

    test('should return Error when remote fails', () async {
      final tException = Exception('network error');
      when(mockRemoteDataSource.checkoutWithCashOnDelivery(any)).thenAnswer(
        (_) async => Error<CashOnDeliveryDto>(exception: tException),
      );

      final result = await repository.checkoutWithCashOnDelivery(tParams);

      expect(result, isA<Error<CashOnDeliveryEntity>>());
      verify(mockRemoteDataSource.checkoutWithCashOnDelivery(any)).called(1);
      verifyNeverMirrored();
    });
  });

  group('checkoutWithCreditCard', () {
    test('should return Success<CreditCardEntity> with payment url', () async {
      when(mockRemoteDataSource.checkoutWithCreditCard(any)).thenAnswer(
        (_) async => Success<CreditCardDto>(
          data: CreditCardDto(
            url: 'https://pay.example.com',
            successUrl: 'https://pay.example.com/success',
          ),
        ),
      );

      final result = await repository.checkoutWithCreditCard(tParams);

      expect(result, isA<Success<CreditCardEntity>>());
      final data = (result as Success<CreditCardEntity>).data;
      expect(data?.url, 'https://pay.example.com');
      expect(data?.successUrl, 'https://pay.example.com/success');
      verify(mockRemoteDataSource.checkoutWithCreditCard(any)).called(1);
    });

    test('should return Error when remote fails', () async {
      when(mockRemoteDataSource.checkoutWithCreditCard(any)).thenAnswer(
        (_) async => Error<CreditCardDto>(exception: Exception('failed')),
      );

      final result = await repository.checkoutWithCreditCard(tParams);

      expect(result, isA<Error<CreditCardEntity>>());
      verify(mockRemoteDataSource.checkoutWithCreditCard(any)).called(1);
    });
  });

  group('syncCardOrder', () {
    test('should mirror the latest order to Firestore when orders exist',
        () async {
      when(mockRemoteDataSource.getMyOrders()).thenAnswer(
        (_) async => Success<GetOrdersDto>(
          data: GetOrdersDto(
            orders: [
              {'orderNumber': '9', 'createdAt': '2024-01-01T00:00:00.000Z'},
            ],
          ),
        ),
      );
      when(mockAuthLocalDataSource.getUserToken())
          .thenAnswer((_) async => null);
      when(
        mockFirestoreDataSource.createOrder(
          order: anyNamed('order'),
          params: anyNamed('params'),
          userId: anyNamed('userId'),
          userName: anyNamed('userName'),
        ),
      ).thenAnswer((_) async {});

      await repository.syncCardOrder(tParams);

      verify(
        mockFirestoreDataSource.createOrder(
          order: anyNamed('order'),
          params: anyNamed('params'),
          userId: anyNamed('userId'),
          userName: anyNamed('userName'),
        ),
      ).called(1);
    });

    test('should not mirror anything when there are no orders', () async {
      when(mockRemoteDataSource.getMyOrders()).thenAnswer(
        (_) async => Success<GetOrdersDto>(
          data: GetOrdersDto(orders: const []),
        ),
      );

      await repository.syncCardOrder(tParams);

      verifyNeverMirrored();
    });

    test('should swallow errors from getMyOrders', () async {
      when(mockRemoteDataSource.getMyOrders()).thenAnswer(
        (_) async => Error<GetOrdersDto>(exception: Exception('boom')),
      );

      await repository.syncCardOrder(tParams);

      verifyNeverMirrored();
    });
  });
}
