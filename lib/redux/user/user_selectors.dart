import 'package:memoize/memoize.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/redux/ui/list_ui_state.dart';

var memoizedUserList = memo3((
    BuiltMap<String, UserEntity> userMap,
    BuiltList<String> userList,
    ListUIState userListState) => visibleUsersSelector(userMap, userList, userListState)
);

List<String> visibleUsersSelector(
    BuiltMap<String, UserEntity> userMap,
    BuiltList<String> userList,
    ListUIState userListState) {

  var list = userList.where((userId) {
    var user = userMap[userId];
    return user.matchesSearch(userListState.search);
  }).toList();

  list.sort((userAId, userBId) {
    var userA = userMap[userAId];
    var userB = userMap[userBId];
    return userA.compareTo(userB, userListState.sortField, userListState.sortAscending);
  });

  return list;
}