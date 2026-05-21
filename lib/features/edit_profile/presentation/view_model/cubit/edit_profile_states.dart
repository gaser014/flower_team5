part of 'edit_profile_cubit.dart';

class EditProfileStates extends Equatable {
  final BaseState<UserEntity?> loadUserState;
  final BaseState<UserEntity?> updateState;
  final BaseState<UserEntity?> uploadPhotoState;

  const EditProfileStates({
    this.loadUserState = const BaseState.initial(),
    this.updateState = const BaseState.initial(),
    this.uploadPhotoState = const BaseState.initial(),
  });

  EditProfileStates copyWith({
    BaseState<UserEntity?>? loadUserState,
    BaseState<UserEntity?>? updateState,
    BaseState<UserEntity?>? uploadPhotoState,
  }) {
    return EditProfileStates(
      loadUserState: loadUserState ?? this.loadUserState,
      updateState: updateState ?? this.updateState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    );
  }

  @override
  List<Object?> get props => [loadUserState, updateState, uploadPhotoState];
}
