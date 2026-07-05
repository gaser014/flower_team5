import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:flowers_app/features/home/data/models/home_dto.dart';
import 'package:flowers_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSourceContract])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSourceContract mockRemoteDataSource;

  provideDummy<Result<HomeDto>>(const Success(data: null));

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSourceContract();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group('getHomeData', () {
    test(
      'should return Success with HomeEntity when remote data is successful',
      () async {
        // Arrange
        const tHomeDto = HomeDto(
          products: [],
          categories: [],
          bestSeller: [],
          occasions: [],
        );
        final tHomeEntity = tHomeDto.toEntity();

        when(
          mockRemoteDataSource.getHomeData(),
        ).thenAnswer((_) async => const Success(data: tHomeDto));

        // Act
        final result = await repository.getHomeData();

        // Assert
        expect(result, isA<Success<HomeEntity>>());
        expect((result as Success).data, tHomeEntity);
        verify(mockRemoteDataSource.getHomeData()).called(1);
      },
    );

    test('should return Error when remote data call is unsuccessful', () async {
      // Arrange
      final tException = Exception('Failed to fetch home data');
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Error(exception: tException));

      // Act
      final result = await repository.getHomeData();

      // Assert
      expect(result, isA<Error<HomeEntity>>());
      expect((result as Error).exception, tException);
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test(
      'should return Success with null data when remote data is empty/null',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.getHomeData(),
        ).thenAnswer((_) async => const Success(data: null));

        // Act
        final result = await repository.getHomeData();

        // Assert
        expect(result, isA<Success<HomeEntity>>());
        expect((result as Success).data, null);
        verify(mockRemoteDataSource.getHomeData()).called(1);
      },
    );
  });
}
