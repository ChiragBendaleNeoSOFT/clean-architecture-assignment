import 'package:intl/locale.dart';

abstract class LocaleEvent {}

class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);
}
