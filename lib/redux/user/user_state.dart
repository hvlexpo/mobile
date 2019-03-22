import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/constants.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/redux/ui/entity_ui_state.dart';
import 'package:expo/redux/ui/list_ui_state.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<String, UserEntity> get map;
  BuiltList<String> get list;

  factory UserState() {
    return _$UserState._(
      map: BuiltMap<String, UserEntity>(),
      list: BuiltList<String>(),
    );
  }

  bool get isStale {
    if (! isLoaded) {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch - lastUpdated > kMillisecondsToRefreshData;
  }

  bool get isLoaded {
    return lastUpdated != null;
  }

  UserState._();
  static Serializer<UserState> get serializer => _$userStateSerializer;
}

abstract class UserUIState extends Object with EntityUIState implements Built<UserUIState, UserUIStateBuilder> {

  @nullable
  UserEntity get selected;

  bool get isSelectedNew => selected.isNew;

  factory UserUIState() {
    return _$UserUIState._(
      listUIState: ListUIState(''),
      selected: UserEntity(),
    );
  }

  UserUIState._();
  static Serializer<UserUIState> get serializer => _$userUIStateSerializer;
}