// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibition_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExhibitionState> _$exhibitionStateSerializer =
    new _$ExhibitionStateSerializer();
Serializer<ExhibitionUIState> _$exhibitionUIStateSerializer =
    new _$ExhibitionUIStateSerializer();

class _$ExhibitionStateSerializer
    implements StructuredSerializer<ExhibitionState> {
  @override
  final Iterable<Type> types = const [ExhibitionState, _$ExhibitionState];
  @override
  final String wireName = 'ExhibitionState';

  @override
  Iterable serialize(Serializers serializers, ExhibitionState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'map',
      serializers.serialize(object.map,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(ExhibitionEntity)
          ])),
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
  ExhibitionState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExhibitionStateBuilder();

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
                const FullType(ExhibitionEntity)
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

class _$ExhibitionUIStateSerializer
    implements StructuredSerializer<ExhibitionUIState> {
  @override
  final Iterable<Type> types = const [ExhibitionUIState, _$ExhibitionUIState];
  @override
  final String wireName = 'ExhibitionUIState';

  @override
  Iterable serialize(Serializers serializers, ExhibitionUIState object,
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
            specifiedType: const FullType(ExhibitionEntity)));
    }

    return result;
  }

  @override
  ExhibitionUIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExhibitionUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'selected':
          result.selected.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ExhibitionEntity))
              as ExhibitionEntity);
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

class _$ExhibitionState extends ExhibitionState {
  @override
  final int lastUpdated;
  @override
  final BuiltMap<String, ExhibitionEntity> map;
  @override
  final BuiltList<String> list;

  factory _$ExhibitionState([void updates(ExhibitionStateBuilder b)]) =>
      (new ExhibitionStateBuilder()..update(updates)).build();

  _$ExhibitionState._({this.lastUpdated, this.map, this.list}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('ExhibitionState', 'map');
    }
    if (list == null) {
      throw new BuiltValueNullFieldError('ExhibitionState', 'list');
    }
  }

  @override
  ExhibitionState rebuild(void updates(ExhibitionStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExhibitionStateBuilder toBuilder() =>
      new ExhibitionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExhibitionState &&
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
    return (newBuiltValueToStringHelper('ExhibitionState')
          ..add('lastUpdated', lastUpdated)
          ..add('map', map)
          ..add('list', list))
        .toString();
  }
}

class ExhibitionStateBuilder
    implements Builder<ExhibitionState, ExhibitionStateBuilder> {
  _$ExhibitionState _$v;

  int _lastUpdated;
  int get lastUpdated => _$this._lastUpdated;
  set lastUpdated(int lastUpdated) => _$this._lastUpdated = lastUpdated;

  MapBuilder<String, ExhibitionEntity> _map;
  MapBuilder<String, ExhibitionEntity> get map =>
      _$this._map ??= new MapBuilder<String, ExhibitionEntity>();
  set map(MapBuilder<String, ExhibitionEntity> map) => _$this._map = map;

  ListBuilder<String> _list;
  ListBuilder<String> get list => _$this._list ??= new ListBuilder<String>();
  set list(ListBuilder<String> list) => _$this._list = list;

  ExhibitionStateBuilder();

  ExhibitionStateBuilder get _$this {
    if (_$v != null) {
      _lastUpdated = _$v.lastUpdated;
      _map = _$v.map?.toBuilder();
      _list = _$v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExhibitionState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExhibitionState;
  }

  @override
  void update(void updates(ExhibitionStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ExhibitionState build() {
    _$ExhibitionState _$result;
    try {
      _$result = _$v ??
          new _$ExhibitionState._(
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
            'ExhibitionState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ExhibitionUIState extends ExhibitionUIState {
  @override
  final ExhibitionEntity selected;
  @override
  final ListUIState listUIState;

  factory _$ExhibitionUIState([void updates(ExhibitionUIStateBuilder b)]) =>
      (new ExhibitionUIStateBuilder()..update(updates)).build();

  _$ExhibitionUIState._({this.selected, this.listUIState}) : super._() {
    if (listUIState == null) {
      throw new BuiltValueNullFieldError('ExhibitionUIState', 'listUIState');
    }
  }

  @override
  ExhibitionUIState rebuild(void updates(ExhibitionUIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExhibitionUIStateBuilder toBuilder() =>
      new ExhibitionUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExhibitionUIState &&
        selected == other.selected &&
        listUIState == other.listUIState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selected.hashCode), listUIState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExhibitionUIState')
          ..add('selected', selected)
          ..add('listUIState', listUIState))
        .toString();
  }
}

class ExhibitionUIStateBuilder
    implements Builder<ExhibitionUIState, ExhibitionUIStateBuilder> {
  _$ExhibitionUIState _$v;

  ExhibitionEntityBuilder _selected;
  ExhibitionEntityBuilder get selected =>
      _$this._selected ??= new ExhibitionEntityBuilder();
  set selected(ExhibitionEntityBuilder selected) => _$this._selected = selected;

  ListUIStateBuilder _listUIState;
  ListUIStateBuilder get listUIState =>
      _$this._listUIState ??= new ListUIStateBuilder();
  set listUIState(ListUIStateBuilder listUIState) =>
      _$this._listUIState = listUIState;

  ExhibitionUIStateBuilder();

  ExhibitionUIStateBuilder get _$this {
    if (_$v != null) {
      _selected = _$v.selected?.toBuilder();
      _listUIState = _$v.listUIState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExhibitionUIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExhibitionUIState;
  }

  @override
  void update(void updates(ExhibitionUIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ExhibitionUIState build() {
    _$ExhibitionUIState _$result;
    try {
      _$result = _$v ??
          new _$ExhibitionUIState._(
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
            'ExhibitionUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
