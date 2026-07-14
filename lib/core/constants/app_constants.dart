import 'package:flutter/material.dart';

class AppConstants {
  static const int timeout = 30000;
  static const String fontFamily = "RobotoEnglish";
  static const String translationPath = "assets/translations";
  
  static const String arabicLanguageCode = 'ar';
  static const String englishLanguageCode = 'en';
  
  static const Locale arabicLocale = Locale(arabicLanguageCode, 'EG');
  static const Locale englishLocale = Locale(englishLanguageCode, 'US');
}
