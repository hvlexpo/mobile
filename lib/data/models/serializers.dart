import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:expo/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/data/models/exhibition_model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  LoginResponse,
  UserEntity,
  ExhibitionEntity,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
