import 'package:redux/redux.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/redux/ui/entity_ui_state.dart';
import 'package:expo/redux/ui/list_ui_state.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/redux/user/user_state.dart';

EntityUIState userUIReducer(UserUIState state, action) {
  return state.rebuild((b) => b
    ..listUIState.replace(userListReducer(state.listUIState, action))
    ..selected.replace(editingReducer(state.selected, action))
  );
}

final editingReducer = combineReducers<UserEntity>([
  TypedReducer<UserEntity, SaveUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, AddUserSuccess>(_updateEditing),
  TypedReducer<UserEntity, ViewUser>(_updateEditing),
  TypedReducer<UserEntity, EditUser>(_updateEditing),
  TypedReducer<UserEntity, UpdateUser>(_updateEditing),
]);

/*
UserEntity  _clearEditing(UserEntity user, action) {
  return UserEntity();
}
*/

UserEntity _updateEditing(UserEntity user, action) {
  return action.user;
}

final userListReducer = combineReducers<ListUIState>([
  TypedReducer<ListUIState, SortUsers>(_sortUsers),
  TypedReducer<ListUIState, SearchUsers>(_searchUsers),
]);

ListUIState _searchUsers(ListUIState userListState, SearchUsers action) {
  return userListState.rebuild((b) => b
    ..search = action.search
  );
}

ListUIState _sortUsers(ListUIState userListState, SortUsers action) {
  return userListState.rebuild((b) => b
      ..sortAscending = b.sortField != action.field || ! b.sortAscending
      ..sortField = action.field
  );
}


final usersReducer = combineReducers<UserState>([
  TypedReducer<UserState, SaveUserSuccess>(_updateUser),
  TypedReducer<UserState, AddUserSuccess>(_addUser),
  TypedReducer<UserState, LoadUsersSuccess>(_setLoadedUsers),
  TypedReducer<UserState, LoadUsersFailure>(_setNoUsers),

  TypedReducer<UserState, DeleteUserRequest>(_deleteUserRequest),
  TypedReducer<UserState, DeleteUserSuccess>(_deleteUserSuccess),
  TypedReducer<UserState, DeleteUserFailure>(_deleteUserFailure),
]);

UserState _deleteUserRequest(UserState userState, DeleteUserRequest action) {
  var user = userState.map[action.userId].rebuild((b) => b
  );

  return userState.rebuild((b) => b
    ..map[action.userId] = user
  );
}

UserState _deleteUserSuccess(UserState userState, DeleteUserSuccess action) {
  return userState.rebuild((b) => b
    ..map[action.user.id] = action.user
  );
}

UserState _deleteUserFailure(UserState userState, DeleteUserFailure action) {
  return userState.rebuild((b) => b
    ..map[action.user.id] = action.user
  );
}

UserState _addUser(
    UserState userState, AddUserSuccess action) {
  return userState.rebuild((b) => b
    ..map[action.user.id] = action.user
    ..list.add(action.user.id)
  );
}

UserState _updateUser(
    UserState userState, SaveUserSuccess action) {
  return userState.rebuild((b) => b
      ..map[action.user.id] = action.user
  );
}

UserState _setNoUsers(
    UserState userState, LoadUsersFailure action) {
  return userState;
}

UserState _setLoadedUsers(
    UserState userState, LoadUsersSuccess action) {
  return userState.rebuild(
    (b) => b
      ..lastUpdated = DateTime.now().millisecondsSinceEpoch
      ..map.addAll(Map.fromIterable(
        action.users,
        key: (item) => item.id,
        value: (item) => item,
      ))
      ..list.replace(action.users.map(
              (user) => user.id).toList())
  );
}
