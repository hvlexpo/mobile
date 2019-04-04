import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/data/models/serializers.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:expo/constants.dart';

class ExhibitionRepository {
  const ExhibitionRepository();

  Future<BuiltList<ExhibitionEntity>> loadList() async {
    final user = await FirebaseAuth.instance.currentUser();
    final token = await user.getIdToken();

    return await get(kApiUrl + '/exhibitions',
        headers: {'firebasetoken': token}).then(
      (response) {
        return BuiltList<ExhibitionEntity>(
          jsonDecode(response.body).map(
            (exhibition) => serializers.deserializeWith(
                ExhibitionEntity.serializer, exhibition),
          ),
        );
      },
    ).catchError((error) => throw error);
  }

  Future<ExhibitionEntity> fetchExhibitionById(String id) async {
    final user = await FirebaseAuth.instance.currentUser();
    final token = await user.getIdToken();

    return await get(kApiUrl + '/exhibitions/$id',
        headers: {'firebasetoken': token}).then((response) {
      return serializers.deserializeWith(
          ExhibitionEntity.serializer, jsonDecode(response.body));
    });
  }

  Future saveData(ExhibitionEntity exhibition, [EntityAction action]) async {
    var data =
        serializers.serializeWith(ExhibitionEntity.serializer, exhibition);
    var response;

    if (exhibition.isNew) {
      response = await post(kApiUrl + '/exhibitions', body: json.encode(data));
    } else {
      var url = kApiUrl + '/exhibitions/' + exhibition.id.toString();
      response = await put(url, body: json.encode(data));
    }

    return serializers.deserializeWith(ExhibitionEntity.serializer, response);
  }
}
