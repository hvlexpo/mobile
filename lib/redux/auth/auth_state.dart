import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {

  String get phoneNumber;
  bool get isInitialized;
  bool get isAuthenticated;

  @nullable
  String get error;

  factory AuthState() {
    return _$AuthState._(
      phoneNumber: '',
      isAuthenticated: false,
      isInitialized: false,
    );
  }

  AuthState._();
  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
