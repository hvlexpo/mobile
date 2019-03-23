// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserState> _$userStateSerializer = new _$UserStateSerializer();
Serializer<UserUIState> _$userUIStateSerializer = new _$UserUIStateSerializer();

class _$UserStateSerializer implements StructuredSerializer<UserState> {
  @override
  final Iterable<Type> types = const [UserState, _$UserState];
  @override
  final String wireName = 'UserState';

  @override
  Iterable serialize(Serializers serializers, UserState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(UserEntity)])),
      'list',
      serializers.serialize(object.list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.lastUpdated != null) {
      result
        ..add('lastUpdated')
        ..add(serializers.serialize(object.lastUpdated,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  UserState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'map':
          result.map.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(UserEntity)
              ])) as BuiltMap);
          break;
        case 'list':
          result.list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$UserUIStateSerializer implements StructuredSerializer<UserUIState> {
  @override
  final Iterable<Type> types = const [UserUIState, _$UserUIState];
  @override
  final String wireName = 'UserUIState';

  @override
  Iterable serialize(Serializers serializers, UserUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listUIState',
      serializers.serialize(object.listUIState,
          specifiedType: const FullType(ListUIState)),
    ];
    if (object.selected != null) {
      result
        ..add('selected')
        ..add(serializers.serialize(object.selected,
            specifiedType: const FullType(UserEntity)));
    }

    return result;
  }

  @override
  UserUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'selected':
          result.selected.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity)) as UserEntity);
          break;
        case 'listUIState':
          result.listUIState.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListUIState)) as ListUIState);
          break;
      }
    }

    return result.build();
  }
}

class _$UserState extends UserState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<String, UserEntity> map;
  @override
  final BuiltList<String> list;

  factory _$UserState([void updates(UserStateBuilder b)]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('UserState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('UserState', 'list');
    }
  }

  @override
  UserState rebuild(void updates(UserStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        lastUpdated == other.lastUpdated &&
        map == other.map &&
        list == other.list;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, lastUpdated.hashCode), map.hashCode), list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<String, UserEntity> _map;
  MapBuilder<String, UserEntity> get map =>
      _$this._map ??= new MapBuilder<String, UserEntity>();
  set map(MapBuilder<String, UserEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void updates(UserStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    _$UserState _$result;
    try {
      _$result = _$v ??
          new _$UserState._(
              lastUpdated: lastUpdated, map: map.build(), list: list.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'list';
        list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UserUIState extends UserUIState {
  @override
  final UserEntity selected;
  @override
  final ListUIState listUIState;

  factory _$UserUIState([void updates(UserUIStateBuilder b)]) =>
      (new UserUIStateBuilder()..update(updates)).build();

  _$UserUIState._({this.selected, this.listUIState}) : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('UserUIState', 'listUIState');
    }
  }

  @override
  UserUIState rebuild(void updates(UserUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserUIStateBuilder toBuilder() => new UserUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserUIState &&
        selected == other.selected &&
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selected.hashCode), listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserUIState')
          ..add('selected', selected)
          ..add('listUIState', listUIState))
        .toString();
  }
}

class UserUIStateBuilder implements Builder<UserUIState, UserUIStateBuilder> {
  _$UserUIState _$v;

  UserEntityBuilder _selected;
  UserEntityBuilder get selected =>
      _$this._selected ??= new UserEntityBuilder();
  set selected(UserEntityBuilder selected) => _$this._selected = selected;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  UserUIStateBuilder();

  UserUIStateBuilder get _$this {
    if (_$v != null) {
      _selected = _$v.selected?.toBuilder();
      _listUIState = _$v.listUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserUIState;
  }

  @override
  void update(void updates(UserUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserUIState build() {
    _$UserUIState _$result;
    try {
      _$result = _$v ??
          new _$UserUIState._(
              selected: _selected?.build(), listUIState: listUIState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selected';
        _selected?.build();
        _$failedField = 'listUIState';
        listUIState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
