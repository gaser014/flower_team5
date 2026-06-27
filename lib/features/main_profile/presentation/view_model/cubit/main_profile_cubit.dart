import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:flowers_app/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:flowers_app/features/login/domain/use_cases/save_user_use_case.dart';
import 'package:flowers_app/features/main_profile/domain/use_cases/get_main_profile_use_case.dart';
import 'package:flowers_app/features/main_profile/presentation/view_model/cubit/main_profile_events.dart';
import 'package:flowers_app/features/tracking_test/domain/use_cases/update_user_token_lang_use_case.dart';
import 'package:injectable/injectable.dart';

part 'main_profile_states.dart';

@Injectable()
class MainProfileCubit extends Cubit<MainProfileStates> {
  MainProfileCubit(
    this._getMainProfileUseCase,
    this._saveUserUseCase,
    this._getUserUseCase,
    this._updateUserTokenLangUseCase,
  ) : super(const MainProfileStates());

  final GetMainProfileUseCase _getMainProfileUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final GetUserUseCase _getUserUseCase;
  final UpdateUserTokenLangUseCase _updateUserTokenLangUseCase;

  void doIndented(MainProfileEvents event) {
    switch (event) {
      case GetMainProfileEvent():
        _fetchProfile();
      case ChangeLanguageEvent():
        _updateLanguageInFirebase(event.langCode);
    }
  }

  Future<void> _fetchProfile() async {
    emit(state.copyWith(profileState: const BaseState.loading()));

    final remoteResult = await _getMainProfileUseCase.call(NoParams());
    remoteResult.when(
      success: (user) async {
        if (user != null) {
          await _saveUserUseCase.call(user);
          emit(state.copyWith(profileState: BaseState.success(user)));
        }
      },
      error: (exception) {
        emit(state.copyWith(profileState: BaseState.error(exception)));
      },
    );
  }

  /// Sync the selected app language to this device's FCM token in Firebase so
  /// push notifications are delivered in the correct language.
  Future<void> _updateLanguageInFirebase(String langCode) async {
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
        await _updateUserTokenLangUseCase.call(
          userId: userId!,
          token: token,
          lang: langCode,
        );
      }
    } catch (e) {
      log('Failed to update language in Firebase: $e');
    }
  }
}
