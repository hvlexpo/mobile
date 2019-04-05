import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

import 'dart:async';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

String get headerText {
  return Intl.message('Your votes',
      name: 'headerText', desc: 'Description over votes');
}

String get loginNumberText {
  return Intl.message('Phone number',
      name: 'loginNumberText', desc: 'Loginpage numberfield');
}

String get sendCodeButton {
  return Intl.message('Send code',
      name: 'sendCodeButton', desc: 'Loginpage send code');
}

String get smsCodeText {
  return Intl.message('SMS code',
      name: 'smsCodeText', desc: 'Loginpage sms code');
}

String get verifyCodeButton {
  return Intl.message('Verify code',
      name: 'verifyCodeButton', desc: 'Verifying the sms code');
}

String get noCodeButton {
  return Intl.message('No code received?', name: 'noCodeButton');
}

String get goBackButton {
  return Intl.message('Go back',
      name: 'goBackButton', desc: 'button in qr-scanner');
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'no'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
