import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/data/web_client.dart';
import 'package:expo/constants.dart';

class UserRepository {
  final WebClient webClient;

  const UserRepository({
    this.webClient = const WebClient(),
  });

  Future<void> createOrUpdateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await webClient.get(kApiUrl + '/users', headers: {'FirebaseToken': token});
  }

  Future<void> updateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await webClient.post(kApiUrl + '/users', {'name': user.displayName});
  }
}
