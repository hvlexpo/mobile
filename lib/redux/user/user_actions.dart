import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/redux/app/app_actions.dart';


class ViewUserList implements PersistUI {
  final BuildContext context;
  ViewUserList(this.context);
}

class ViewUser implements PersistUI {
  final UserEntity user;
  final BuildContext context;
  ViewUser({this.user, this.context});
}

class EditUser implements PersistUI {
  final UserEntity user;
  final BuildContext context;
  EditUser({this.user, this.context});
}


class LoadUsers {
  final Completer completer;
  final bool force;

  LoadUsers([this.completer, this.force = false]);
}

class LoadUsersRequest implements StartLoading {}

class LoadUsersFailure implements StopLoading {
  final dynamic error;
  LoadUsersFailure(this.error);

  @override
  String toString() {
    return 'LoadUsersFailure{error: $error}';
  }
}

class LoadUsersSuccess implements StopLoading, PersistData {
  final BuiltList<UserEntity> users;
  LoadUsersSuccess(this.users);

  @override
  String toString() {
    return 'LoadUsersSuccess{users: $users}';
  }
}


class UpdateUser implements PersistUI {
  final UserEntity user;
  UpdateUser(this.user);
}

class SaveUserRequest implements StartLoading {
  final Completer completer;
  final UserEntity user;
  SaveUserRequest({this.completer, this.user});
}

class AddUserSuccess implements StopLoading, PersistData {
  final UserEntity user;
  AddUserSuccess(this.user);
}


class SaveUserSuccess implements StopLoading, PersistData {
  final UserEntity user;

  SaveUserSuccess(this.user);
}

class SaveUserFailure implements StopLoading {
  final String error;
  SaveUserFailure (this.error);
}

class DeleteUserRequest implements StartLoading {
  final Completer completer;
  final String userId;

  DeleteUserRequest(this.completer, this.userId);
}

class DeleteUserSuccess implements StopLoading, PersistData {
  final UserEntity user;
  DeleteUserSuccess(this.user);
}

class DeleteUserFailure implements StopLoading {
  final UserEntity user;
  DeleteUserFailure(this.user);
}



class SearchUsers {
  final String search;
  SearchUsers(this.search);
}

class SortUsers implements PersistUI {
  final String field;
  SortUsers(this.field);
}
