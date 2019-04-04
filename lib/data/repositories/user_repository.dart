import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/constants.dart';
import 'package:http/http.dart';

class UserRepository {
  const UserRepository();

  Future<void> createOrUpdateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await post(kApiUrl + '/users', headers: {'firebasetoken': token});
  }

  Future<void> updateUser(FirebaseUser user) async {
    final token = await user.getIdToken();
    await post(kApiUrl + '/users',
        headers: {'name': user.displayName, 'firebasetoken': token});
  }
}
