import 'package:intl/locale.dart';

abstract class LocaleState {
  String locale;

  LocaleState(this.locale);
}

class LocaleInitialState extends LocaleState {
  LocaleInitialState() : super('en');
}

class LocaleLoadedState extends LocaleState {
  LocaleLoadedState(super.locale);
}
