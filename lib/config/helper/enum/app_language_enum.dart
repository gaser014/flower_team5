import 'package:flowers_app/core/constants/app_constants.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

enum AppLanguageEnum {
  arabic,
  english;

  String get text {
    switch (this) {
      case AppLanguageEnum.arabic:
        return AppStrings.arabic;
      case AppLanguageEnum.english:
        return AppStrings.english;
    }
  }

  String get code {
    switch (this) {
      case AppLanguageEnum.arabic:
        return AppConstants.arabicLanguageCode;
      case AppLanguageEnum.english:
        return AppConstants.englishLanguageCode;
    }
  }

  static AppLanguageEnum fromLocale(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == AppConstants.arabicLanguageCode) {
      return AppLanguageEnum.arabic;
    }
    return AppLanguageEnum.english;
  }
}
