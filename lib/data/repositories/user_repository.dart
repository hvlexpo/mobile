import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/data/models/user_model.dart';
import 'dart:convert';
import 'package:expo/constants.dart';
import 'package:http/http.dart';

class UserRepository {
  const UserRepository();

  Future<void> createOrUpdateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    return await post(kApiUrl + '/users', headers: {'firebasetoken': token});
  }

  Future<void> updateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    return await post(kApiUrl + '/users',
        headers: {'name': user.displayName, 'firebasetoken': token});
  }

  Future<UserEntity> fetchCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser();
    final token = await user.getIdToken();

    return await get(kApiUrl + '/users/', headers: {'firebasetoken': token }).then((response) {
      return serializers.deserializeWith(UserEntity.serializer, jsonDecode(response.body));
    });
  }
}
