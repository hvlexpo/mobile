import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/constants.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/redux/ui/entity_ui_state.dart';
import 'package:expo/redux/ui/list_ui_state.dart';

part 'exhibition_state.g.dart';

abstract class ExhibitionState implements Built<ExhibitionState, ExhibitionStateBuilder> {

  @nullable
  int get lastUpdated;

  BuiltMap<String, ExhibitionEntity> get map;
  BuiltList<String> get list;

  factory ExhibitionState() {
    return _$ExhibitionState._(
      map: BuiltMap<String, ExhibitionEntity>(),
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

  ExhibitionState._();
  static Serializer<ExhibitionState> get serializer => _$exhibitionStateSerializer;
}

abstract class ExhibitionUIState extends Object with EntityUIState implements Built<ExhibitionUIState, ExhibitionUIStateBuilder> {

  @nullable
  ExhibitionEntity get selected;

  bool get isSelectedNew => selected.isNew;

  factory ExhibitionUIState() {
    return _$ExhibitionUIState._(
      listUIState: ListUIState(''),
      selected: ExhibitionEntity(),
    );
  }

  ExhibitionUIState._();
  static Serializer<ExhibitionUIState> get serializer => _$exhibitionUIStateSerializer;
}