part of 'sign_up_cubit.dart';

sealed class SignUpEvents {
  const SignUpEvents();
}

class SignUpUserEvent extends SignUpEvents {
  final UserEntity params;

  const SignUpUserEvent({required this.params});
}
