import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/utils/routes.dart';
import 'package:redux/redux.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/ui/user/edit/user_edit.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/ui/app/icon_message.dart';

class UserEditScreen extends StatelessWidget {
  static final String route = '/user/edit';
  UserEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserEditVM>(
      converter: (Store<AppState> store) {
        return UserEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return UserEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class UserEditVM {
  final UserEntity user;
  final Function(UserEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function onBackPressed;
  final bool isLoading;

  UserEditVM({
    @required this.user,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.isLoading,
  });

  factory UserEditVM.fromStore(Store<AppState> store) {
    final user = store.state.userUIState.selected;

    return UserEditVM(
      isLoading: store.state.isLoading,
      user: user,
      onChanged: (UserEntity user) {
        store.dispatch(UpdateUser(user));
      },
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(Routes.user));
      },
      onSavePressed: (BuildContext context) {
        final Completer<Null> completer = new Completer<Null>();
        store.dispatch(SaveUserRequest(completer: completer, user: user));
        return completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: IconMessage(
                message: user.isNew
                    ? 'Successfully Created User'
                    : 'Successfully Updated User',
              ),
              duration: Duration(seconds: 3)));
        });
      },
    );
  }
}
