// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../core/api/datasources/auth_local_data_source_impl.dart' as _i424;
import '../../core/data/data_sources/auth_local_data_source.dart' as _i759;
import '../../features/categories/api/api_client/categories_api_client.dart'
    as _i612;
import '../../features/categories/api/datasources/categories_local_data_source_impl.dart'
    as _i575;
import '../../features/categories/api/datasources/categories_remote_data_source_impl.dart'
    as _i740;
import '../../features/categories/data/datasources/categories_local_data_source_contract.dart'
    as _i641;
import '../../features/categories/data/datasources/categories_remote_data_source_contract.dart'
    as _i234;
import '../../features/categories/data/repositories/categories_repository_impl.dart'
    as _i245;
import '../../features/categories/domain/repositories/categories_repository.dart'
    as _i488;
import '../../features/categories/domain/use_cases/get_all_categories.dart'
    as _i63;
import '../../features/categories/presentation/view_model/cubit/categories_cubit.dart'
    as _i806;
import '../../features/products/api/api_client/products_api_client.dart'
    as _i41;
import '../../features/products/api/datasources/products_local_data_source_impl.dart'
    as _i1032;
import '../../features/products/api/datasources/products_remote_data_source_impl.dart'
    as _i838;
import '../../features/products/data/datasources/products_local_data_source_contract.dart'
    as _i47;
import '../../features/products/data/datasources/products_remote_data_source_contract.dart'
    as _i106;
import '../../features/products/data/repositories/products_repository_impl.dart'
    as _i1045;
import '../../features/products/domain/repositories/products_repository.dart'
    as _i27;
import '../../features/products/domain/use_cases/get_all_products.dart'
    as _i845;
import '../../features/products/presentation/view_model/cubit/products_cubit.dart'
    as _i593;
import '../api/app_interceptor.dart' as _i449;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => dioModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(() => dioModule.cancelToken());
    gh.lazySingleton<_i161.InternetConnection>(
      () => dioModule.internetConnection(),
    );
    gh.lazySingleton<_i47.ProductsLocalDataSourceContract>(
      () => _i1032.ProductsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i641.CategoriesLocalDataSourceContract>(
      () => _i575.CategoriesLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i612.CategoriesApiClient>(
      () => _i612.CategoriesApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i41.ProductsApiClient>(
      () => _i41.ProductsApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i759.AuthLocalDataSourceContract>(
      () =>
          _i424.AuthLocalDataSourceImpl(fss: gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i106.ProductsRemoteDataSourceContract>(
      () => _i838.ProductsRemoteDataSourceImpl(
        apiClient: gh<_i41.ProductsApiClient>(),
      ),
    );
    gh.lazySingleton<_i234.CategoriesRemoteDataSourceContract>(
      () => _i740.CategoriesRemoteDataSourceImpl(
        apiClient: gh<_i612.CategoriesApiClient>(),
      ),
    );
    gh.lazySingleton<_i27.ProductsRepository>(
      () => _i1045.ProductsRepositoryImpl(
        productsRemoteDataSourceContract:
            gh<_i106.ProductsRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i845.GetAllProductsUseCase>(
      () => _i845.GetAllProductsUseCase(gh<_i27.ProductsRepository>()),
    );
    gh.lazySingleton<_i488.CategoriesRepository>(
      () => _i245.CategoriesRepositoryImpl(
        categoriesRemoteDataSourceContract:
            gh<_i234.CategoriesRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i63.GetAllCategoriesUseCase>(
      () => _i63.GetAllCategoriesUseCase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i593.ProductsCubit>(
      () => _i593.ProductsCubit(
        getAllProductsUseCase: gh<_i845.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i806.CategoriesCubit>(
      () => _i806.CategoriesCubit(
        getAllCategoriesUseCase: gh<_i63.GetAllCategoriesUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
