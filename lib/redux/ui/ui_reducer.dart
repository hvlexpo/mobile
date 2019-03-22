import 'package:expo/redux/ui/ui_actions.dart';
import 'package:expo/redux/ui/ui_state.dart';
import 'package:redux/redux.dart';
import 'package:expo/redux/user/user_reducer.dart';

import 'package:expo/redux/exhibition/exhibition_reducer.dart';

UIState uiReducer(UIState state, action) {
  return state.rebuild((b) => b
    ..currentRoute = currentRouteReducer(state.currentRoute, action)
    ..userUIState.replace(userUIReducer(state.userUIState, action))
    ..exhibitionUIState
        .replace(exhibitionUIReducer(state.exhibitionUIState, action)));
}

Reducer<String> currentRouteReducer = combineReducers([
  TypedReducer<String, UpdateCurrentRoute>(updateCurrentRouteReducer),
]);

String updateCurrentRouteReducer(
    String currentRoute, UpdateCurrentRoute action) {
  return action.route;
}
