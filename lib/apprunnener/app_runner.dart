import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> runApplication(Widget root) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'lib/l10n',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: root,
    ),
  );
}
