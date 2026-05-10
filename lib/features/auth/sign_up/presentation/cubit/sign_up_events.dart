part of 'sign_up_cubit.dart';

sealed class SignUpEvents {
  const SignUpEvents();
}

class SignUpUserEvent extends SignUpEvents {
  final SignUpParams params;

  const SignUpUserEvent({required this.params});
}

class TogglePasswordVisibilityEvent extends SignUpEvents {
  const TogglePasswordVisibilityEvent();
}

class ToggleConfirmPasswordVisibilityEvent extends SignUpEvents {
  const ToggleConfirmPasswordVisibilityEvent();
}

class ChangeGenderEvent extends SignUpEvents {
  final Gender gender;

  const ChangeGenderEvent(this.gender);
}
