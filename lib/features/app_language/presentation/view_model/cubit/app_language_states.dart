abstract class AppLanguageStates {}

class AppLanguageInitial extends AppLanguageStates {}

class AppLanguageLoading extends AppLanguageStates {}

class AppLanguageChanged extends AppLanguageStates {
  final String localeCode;
  AppLanguageChanged(this.localeCode);
}

class AppLanguageError extends AppLanguageStates {
  final String error;
  AppLanguageError(this.error);
}
