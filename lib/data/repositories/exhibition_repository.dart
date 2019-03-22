import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/redux/auth/auth_state.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/data/web_client.dart';
import 'package:expo/constants.dart';

class ExhibitionRepository {
  final WebClient webClient;

  const ExhibitionRepository({
    this.webClient = const WebClient(),
  });

  Future<BuiltList<ExhibitionEntity>> loadList(AuthState auth) async {
    final response = await webClient.get(kApiUrl + '/exhibitions');

    var list = new BuiltList<ExhibitionEntity>(response.map((exhibition) {
      return serializers.deserializeWith(ExhibitionEntity.serializer, exhibition);
    }));

    return list;
  }

  Future saveData(AuthState auth, ExhibitionEntity exhibition, [EntityAction action]) async {

    var data = serializers.serializeWith(ExhibitionEntity.serializer, exhibition);
    var response;

    if (exhibition.isNew) {
      response = await webClient.post(
          kApiUrl + '/exhibitions', json.encode(data));
    } else {
      var url = kApiUrl + '/exhibitions/' + exhibition.id.toString();
      response = await webClient.put(url, json.encode(data));
    }

    return serializers.deserializeWith(ExhibitionEntity.serializer, response);
  }
}