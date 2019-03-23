import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:expo/utils/routes.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/data/repositories/user_repository.dart';

List<Middleware<AppState>> createStoreUsersMiddleware([
  UserRepository repository = const UserRepository(),
]) {
  final viewUserList = _viewUserList();
  final viewUser = _viewUser();
  final editUser = _editUser();
  final loadUsers = _loadUsers(repository);
  final saveUser = _saveUser(repository);
  final deleteUser = _deleteUser(repository);

  return [
    TypedMiddleware<AppState, ViewUserList>(viewUserList),
    TypedMiddleware<AppState, ViewUser>(viewUser),
    TypedMiddleware<AppState, EditUser>(editUser),
    TypedMiddleware<AppState, LoadUsers>(loadUsers),
    TypedMiddleware<AppState, SaveUserRequest>(saveUser),
    TypedMiddleware<AppState, DeleteUserRequest>(deleteUser),
  ];
}

Middleware<AppState> _viewUserList() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(Routes.user));
    Navigator.of(action.context).pushReplacementNamed(Routes.user);
  };
}

Middleware<AppState> _viewUser() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(Routes.userView));
    Navigator.of(action.context).pushNamed(Routes.userView);
  };
}

Middleware<AppState> _editUser() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    store.dispatch(UpdateCurrentRoute(Routes.userEdit));
    Navigator.of(action.context).pushNamed(Routes.userEdit);
  };
}


Middleware<AppState> _deleteUser(UserRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    var origUser = store.state.userState.map[action.userId];
    repository
        .saveData(store.state.authState,
            origUser, EntityAction.delete)
        .then((user) {
      store.dispatch(DeleteUserSuccess(user));
      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(DeleteUserFailure(origUser));
    });

    next(action);
  };
}

Middleware<AppState> _saveUser(UserRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository
        .saveData(
            store.state.authState, action.user)
        .then((user) {
      if (action.user.isNew) {
        store.dispatch(AddUserSuccess(user));
      } else {
        store.dispatch(SaveUserSuccess(user));
      }
      action.completer.complete(null);
    }).catchError((error) {
      print(error);
      store.dispatch(SaveUserFailure(error));
    });

    next(action);
  };
}

Middleware<AppState> _loadUsers(UserRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {

    AppState state = store.state;

    if (!state.userState.isStale && !action.force) {
      next(action);
      return;
    }

    if (state.isLoading) {
      next(action);
      return;
    }

    store.dispatch(LoadUsersRequest());
    repository
        .loadList(state.authState)
        .then((data) {
      store.dispatch(LoadUsersSuccess(data));

      if (action.completer != null) {
        action.completer.complete(null);
      }
    }).catchError((error) {
      print(error);
      store.dispatch(LoadUsersFailure(error));
    });

    next(action);
  };
}
