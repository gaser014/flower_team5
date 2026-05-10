import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/categories/data/models/occasions_response_dto.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';

abstract interface class CategoriesRemoteDataSourceContract {
  Future<Result<CategoriesResponseDto>> getAllCategories({
    required CategoriesParams params,
  });
  Future<Result<OccasionsResponseDto>> getAllOccasions({
    required CategoriesParams params,
  });
}
