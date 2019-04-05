import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:built_collection/built_collection.dart';
import 'dart:convert';
import 'package:expo/constants.dart';
import 'package:http/http.dart';

class UserRepository {
  const UserRepository();

  Future<void> createOrUpdateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    return await post(kApiUrl + '/users', headers: {'firebasetoken': token})
        .catchError((error) => print(error));
  }

  Future<void> updateUser(FirebaseUser user, {String name}) async {
    final token = await user.getIdToken();
    return await put(kApiUrl + '/users',
            headers: {'name': user.displayName, 'firebasetoken': token}, body: {'name': name})
        .catchError((error) => print(error));
  }

  Future<UserEntity> fetchCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser();
    final token = await user.getIdToken();

    return await get(kApiUrl + '/users', headers: {'firebasetoken': token})
        .then((response) {
      return serializers.deserializeWith(
          UserEntity.serializer, jsonDecode(response.body));
    }).catchError((error) => print(error));
  }

  Future<List<Map<String, dynamic>>> fetchUserVotes() async {
    final user = await FirebaseAuth.instance.currentUser();
    final token = await user.getIdToken();

    return await get(kApiUrl + '/votes', headers: {'firebasetoken': token})
        .then((response) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }).catchError((error) => print(error));
  }
}
