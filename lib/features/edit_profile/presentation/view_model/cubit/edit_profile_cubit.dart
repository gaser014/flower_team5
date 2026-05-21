import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowers_app/features/edit_profile/domain/use_cases/get_cached_user_use_case.dart';
import 'package:flowers_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowers_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_states.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  EditProfileCubit(
    this._getCachedUserUseCase,
    this._editProfileUseCase,
    this._uploadPhotoUseCase,
  ) : super(const EditProfileStates());

  Future<void> doIntent(EditProfileEvents event) async {
    switch (event) {
      case GetCachedUserEvent():
        await _getCachedUser();
      case UpdateProfileDetailsEvent():
        await _editProfile(event);
      case UploadProfilePhotoEvent():
        await _uploadPhoto(event);
    }
  }

  Future<void> _getCachedUser() async {
    emit(state.copyWith(loadUserState: BaseState.loading()));
    final result = await _getCachedUserUseCase.call(const NoParams());
    result.when(
      success: (user) {
        emit(state.copyWith(loadUserState: BaseState.success(user)));
      },
      error: (exception) {
        emit(state.copyWith(loadUserState: BaseState.error(exception)));
      },
    );
  }

  Future<void> _editProfile(UpdateProfileDetailsEvent event) async {
    emit(state.copyWith(updateState: BaseState.loading()));
    final result = await _editProfileUseCase.call(EditProfileParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
      gender: event.gender,
    ));
    result.when(
      success: (user) {
        emit(state.copyWith(updateState: BaseState.success(user)));
      },
      error: (exception) {
        emit(state.copyWith(updateState: BaseState.error(exception)));
      },
    );
  }

  Future<void> _uploadPhoto(UploadProfilePhotoEvent event) async {
    emit(state.copyWith(uploadPhotoState: BaseState.loading()));
    final result = await _uploadPhotoUseCase.call(event.imagePath);
    result.when(
      success: (user) {
        emit(state.copyWith(uploadPhotoState: BaseState.success(user)));
      },
      error: (exception) {
        emit(state.copyWith(uploadPhotoState: BaseState.error(exception)));
      },
    );
  }
}
