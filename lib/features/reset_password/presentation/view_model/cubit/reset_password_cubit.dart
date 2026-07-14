import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/reset_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flowers_app/features/reset_password/presentation/view_model/cubit/reset_password_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_states.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit(this.resetPasswordUseCase)
    : super(const ResetPasswordStates());

  final ResetPasswordUseCase resetPasswordUseCase;

  void doIndented(ResetPasswordEvents event) {
    switch (event) {
      case SubmitResetPasswordEvent():
        _resetPassword(event);
    }
  }

  Future<void> _resetPassword(SubmitResetPasswordEvent event) async {
    emit(state.copyWith(resetPasswordState: const BaseState.loading()));
    final result = await resetPasswordUseCase.call(event.params);
    result.when(
      success: (response) {
        emit(state.copyWith(resetPasswordState: BaseState.success(response)));
      },
      error: (Exception? exception) {
        emit(state.copyWith(resetPasswordState: BaseState.error(exception)));
      },
    );
  }
}
