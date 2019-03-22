import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:expo/redux/app/app_actions.dart';
import 'package:expo/redux/app/app_state.dart';

class LoadStateRequest {
  final BuildContext context;
  LoadStateRequest(this.context);
}

class LoadStateSuccess {
  final AppState state;
  LoadStateSuccess(this.state);
}

class LoadUserLogin {
  final BuildContext context;
  LoadUserLogin(this.context);
}

class UserLoginLoaded {
  final String phoneNumber;

  UserLoginLoaded(this.phoneNumber);
}

class UserLoginRequest implements StartLoading {
  final Completer completer;
  final String phoneNumber;

  UserLoginRequest(this.completer, this.phoneNumber);
}

class UserLoginSuccess implements StopLoading {}

class UserLoginFailure implements StopLoading {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout implements PersistData {}
