import 'package:redux/redux.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/redux/ui/entity_ui_state.dart';
import 'package:expo/redux/ui/list_ui_state.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/redux/exhibition/exhibition_state.dart';

EntityUIState exhibitionUIReducer(ExhibitionUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(exhibitionListReducer(state.listUIState, action))
    ..selected.replace(editingReducer(state.selected, action))
  );
}

final editingReducer = combineReducers<ExhibitionEntity>([
  TypedReducer<ExhibitionEntity, SaveExhibitionSuccess>(_updateEditing),
  TypedReducer<ExhibitionEntity, AddExhibitionSuccess>(_updateEditing),
  TypedReducer<ExhibitionEntity, ViewExhibition>(_updateEditing),
  TypedReducer<ExhibitionEntity, EditExhibition>(_updateEditing),
  TypedReducer<ExhibitionEntity, UpdateExhibition>(_updateEditing),
]);

/*
ExhibitionEntity  _clearEditing(ExhibitionEntity exhibition, action) {
  return ExhibitionEntity();
}
*/

ExhibitionEntity _updateEditing(ExhibitionEntity exhibition, action) {
  return action.exhibition;
}

final exhibitionListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortExhibitions>(_sortExhibitions),
  TypedReducer<ListUIState, SearchExhibitions>(_searchExhibitions),
]);

ListUIState _searchExhibitions(ListUIState exhibitionListState, SearchExhibitions action) {
  return exhibitionListState.rebuild((b) => b
    ..search = action.search
  );
}

ListUIState _sortExhibitions(ListUIState exhibitionListState, SortExhibitions action) {
  return exhibitionListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final exhibitionsReducer = combineReducers<ExhibitionState>([
  TypedReducer<ExhibitionState, SaveExhibitionSuccess>(_updateExhibition),
  TypedReducer<ExhibitionState, AddExhibitionSuccess>(_addExhibition),
  TypedReducer<ExhibitionState, LoadExhibitionsSuccess>(_setLoadedExhibitions),
  TypedReducer<ExhibitionState, LoadExhibitionsFailure>(_setNoExhibitions),

  TypedReducer<ExhibitionState, DeleteExhibitionRequest>(_deleteExhibitionRequest),
  TypedReducer<ExhibitionState, DeleteExhibitionSuccess>(_deleteExhibitionSuccess),
  TypedReducer<ExhibitionState, DeleteExhibitionFailure>(_deleteExhibitionFailure),
]);

ExhibitionState _deleteExhibitionRequest(ExhibitionState exhibitionState, DeleteExhibitionRequest action) {
  var exhibition = exhibitionState.map[action.exhibitionId].rebuild((b) => b
  );

  return exhibitionState.rebuild((b) => b
    ..map[action.exhibitionId] = exhibition
  );
}

ExhibitionState _deleteExhibitionSuccess(ExhibitionState exhibitionState, DeleteExhibitionSuccess action) {
  return exhibitionState.rebuild((b) => b
    ..map[action.exhibition.id] = action.exhibition
  );
}

ExhibitionState _deleteExhibitionFailure(ExhibitionState exhibitionState, DeleteExhibitionFailure action) {
  return exhibitionState.rebuild((b) => b
    ..map[action.exhibition.id] = action.exhibition
  );
}

ExhibitionState _addExhibition(
    ExhibitionState exhibitionState, AddExhibitionSuccess action) {
  return exhibitionState.rebuild((b) => b
    ..map[action.exhibition.id] = action.exhibition
    ..list.add(action.exhibition.id)
  );
}

ExhibitionState _updateExhibition(
    ExhibitionState exhibitionState, SaveExhibitionSuccess action) {
  return exhibitionState.rebuild((b) => b
      ..map[action.exhibition.id] = action.exhibition
  );
}

ExhibitionState _setNoExhibitions(
    ExhibitionState exhibitionState, LoadExhibitionsFailure action) {
  return exhibitionState;
}

ExhibitionState _setLoadedExhibitions(
    ExhibitionState exhibitionState, LoadExhibitionsSuccess action) {
  return exhibitionState.rebuild(
    (b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(Map.fromIterable(
        action.exhibitions,
        key: (item) => item.id,
        value: (item) => item,
      ))
      ..list.replace(action.exhibitions.map(
              (exhibition) => exhibition.id).toList())
  );
}
