import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/state_types.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/domain/use_cases/get_all_products.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Manual Mock
class MockGetAllProductsUseCase extends Mock implements GetAllProductsUseCase {
  @override
  Future<Result<BasePaginationEntity<ProductEntity>>> call(ProductsParams? params) =>
      super.noSuchMethod(
        Invocation.method(#call, [params]),
        returnValue: Future.value(Success(data: BasePaginationEntity<ProductEntity>(
          meta: const MetaEntity(currentPage: 1, numberOfPages: 1, limit: 20, total: 0),
          data: [],
        ))),
      );
}

void main() {
  late MockGetAllProductsUseCase mockUseCase;
  late ProductsCubit cubit;

  setUp(() {
    mockUseCase = MockGetAllProductsUseCase();
    cubit = ProductsCubit(getAllProductsUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tProduct = const ProductEntity(id: '1', title: 'Flower');
  final tPaginationEntity = BasePaginationEntity<ProductEntity>(
    meta: const MetaEntity(currentPage: 1, numberOfPages: 1, limit: 20, total: 1),
    data: [tProduct],
  );

  group('ProductsCubit', () {
    test('initial state should be ProductsStates with initial pagination', () {
      expect(cubit.state.productsState.state, PaginationStateType.initial);
    });

    blocTest<ProductsCubit, ProductsStates>(
      'emits [loading, success] when GetAllProductsEvent is successful',
      build: () {
        when(mockUseCase.call(any)).thenAnswer((_) async => Success(data: tPaginationEntity));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAllProductsEvent(params: ProductsParams(page: 1))),
      expect: () => [
        isA<ProductsStates>().having((s) => s.productsState.state, 'state', PaginationStateType.loading),
        isA<ProductsStates>().having((s) => s.productsState.state, 'state', PaginationStateType.success),
      ],
    );

    blocTest<ProductsCubit, ProductsStates>(
      'emits [loading, error] when GetAllProductsEvent fails',
      build: () {
        when(mockUseCase.call(any)).thenAnswer((_) async => Error(exception: Exception('Error')));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAllProductsEvent(params: ProductsParams(page: 1))),
      expect: () => [
        isA<ProductsStates>().having((s) => s.productsState.state, 'state', PaginationStateType.loading),
        isA<ProductsStates>().having((s) => s.productsState.state, 'state', PaginationStateType.error),
      ],
    );
  });
}
