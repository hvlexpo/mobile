import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/redux/ui/list_ui_state.dart';

var memoizedExhibitionList = memo3((
    BuiltMap<String, ExhibitionEntity> exhibitionMap,
    BuiltList<String> exhibitionList,
    ListUIState exhibitionListState) => visibleExhibitionsSelector(exhibitionMap, exhibitionList, exhibitionListState)
);

List<String> visibleExhibitionsSelector(
    BuiltMap<String, ExhibitionEntity> exhibitionMap,
    BuiltList<String> exhibitionList,
    ListUIState exhibitionListState) {

  var list = exhibitionList.where((exhibitionId) {
    var exhibition = exhibitionMap[exhibitionId];
    return exhibition.matchesSearch(exhibitionListState.search);
  }).toList();

  list.sort((exhibitionAId, exhibitionBId) {
    var exhibitionA = exhibitionMap[exhibitionAId];
    var exhibitionB = exhibitionMap[exhibitionBId];
    return exhibitionA.compareTo(exhibitionB, exhibitionListState.sortField, exhibitionListState.sortAscending);
  });

  return list;
}