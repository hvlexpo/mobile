import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/data/web_client.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<dynamic>> login(String phoneNumber) async {
    // TODO Implement phone authentication
  }
}
