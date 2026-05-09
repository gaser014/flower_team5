import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/result.dart';
import '../../../../config/error_handling/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_data_source.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    try {
      final response = await _remoteDataSource.getCategories();
      final entities = response.categories?.map((e) => e.toEntity()).toList() ?? [];
      return Success(data: entities);
    } on DioException catch (e) {
      return Error(exception: ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      return Error(exception: ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Result<List<ProductEntity>>> getProducts(String? categoryId) async {
    try {
      final response = await _remoteDataSource.getProducts(categoryId);
      final entities = response.products?.map((e) => e.toEntity()).toList() ?? [];
      return Success(data: entities);
    } on DioException catch (e) {
      return Error(exception: ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      return Error(exception: ServerFailure(errorMessage: e.toString()));
    }
  }
}
