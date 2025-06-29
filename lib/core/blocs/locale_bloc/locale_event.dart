import 'package:intl/locale.dart';

class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);
}

abstract class LocaleEvent {}
