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
import 'package:http/http.dart';

class UserRepository {
  const UserRepository();

  Future<void> createOrUpdateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await get(kApiUrl + '/users', headers: {'FirebaseToken': token});
  }

  Future<void> updateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await post(kApiUrl + '/users',
        headers: {'name': user.displayName, 'FirebaseToken': token});
  }
}
