import 'dart:async';
import 'package:redux/redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/user/user_selectors.dart';
import 'package:expo/ui/app/icon_message.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/ui/user/user_list.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/redux/user/user_actions.dart';

class UserListBuilder extends StatelessWidget {
  static final String route = '/users/edit';
  UserListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserListVM>(
      converter: UserListVM.fromStore,
      builder: (context, vm) {
        return UserList(
          viewModel: vm,
        );
      },
    );
  }
}

class UserListVM {
  final List<String> userList;
  final BuiltMap<String, UserEntity> userMap;
  final bool isLoading;
  final bool isLoaded;
  final Function(BuildContext, UserEntity) onUserTap;
  final Function(BuildContext, UserEntity, DismissDirection) onDismissed;
  final Function(BuildContext) onRefreshed;

  UserListVM({
    @required this.userList,
    @required this.userMap,
    @required this.isLoading,
    @required this.isLoaded,
    @required this.onUserTap,
    @required this.onDismissed,
    @required this.onRefreshed,
  });

  static UserListVM fromStore(Store<AppState> store) {
    Future<Null> _handleRefresh(BuildContext context) {
      final Completer<Null> completer = new Completer<Null>();
      store.dispatch(LoadUsers(completer, true));
      return completer.future.then((_) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: IconMessage(
              message: 'Refresh complete',
            ),
            duration: Duration(seconds: 3)));
      });
    }

    return UserListVM(
        userList: memoizedUserList(store.state.userState.map,
            store.state.userState.list, store.state.userListState),
        userMap: store.state.userState.map,
        isLoading: store.state.isLoading,
        isLoaded: store.state.userState.isLoaded,
        onUserTap: (context, user) {
          store.dispatch(ViewUser(user: user, context: context));
        },
        onRefreshed: (context) => _handleRefresh(context),
        onDismissed: (BuildContext context, UserEntity user,
            DismissDirection direction) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(DeleteUserRequest(completer, user.id));
          var message = 'Successfully Deleted User';
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: IconMessage(
                  message: message,
                ),
                duration: Duration(seconds: 3)));
          });
        });
  }
}
