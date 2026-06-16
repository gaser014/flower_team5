import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/delete_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/delete_driver_token_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/get_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/login_driver_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/save_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/save_driver_token_use_case.dart';
import 'package:flowers_app/features/login_Driver/presentation/view_model/cubit/login_Driver_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';

part 'login_Driver_states.dart';

@injectable
class LoginDriverCubit extends Cubit<LoginDriverStates> {
  LoginDriverCubit(
    this._loginDriverUseCase,
    this._saveDriverTokenUseCase,
    this._deleteDriverTokenUseCase,
    this._saveDriverCredentialsUseCase,
    this._getDriverCredentialsUseCase,
    this._deleteDriverCredentialsUseCase,
  ) : super(const LoginDriverStates());

  final LoginDriverUseCase _loginDriverUseCase;
  final SaveDriverTokenUseCase _saveDriverTokenUseCase;
  final DeleteDriverTokenUseCase _deleteDriverTokenUseCase;
  final SaveDriverCredentialsUseCase _saveDriverCredentialsUseCase;
  final GetDriverCredentialsUseCase _getDriverCredentialsUseCase;
  final DeleteDriverCredentialsUseCase _deleteDriverCredentialsUseCase;

  Future<void> loadSavedCredentials() async {
    final result = await _getDriverCredentialsUseCase.call(const NoParams());
    result.when(
      success: (credentials) {
        if (credentials != null &&
            credentials['driverSavedEmail'] != null &&
            credentials['driverSavedPassword'] != null) {
          emit(
            state.copyWith(
              savedCredentials: BaseState.success(credentials),
              rememberMeState: const BaseState.success(true),
            ),
          );
        }
      },
      error: (_) {},
    );
  }

  void doIndented(LoginDriverEvents event) {
    switch (event) {
      case LoginDriverEvent():
        _login(event.params);
      case RememberMeDriverEvent():
        _rememberMe(event.rememberMe);
      case ShowPasswordDriverEvent():
        _showPassword(event.showPassword);
      case LogoutDriverEvent():
        _logout();
    }
  }

  Future<void> _login(LoginParams params) async {
    emit(state.copyWith(loginState: BaseState.loading()));
    final result = await _loginDriverUseCase.call(params);
    result.when(
      success: (response) async {
        if (response?.token != null) {
          await _saveDriverTokenUseCase.call(response!.token!);
        }
        if (params.remember ?? false) {
          await _saveDriverCredentialsUseCase.call(
            email: params.email,
            password: params.password,
          );
        } else {
          await _deleteDriverCredentialsUseCase.call(const NoParams());
        }
        emit(state.copyWith(loginState: BaseState.success(response)));
      },
      error: (exception) {
        emit(state.copyWith(loginState: BaseState.error(exception)));
      },
    );
  }

  Future<void> _rememberMe(bool rememberMe) async {
    emit(state.copyWith(rememberMeState: BaseState.success(rememberMe)));
  }

  Future<void> _showPassword(bool showPassword) async {
    emit(state.copyWith(showPasswordState: BaseState.success(showPassword)));
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: BaseState.loading()));
    final result = await _deleteDriverTokenUseCase.call(const NoParams());
    result.when(
      success: (_) {
        emit(state.copyWith(logoutState: BaseState.success(null)));
      },
      error: (exception) {
        emit(state.copyWith(logoutState: BaseState.error(exception)));
      },
    );
  }
}
