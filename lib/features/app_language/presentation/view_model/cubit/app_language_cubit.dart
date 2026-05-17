import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/features/app_language/presentation/view_model/cubit/app_language_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(AppLanguageInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> changeLanguage(BuildContext context, String langCode) async {
    emit(AppLanguageLoading());
    try {
      // Change the local app language using EasyLocalization
      if (langCode == 'ar') {
        await context.setLocale(const Locale('ar', 'EG'));
      } else {
        await context.setLocale(const Locale('en', 'US'));
      }

      emit(AppLanguageChanged(langCode));
    } catch (e) {
      emit(AppLanguageError(e.toString()));
    }
  }
}
