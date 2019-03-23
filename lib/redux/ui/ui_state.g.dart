// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable serialize(Serializers serializers, UIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currentRoute',
      serializers.serialize(object.currentRoute,
          specifiedType: const FullType(String)),
      'userUIState',
      serializers.serialize(object.userUIState,
          specifiedType: const FullType(UserUIState)),
      'exhibitionUIState',
      serializers.serialize(object.exhibitionUIState,
          specifiedType: const FullType(ExhibitionUIState)),
    ];

    return result;
  }

  @override
  UIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentRoute':
          result.currentRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userUIState':
          result.userUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserUIState)) as UserUIState);
          break;
        case 'exhibitionUIState':
          result.exhibitionUIState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExhibitionUIState))
              as ExhibitionUIState);
          break;
      }
    }

    return result.build();
  }
}

class _$UIState extends UIState {
  @override
  final String currentRoute;
  @override
  final UserUIState userUIState;
  @override
  final ExhibitionUIState exhibitionUIState;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._({this.currentRoute, this.userUIState, this.exhibitionUIState})
      : super._() {
    if (currentRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'currentRoute');
    }
    if (userUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'userUIState');
    }
    if (exhibitionUIState == null) {
      throw new BuiltValueNullFieldError('UIState', 'exhibitionUIState');
    }
  }

  @override
  UIState rebuild(void updates(UIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UIStateBuilder toBuilder() => new UIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UIState &&
        currentRoute == other.currentRoute &&
        userUIState == other.userUIState &&
        exhibitionUIState == other.exhibitionUIState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, currentRoute.hashCode), userUIState.hashCode),
        exhibitionUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('currentRoute', currentRoute)
          ..add('userUIState', userUIState)
          ..add('exhibitionUIState', exhibitionUIState))
        .toString();
  }
}

class UIStateBuilder implements Builder<UIState, UIStateBuilder> {
  _$UIState _$v;

  String _currentRoute;
  String get currentRoute => _$this._currentRoute;
  set currentRoute(String currentRoute) => _$this._currentRoute = currentRoute;

  UserUIStateBuilder _userUIState;
  UserUIStateBuilder get userUIState =>
      _$this._userUIState ??= new UserUIStateBuilder();
  set userUIState(UserUIStateBuilder userUIState) =>
      _$this._userUIState = userUIState;

  ExhibitionUIStateBuilder _exhibitionUIState;
  ExhibitionUIStateBuilder get exhibitionUIState =>
      _$this._exhibitionUIState ??= new ExhibitionUIStateBuilder();
  set exhibitionUIState(ExhibitionUIStateBuilder exhibitionUIState) =>
      _$this._exhibitionUIState = exhibitionUIState;

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _currentRoute = _$v.currentRoute;
      _userUIState = _$v.userUIState?.toBuilder();
      _exhibitionUIState = _$v.exhibitionUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UIState;
  }

  @override
  void update(void updates(UIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UIState build() {
    _$UIState _$result;
    try {
      _$result = _$v ??
          new _$UIState._(
              currentRoute: currentRoute,
              userUIState: userUIState.build(),
              exhibitionUIState: exhibitionUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userUIState';
        userUIState.build();
        _$failedField = 'exhibitionUIState';
        exhibitionUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
