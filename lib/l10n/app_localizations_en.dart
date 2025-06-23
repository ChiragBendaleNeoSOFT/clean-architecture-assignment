// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'User List App';

  @override
  String get noUsers => 'No users found.';

  @override
  String get searchUser => 'Search user';

  @override
  String get noUsersFoundForSearch => 'No users found for your search';

  @override
  String get userDetails => 'User Details';

  @override
  String get userInformation => 'User Information';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';
}
