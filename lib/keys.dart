// Use strings keys to support integrations tests otherwise you'll see this error
// "The built-in library 'dart:ui' is not available on the stand-alone VM."
// http://cogitas.net/write-integration-test-flutter/

class LoginKeys {
  static final String phoneNumberKey = '__login__phoneNumber__';
}