// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a no locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'no';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "goBackButton" : MessageLookupByLibrary.simpleMessage("Tilbake"),
    "headerText" : MessageLookupByLibrary.simpleMessage("Dine stemmer"),
    "loginNumberText" : MessageLookupByLibrary.simpleMessage("Telefonnummer"),
    "noCodeButton" : MessageLookupByLibrary.simpleMessage("Ikke mottat kode?"),
    "sendCodeButton" : MessageLookupByLibrary.simpleMessage("Send kode"),
    "smsCodeText" : MessageLookupByLibrary.simpleMessage("SMS kode"),
    "verifyCodeButton" : MessageLookupByLibrary.simpleMessage("Vertifiser kode")
  };
}
