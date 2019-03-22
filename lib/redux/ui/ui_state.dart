import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:expo/ui/home/home_screen.dart';
import 'package:expo/redux/user/user_state.dart';

import 'package:expo/redux/exhibition/exhibition_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  String get currentRoute;

  UserUIState get userUIState;

  ExhibitionUIState get exhibitionUIState;

  factory UIState() {
    return _$UIState._(
      //currentRoute: LoginScreen.route,
      currentRoute: HomeScreen.route,
      userUIState: UserUIState(),

      exhibitionUIState: ExhibitionUIState(),
    );
  }

  UIState._();
  static Serializer<UIState> get serializer => _$uIStateSerializer;
}
