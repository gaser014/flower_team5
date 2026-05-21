sealed class EditProfileEvents {}

class GetCachedUserEvent extends EditProfileEvents {}

class UpdateProfileDetailsEvent extends EditProfileEvents {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;

  UpdateProfileDetailsEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
  });
}

class UploadProfilePhotoEvent extends EditProfileEvents {
  final String imagePath;

  UploadProfilePhotoEvent({required this.imagePath});
}
