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
import '../../features/app_filter_tabs/api/api_client/app_filter_tabs_api_client.dart'
    as _i173;
import '../../features/app_filter_tabs/api/datasources/app_filter_tabs_remote_data_source_impl.dart'
    as _i849;
import '../../features/app_filter_tabs/data/datasources/app_filter_tabs_remote_data_source_contract.dart'
    as _i823;
import '../../features/app_filter_tabs/data/repositories/app_filter_tabs_repository_impl.dart'
    as _i539;
import '../../features/app_filter_tabs/domain/repositories/app_filter_tabs_repository.dart'
    as _i902;
import '../../features/app_filter_tabs/domain/use_cases/get_all_app_filter_tabs.dart'
    as _i313;
import '../../features/app_filter_tabs/presentation/view_model/cubit/app_filter_tabs_cubit.dart'
    as _i468;
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasources/home_remote_data_source_impl.dart'
    as _i796;
import '../../features/home/data/datasources/home_remote_data_source_contract.dart'
    as _i969;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/use_cases/get_home_use_case.dart' as _i261;
import '../../features/login/api/api_client/login_api_client.dart' as _i395;
import '../../features/login/api/datasources/login_local_data_source_impl.dart'
    as _i438;
import '../../features/login/api/datasources/login_remote_data_source_impl.dart'
    as _i904;
import '../../features/login/data/datasources/login_local_data_source_contract.dart'
    as _i325;
import '../../features/login/data/datasources/login_remote_data_source_contract.dart'
    as _i736;
import '../../features/login/data/repositories/login_repository_impl.dart'
    as _i1066;
import '../../features/login/domain/repositories/login_repository.dart'
    as _i902;
import '../../features/login/domain/use_cases/get_user_use_case.dart' as _i12;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/domain/use_cases/save_user_use_case.dart' as _i71;
import '../../features/login/presentation/view_model/cubit/login_cubit.dart'
    as _i753;
import '../../features/main/presentation/view_model/cubit/home_cubit.dart'
    as _i679;
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
    gh.factory<_i325.LoginLocalDataSourceContract>(
      () => _i438.LoginLocalDataSourceImpl(),
    );
    gh.factory<_i47.ProductsLocalDataSourceContract>(
      () => _i1032.ProductsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i173.AppFilterTabsApiClient>(
      () => _i173.AppFilterTabsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i395.LoginApiClient>(
      () => _i395.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i41.ProductsApiClient>(
      () => _i41.ProductsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i969.HomeRemoteDataSourceContract>(
      () => _i796.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
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
    gh.factory<_i736.LoginRemoteDataSourceContract>(
      () => _i904.LoginRemoteDataSourceImpl(gh<_i395.LoginApiClient>()),
    );
    gh.factory<_i823.AppFilterTabsRemoteDataSourceContract>(
      () => _i849.AppFilterTabsRemoteDataSourceImpl(
        apiClient: gh<_i173.AppFilterTabsApiClient>(),
      ),
    );
    gh.factory<_i106.ProductsRemoteDataSourceContract>(
      () => _i838.ProductsRemoteDataSourceImpl(
        apiClient: gh<_i41.ProductsApiClient>(),
      ),
    );
    gh.factory<_i0.HomeRepository>(
      () => _i76.HomeRepositoryImpl(gh<_i969.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i902.LoginRepositoryContract>(
      () => _i1066.LoginRepositoryImpl(
        gh<_i736.LoginRemoteDataSourceContract>(),
        gh<_i325.LoginLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i902.AppFilterTabsRepository>(
      () => _i539.AppFilterTabsRepositoryImpl(
        appFilterTabsRemoteDataSourceContract:
            gh<_i823.AppFilterTabsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i261.GetHomeUseCase>(
      () => _i261.GetHomeUseCase(gh<_i0.HomeRepository>()),
    );
    gh.factory<_i27.ProductsRepository>(
      () => _i1045.ProductsRepositoryImpl(
        productsRemoteDataSourceContract:
            gh<_i106.ProductsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i845.GetAllProductsUseCase>(
      () => _i845.GetAllProductsUseCase(gh<_i27.ProductsRepository>()),
    );
    gh.factory<_i313.GetAllAppFilterTabsUseCase>(
      () =>
          _i313.GetAllAppFilterTabsUseCase(gh<_i902.AppFilterTabsRepository>()),
    );
    gh.factory<_i12.GetUserUseCase>(
      () => _i12.GetUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.factory<_i71.SaveUserUseCase>(
      () => _i71.SaveUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.lazySingleton<_i679.HomeCubit>(
      () => _i679.HomeCubit(gh<_i261.GetHomeUseCase>()),
    );
    gh.factory<_i593.ProductsCubit>(
      () => _i593.ProductsCubit(
        getAllProductsUseCase: gh<_i845.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i468.AppFilterTabsCubit>(
      () => _i468.AppFilterTabsCubit(
        getAllAppFilterTabsUseCase: gh<_i313.GetAllAppFilterTabsUseCase>(),
      ),
    );
    gh.factory<_i753.LoginCubit>(
      () => _i753.LoginCubit(
        gh<_i191.LoginUseCase>(),
        gh<_i71.SaveUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
