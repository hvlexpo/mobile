import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
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

  Future<BuiltList<UserEntity>> loadList() async {
    final response = await webClient.get(kApiUrl + '/users');

    var list = new BuiltList<UserEntity>(response.map((user) {
      return serializers.deserializeWith(UserEntity.serializer, user);
    }));

    return list;
  }

  Future saveData(UserEntity user, [EntityAction action]) async {

    var data = serializers.serializeWith(UserEntity.serializer, user);
    var response;

    if (user.isNew) {
      response = await webClient.post(
          kApiUrl + '/users', json.encode(data));
    } else {
      var url = kApiUrl + '/users/' + user.id.toString();
      response = await webClient.put(url, json.encode(data));
    }

    return serializers.deserializeWith(UserEntity.serializer, response);
  }
}