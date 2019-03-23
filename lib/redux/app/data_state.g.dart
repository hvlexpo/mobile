// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DataState> _$dataStateSerializer = new _$DataStateSerializer();

class _$DataStateSerializer implements StructuredSerializer<DataState> {
  @override
  final Iterable<Type> types = const [DataState, _$DataState];
  @override
  final String wireName = 'DataState';

  @override
  Iterable serialize(Serializers serializers, DataState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userState',
      serializers.serialize(object.userState,
          specifiedType: const FullType(UserState)),
      'exhibitionState',
      serializers.serialize(object.exhibitionState,
          specifiedType: const FullType(ExhibitionState)),
    ];

    return result;
  }

  @override
  DataState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'userState':
          result.userState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserState)) as UserState);
          break;
        case 'exhibitionState':
          result.exhibitionState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExhibitionState))
              as ExhibitionState);
          break;
      }
    }

    return result.build();
  }
}

class _$DataState extends DataState {
  @override
  final UserState userState;
  @override
  final ExhibitionState exhibitionState;

  factory _$DataState([void updates(DataStateBuilder b)]) =>
      (new DataStateBuilder()..update(updates)).build();

  _$DataState._({this.userState, this.exhibitionState}) : super._() {
    if (userState == null) {
      throw new BuiltValueNullFieldError('DataState', 'userState');
    }
    if (exhibitionState == null) {
      throw new BuiltValueNullFieldError('DataState', 'exhibitionState');
    }
  }

  @override
  DataState rebuild(void updates(DataStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DataStateBuilder toBuilder() => new DataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DataState &&
        userState == other.userState &&
        exhibitionState == other.exhibitionState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userState.hashCode), exhibitionState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DataState')
          ..add('userState', userState)
          ..add('exhibitionState', exhibitionState))
        .toString();
  }
}

class DataStateBuilder implements Builder<DataState, DataStateBuilder> {
  _$DataState _$v;

  UserStateBuilder _userState;
  UserStateBuilder get userState =>
      _$this._userState ??= new UserStateBuilder();
  set userState(UserStateBuilder userState) => _$this._userState = userState;

  ExhibitionStateBuilder _exhibitionState;
  ExhibitionStateBuilder get exhibitionState =>
      _$this._exhibitionState ??= new ExhibitionStateBuilder();
  set exhibitionState(ExhibitionStateBuilder exhibitionState) =>
      _$this._exhibitionState = exhibitionState;

  DataStateBuilder();

  DataStateBuilder get _$this {
    if (_$v != null) {
      _userState = _$v.userState?.toBuilder();
      _exhibitionState = _$v.exhibitionState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DataState;
  }

  @override
  void update(void updates(DataStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DataState build() {
    _$DataState _$result;
    try {
      _$result = _$v ??
          new _$DataState._(
              userState: userState.build(),
              exhibitionState: exhibitionState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userState';
        userState.build();
        _$failedField = 'exhibitionState';
        exhibitionState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
