// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get helloWorld => 'مرحباً بك!';

  @override
  String welcomeMessage(Object username) {
    return 'أهلاً بك يا $username';
  }

  @override
  String get home => 'الرئيسية';

  @override
  String get myCourses => 'دوراتي';

  @override
  String get blogs => 'المدونات';

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get lightMode => 'الوضع النهاري';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';
}
