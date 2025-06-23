// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'यूज़र सूची ऐप';

  @override
  String get noUsers => 'कोई उपयोगकर्ता नहीं मिला।';

  @override
  String get searchUser => 'उपयोगकर्ता खोजें';

  @override
  String get noUsersFoundForSearch => 'आपकी खोज के लिए कोई उपयोगकर्ता नहीं मिला';
}
