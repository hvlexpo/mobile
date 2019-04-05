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

  String get phoneNumber {
    return Intl.message('Phone number',
        name: 'phoneNumber', desc: 'Phone number field helper text');
  }

  String get sendCode {
    return Intl.message('Send code',
        name: 'sendCode', desc: 'Send SMS Code');
  }

  String get smsCode {
    return Intl.message('SMS code',
        name: 'smsCode', desc: 'SMS Code');
  }

  String get verifyCode {
    return Intl.message('Verify code',
        name: 'verifyCode', desc: 'Verify the SMS code');
  }

  String get noCodeReceived {
    return Intl.message('No code received?', name: 'noCodeReceived', desc: '');
  }

  String get loggedInWith {
    return Intl.message('Logged in with', name: 'loggedInWith', desc: '');
  }

  String get dashboard {
    return Intl.message('Dashboard', name:'dashboard', desc: '');
  }

  String get user {
    return Intl.message('User', name: 'user', desc: '');
  }

  String get view {
    return Intl.message('View', name: 'view', desc: '');
  }

  String get yourVote {
    return Intl.message('Your vote', name: 'yourVote', desc: '');
  }

  String get yourVotes {
    return Intl.message('Your votes', name: 'yourVotes', desc: '');
  }

  String get giveYourVote {
    return Intl.message('Give your vote', name: 'giveYourVote', desc: '');
  }

  String get removeVote {
    return Intl.message('Remove your vote', name: 'removeVote', desc: '');
  }

  String get vote {
    return Intl.message('Vote', name: 'vote', desc: '');
  }

  String get about {
    return Intl.message('About', name: 'about', desc: '');
  }

  String get creators {
    return Intl.message('Creators', name: 'creators', desc: '');
  }

  String get noCreators {
    return Intl.message('No creators', name: 'noCreators', desc: '');
  }

  String get photos {
    return Intl.message('Photos', name: 'photos', desc: '');
  }

  String get image {
    return Intl.message('Image', name: 'image', desc: '');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '');
  }

  String get changeName {
    return Intl.message('Change name', name: 'changeName', desc: '');
  }

  String get yourName {
    return Intl.message('Your name', name: 'yourName', desc: '');
  }

  String get submit {
    return Intl.message('Submit', name:'submit', desc: '');
  }

  String get goBack {
    return Intl.message('Go back',
        name: 'goBack', desc: 'Go-back text');
  }

  String get noDescription {
    return Intl.message('No description',
    name: 'noDescription', desc: '');
  }
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
