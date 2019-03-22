import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:expo/redux/app/app_middleware.dart';
import 'package:expo/redux/app/app_state.dart';
import 'package:expo/redux/app/app_reducer.dart';
import 'package:expo/redux/auth/auth_middleware.dart';
import 'package:expo/ui/app/init.dart';
import 'package:expo/ui/auth/login_vm.dart';
import 'package:expo/ui/home/home_screen.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/ui/user/user_screen.dart';
import 'package:expo/ui/user/edit/user_edit_vm.dart';
import 'package:expo/ui/user/view/user_view_vm.dart';
import 'package:expo/redux/user/user_actions.dart';
import 'package:expo/redux/user/user_middleware.dart';

import 'package:expo/ui/exhibition/exhibition_screen.dart';
import 'package:expo/ui/exhibition/edit/exhibition_edit_vm.dart';
import 'package:expo/ui/exhibition/view/exhibition_view_vm.dart';
import 'package:expo/redux/exhibition/exhibition_actions.dart';
import 'package:expo/redux/exhibition/exhibition_middleware.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState(),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll(createStorePersistenceMiddleware())
        ..addAll(createStoreUsersMiddleware())
        ..addAll(createStoreExhibitionsMiddleware())
        ..addAll([
          LoggingMiddleware.printer(),
        ]));

  runApp(ExpoApp(store: store));
}

class ExpoApp extends StatefulWidget {
  final Store<AppState> store;

  ExpoApp({Key key, this.store}) : super(key: key);

  @override
  _ExpoAppState createState() => _ExpoAppState();
}

class _ExpoAppState extends State<ExpoApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'HVL Expo',
        debugShowCheckedModeBanner: false,
        theme: ExpoTheme.primaryTheme,
        routes: {
          InitScreen.route: (context) => InitScreen(),
          LoginScreen.route: (context) => LoginScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          UserScreen.route: (context) {
            widget.store.dispatch(LoadUsers());
            return UserScreen();
          },
          UserViewScreen.route: (context) => UserViewScreen(),
          UserEditScreen.route: (context) => UserEditScreen(),
          ExhibitionScreen.route: (context) {
            widget.store.dispatch(LoadExhibitions());
            return ExhibitionScreen();
          },
          ExhibitionViewScreen.route: (context) => ExhibitionViewScreen(),
          ExhibitionEditScreen.route: (context) => ExhibitionEditScreen(),
        },
      ),
    );
  }
}
