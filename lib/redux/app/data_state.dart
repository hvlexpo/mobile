import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:expo/redux/user/user_state.dart';

import 'package:expo/redux/exhibition/exhibition_state.dart';

part 'data_state.g.dart';

abstract class DataState implements Built<DataState, DataStateBuilder> {
  UserState get userState;

  ExhibitionState get exhibitionState;

  factory DataState() {
    return _$DataState._(
      userState: UserState(),
      exhibitionState: ExhibitionState(),
    );
  }

  DataState._();
  static Serializer<DataState> get serializer => _$dataStateSerializer;
}
