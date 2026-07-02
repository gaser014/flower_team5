import 'package:flowers_app/config/helper/enum/app_language_enum.dart';
import 'package:flutter/material.dart';
import 'package:flowers_app/core/constants/app_constants.dart';

extension ContextExtension on BuildContext {
  AppLanguageEnum get appLanguage {
    if (Localizations.localeOf(this).languageCode == AppConstants.arabicLanguageCode) {
      return AppLanguageEnum.arabic;
    }
    return AppLanguageEnum.english;
  }
}
