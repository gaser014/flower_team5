import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flowers_app/features/tracking_test/domain/use_cases/remove_user_token_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'logout_states.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit(
    this.logoutUseCase,
    this._getUserUseCase,
    this._removeUserTokenUseCase,
  ) : super(const LogoutStates());

  final LogoutUseCase logoutUseCase;
  final GetUserUseCase _getUserUseCase;
  final RemoveUserTokenUseCase _removeUserTokenUseCase;

  void doIndented(LogoutEvents event) {
    switch (event) {
      case DoLogoutEvent():
        _logout();
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: const BaseState.loading()));
    // Remove this device's FCM token from Firebase before the session is
    // cleared (logout clears the saved user, so we need it beforehand).
    await _removeFcmTokenFromFirebase();
    final result = await logoutUseCase.call();
    result.when(
      success: (_) {
        emit(state.copyWith(logoutState: const BaseState.success(null)));
      },
      error: (Exception? exception) {
        emit(state.copyWith(logoutState: BaseState.error(exception)));
      },
    );
  }

  Future<void> _removeFcmTokenFromFirebase() async {
    try {
      final token = FCMService().fcmToken;
      if (token == null || token.isEmpty) return;

      String? userId;
      final userResult = await _getUserUseCase.call(const NoParams());
      userResult.when(
        success: (user) => userId = user?.id,
        error: (_) {},
      );

      if (userId != null && userId!.isNotEmpty) {
        await _removeUserTokenUseCase.call(userId: userId!, token: token);
      }
    } catch (e) {
      // Never block logout because of a Firebase cleanup failure.
      log('Failed to remove FCM token on logout: $e');
    }
  }
}
