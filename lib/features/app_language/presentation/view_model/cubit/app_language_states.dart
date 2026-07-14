abstract class HomeStates {}

class AppLanguageInitial extends HomeStates {}

class AppLanguageLoading extends HomeStates {}

class AppLanguageChanged extends HomeStates {
  final String localeCode;
  AppLanguageChanged(this.localeCode);
}

class AppLanguageError extends HomeStates {
  final String error;
  AppLanguageError(this.error);
}
