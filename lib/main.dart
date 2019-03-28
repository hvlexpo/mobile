import 'package:flutter/material.dart';
import 'package:expo/ui/app/init.dart';
import 'package:expo/ui/home/home_screen.dart';
import 'package:expo/ui/auth/login.dart';
import 'package:expo/ui/scanner/scanner.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/utils/routes.dart';

void main() {
  runApp(ExpoApp());
}

class ExpoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
        title: 'HVL Expo',
        debugShowCheckedModeBanner: false,
        theme: ExpoTheme.primaryTheme,
        routes: {
          Routes.login: (context) => LoginView(),
          Routes.home: (context) => HomeView(),
          Routes.scan: (context) => ScannerView(),
        },
        initialRoute: Routes.login,
      );
  }
}
