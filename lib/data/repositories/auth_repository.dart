import 'dart:async';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/web_client.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });
}
