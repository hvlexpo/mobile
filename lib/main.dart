import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:expo/ui/app/init.dart';
import 'package:expo/ui/home/home_screen.dart';
import 'package:expo/ui/auth/login.dart';
import 'package:expo/ui/scanner/scanner.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/utils/routes.dart';
import 'package:expo/utils/localization.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:expo/l10n/messages_all.dart';

List<CameraDescription> cameras;

void main() async {
  cameras = await availableCameras();
  runApp(ExpoApp());
}

class ExpoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('no', ''),
      ],
      title: 'HVL Expo',
      debugShowCheckedModeBanner: false,
      theme: ExpoTheme.primaryTheme,
      routes: {
        Routes.login: (context) => LoginView(),
        Routes.home: (context) => HomeView(),
        Routes.scan: (context) => ScannerView(
              cameras: cameras,
            ),
      },
      initialRoute: Routes.login,
    );
  }
}
