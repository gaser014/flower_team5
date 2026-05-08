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
import '../../features/auth/sign_up/api/data_sources/sign_up_remote_data_source_impl.dart'
    as _i1052;
import '../../features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart'
    as _i897;
import '../../features/auth/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i442;
import '../../features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart'
    as _i100;
import '../../features/auth/sign_up/domain/use_cases/sign_up_use_case.dart'
    as _i45;
import '../../features/auth/sign_up/presentation/cubit/sign_up_cubit.dart'
    as _i809;
import '../../features/forget_password/api/api_client/forget_password_api_client.dart'
    as _i892;
import '../../features/forget_password/api/datasources/forget_password_local_data_source_impl.dart'
    as _i961;
import '../../features/forget_password/api/datasources/forget_password_remote_data_source_impl.dart'
    as _i358;
import '../../features/forget_password/data/datasources/forget_password_local_data_source_contract.dart'
    as _i986;
import '../../features/forget_password/data/datasources/forget_password_remote_data_source_contract.dart'
    as _i913;
import '../../features/forget_password/data/repositories/forget_password_repository_impl.dart'
    as _i787;
import '../../features/forget_password/domain/repositories/forget_password_repository.dart'
    as _i129;
import '../../features/forget_password/domain/use_cases/forget_password_use_cases.dart'
    as _i531;
import '../../features/forget_password/presentation/view_model/bloc/forget_password_bloc.dart'
    as _i459;
import '../../features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart'
    as _i955;
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
    gh.lazySingleton<_i897.SignUpRemoteDataSource>(
      () => _i1052.SignUpRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i325.LoginLocalDataSourceContract>(
      () => _i438.LoginLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i986.ForgetPasswordLocalDataSourceContract>(
      () => _i961.ForgetPasswordLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i892.ForgetPasswordApiClient>(
      () => _i892.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i395.LoginApiClient>(
      () => _i395.LoginApiClient(gh<_i361.Dio>()),
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
    gh.lazySingleton<_i913.ForgetPasswordRemoteDataSourceContract>(
      () => _i358.ForgetPasswordRemoteDataSourceImpl(
        gh<_i892.ForgetPasswordApiClient>(),
      ),
    );
    gh.lazySingleton<_i902.LoginRepositoryContract>(
      () => _i1066.LoginRepositoryImpl(
        gh<_i736.LoginRemoteDataSourceContract>(),
        gh<_i325.LoginLocalDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i129.ForgetPasswordRepository>(
      () => _i787.ForgetPasswordRepositoryImpl(
        gh<_i913.ForgetPasswordRemoteDataSourceContract>(),
        gh<_i759.AuthLocalDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i100.SignUpRepositoryContract>(
      () => _i442.SignUpRepositoryImpl(
        gh<_i897.SignUpRemoteDataSource>(),
        gh<_i759.AuthLocalDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i531.SendForgetPasswordCodeUseCase>(
      () => _i531.SendForgetPasswordCodeUseCase(
        gh<_i129.ForgetPasswordRepository>(),
      ),
    );
    gh.lazySingleton<_i531.VerifyForgetPasswordCodeUseCase>(
      () => _i531.VerifyForgetPasswordCodeUseCase(
        gh<_i129.ForgetPasswordRepository>(),
      ),
    );
    gh.lazySingleton<_i531.ResetPasswordUseCase>(
      () => _i531.ResetPasswordUseCase(gh<_i129.ForgetPasswordRepository>()),
    );
    gh.lazySingleton<_i12.GetUserUseCase>(
      () => _i12.GetUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.lazySingleton<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.lazySingleton<_i71.SaveUserUseCase>(
      () => _i71.SaveUserUseCase(gh<_i902.LoginRepositoryContract>()),
    );
    gh.lazySingleton<_i45.SignUpUseCase>(
      () => _i45.SignUpUseCase(gh<_i100.SignUpRepositoryContract>()),
    );
    gh.factory<_i753.LoginCubit>(
      () => _i753.LoginCubit(
        gh<_i191.LoginUseCase>(),
        gh<_i71.SaveUserUseCase>(),
      ),
    );
    gh.factory<_i459.ForgetPasswordBloc>(
      () => _i459.ForgetPasswordBloc(
        gh<_i531.SendForgetPasswordCodeUseCase>(),
        gh<_i531.VerifyForgetPasswordCodeUseCase>(),
        gh<_i531.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i955.ForgetPasswordCubit>(
      () => _i955.ForgetPasswordCubit(
        gh<_i531.SendForgetPasswordCodeUseCase>(),
        gh<_i531.VerifyForgetPasswordCodeUseCase>(),
        gh<_i531.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i809.SignUpCubit>(
      () => _i809.SignUpCubit(gh<_i45.SignUpUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
