import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'logout_states.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit(this.logoutUseCase) : super(const LogoutStates());

  final LogoutUseCase logoutUseCase;

  void doIndented(LogoutEvents event) {
    switch (event) {
      case DoLogoutEvent():
        _logout();
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: const BaseState.loading()));
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
}
