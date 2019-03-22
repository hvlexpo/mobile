import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/ui/user/view/user_view.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/ui/app/icon_message.dart';

class UserViewScreen extends StatelessWidget {
  static final String route = '/user/view';
  UserViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserViewVM>(
      converter: (Store<AppState> store) {
        return UserViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return UserView(
          viewModel: vm,
        );
      },
    );
  }
}

class UserViewVM {
  final UserEntity user;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function(BuildContext) onEditPressed;
  final bool isLoading;

  UserViewVM({
    @required this.user,
    @required this.onActionSelected,
    @required this.onEditPressed,
    @required this.isLoading,
  });

  factory UserViewVM.fromStore(Store<AppState> store) {
    final user = store.state.userUIState.selected;

    return UserViewVM(
        isLoading: store.state.isLoading,
        user: user,
        onEditPressed: (BuildContext context) {
          store.dispatch(EditUser(user: user, context: context));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = new Completer<Null>();
          var message;
          switch (action) {
            case EntityAction.delete:
              store.dispatch(DeleteUserRequest(completer, user.id));
              message = 'Successfully Deleted User';
              break;
          }
          if (message != null) {
            return completer.future.then((_) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: IconMessage(
                    message: message,
                  ),
                  duration: Duration(seconds: 3)));
            });
          }
        }
    );
  }
}
