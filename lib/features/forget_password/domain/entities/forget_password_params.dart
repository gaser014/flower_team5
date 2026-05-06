class ForgetPasswordParams {
  final String? email;
  final String? resetCode;
  final String? newPassword;

  ForgetPasswordParams({
    this.email,
    this.resetCode,
    this.newPassword,
  });
  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (resetCode != null) 'resetCode': resetCode,
      if (newPassword != null) 'newPassword': newPassword,
    };
  }
}
