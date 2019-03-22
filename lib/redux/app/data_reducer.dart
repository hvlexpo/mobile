import 'package:expo/redux/app/data_state.dart';
import 'package:expo/redux/user/user_reducer.dart';

import 'package:expo/redux/exhibition/exhibition_reducer.dart';

DataState dataReducer(DataState state, action) {
  return state.rebuild((b) => b
    ..userState.replace(usersReducer(state.userState, action))
    ..exhibitionState
        .replace(exhibitionsReducer(state.exhibitionState, action)));
}
