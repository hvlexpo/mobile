import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/redux/app/data_state.dart';
import 'package:expo/redux/auth/auth_state.dart';
import 'package:expo/redux/ui/ui_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/redux/ui/list_ui_state.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/redux/user/user_state.dart';

import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/redux/exhibition/exhibition_state.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppState,
  LoginResponse,
  UserEntity,
  ExhibitionEntity,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
