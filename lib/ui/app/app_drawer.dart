import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/ui/app/app_drawer_vm.dart';
import 'package:expo/utils/routes.dart';
import 'package:redux/redux.dart';
import 'package:expo/redux/user/user_actions.dart';

import 'package:expo/redux/exhibition/exhibition_actions.dart';

class AppDrawer extends StatelessWidget {
  final AppDrawerVM viewModel;

  AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              child: Container(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              store.dispatch(UpdateCurrentRoute(Routes.home));
              navigator.pushReplacementNamed(Routes.home);
            },
          ),
          ListTile(
            leading: Icon(Icons.widgets),
            title: Text('Users'),
            onTap: () => store.dispatch(ViewUserList(context)),
          ),
          ListTile(
            leading: Icon(Icons.widgets),
            title: Text('Exhibitions'),
            onTap: () => store.dispatch(ViewExhibitionList(context)),
          ),
          AboutListTile(
            applicationName: '',
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
