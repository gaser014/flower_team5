sealed class MainProfileEvents {}

class GetMainProfileEvent extends MainProfileEvents {}

class ChangeLanguageEvent extends MainProfileEvents {
  final String langCode;

  ChangeLanguageEvent(this.langCode);
}
