class LocaleInitialState extends LocaleState {
  LocaleInitialState() : super('en');
}

class LocaleLoadedState extends LocaleState {
  LocaleLoadedState(super.locale);
}

abstract class LocaleState {
  String locale;

  LocaleState(this.locale);
}
