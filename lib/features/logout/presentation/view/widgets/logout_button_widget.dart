import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flowers_app/features/logout/presentation/view/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<LogoutCubit>(),
      child: BlocConsumer<LogoutCubit, LogoutStates>(
        listener: (context, state) {
          if (state.logoutState.isSuccess) {
            context.go(Routes.login);
          } else if (state.logoutState.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.logoutState.exception.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: () {
              if (state.logoutState.isLoading) return;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => LogoutDialog(
                  onCancel: () {
                    Navigator.pop(dialogContext);
                  },
                  onConfirm: () {
                    Navigator.pop(dialogContext);
                    context.read<LogoutCubit>().doIndented(const DoLogoutEvent());
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (state.logoutState.isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    const Icon(Icons.logout, color: Colors.black54),
                  const SizedBox(width: 16),
                  const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
