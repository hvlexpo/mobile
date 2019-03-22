import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:expo/data/models/models.dart';
import 'package:expo/redux/app/data_state.dart';
import 'package:expo/redux/auth/auth_state.dart';
import 'package:expo/redux/ui/entity_ui_state.dart';
import 'package:expo/redux/ui/list_ui_state.dart';
import 'package:expo/redux/ui/ui_state.dart';
import 'package:expo/redux/user/user_state.dart';

import 'package:expo/redux/exhibition/exhibition_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  bool get isLoading;
  AuthState get authState;
  UIState get uiState;
  DataState get dataState;

  factory AppState() {
    return _$AppState._(
      isLoading: false,
      authState: AuthState(),
      uiState: UIState(),
      dataState: DataState(),
    );
  }

  AppState._();
  static Serializer<AppState> get serializer => _$appStateSerializer;

  EntityUIState getUIState(EntityType type) {
    switch (type) {
      case EntityType.user:
        return userUIState;

      case EntityType.exhibition:
        return exhibitionUIState;

      default:
        return null;
    }
  }

  ListUIState getListState(EntityType type) {
    return getUIState(type).listUIState;
  }

  UserState get userState => this.dataState.userState;
  ListUIState get userListState => this.uiState.userUIState.listUIState;
  UserUIState get userUIState => this.uiState.userUIState;

  ExhibitionState get exhibitionState => this.dataState.exhibitionState;
  ListUIState get exhibitionListState =>
      this.uiState.exhibitionUIState.listUIState;
  ExhibitionUIState get exhibitionUIState => this.uiState.exhibitionUIState;

  /*
  @override
  String toString() {
    return 'Is Loading: ${this.isLoading}';
  }
  */
}
