// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibition_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ExhibitionEntity> _$exhibitionEntitySerializer =
    new _$ExhibitionEntitySerializer();

class _$ExhibitionEntitySerializer
    implements StructuredSerializer<ExhibitionEntity> {
  @override
  final Iterable<Type> types = const [ExhibitionEntity, _$ExhibitionEntity];
  @override
  final String wireName = 'ExhibitionEntity';

  @override
  Iterable serialize(Serializers serializers, ExhibitionEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'photos',
      serializers.serialize(object.photos,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.votes != null) {
      result
        ..add('votes')
        ..add(serializers.serialize(object.votes,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(int)])));
    }

    return result;
  }

  @override
  ExhibitionEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ExhibitionEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photos':
          result.photos.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'votes':
          result.votes.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(int)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$ExhibitionEntity extends ExhibitionEntity {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final BuiltList<String> photos;
  @override
  final BuiltMap<String, int> votes;

  factory _$ExhibitionEntity([void updates(ExhibitionEntityBuilder b)]) =>
      (new ExhibitionEntityBuilder()..update(updates)).build();

  _$ExhibitionEntity._(
      {this.id, this.name, this.description, this.photos, this.votes})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ExhibitionEntity', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ExhibitionEntity', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ExhibitionEntity', 'description');
    }
    if (photos == null) {
      throw new BuiltValueNullFieldError('ExhibitionEntity', 'photos');
    }
  }

  @override
  ExhibitionEntity rebuild(void updates(ExhibitionEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ExhibitionEntityBuilder toBuilder() =>
      new ExhibitionEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExhibitionEntity &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        photos == other.photos &&
        votes == other.votes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), description.hashCode),
            photos.hashCode),
        votes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ExhibitionEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('photos', photos)
          ..add('votes', votes))
        .toString();
  }
}

class ExhibitionEntityBuilder
    implements Builder<ExhibitionEntity, ExhibitionEntityBuilder> {
  _$ExhibitionEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  ListBuilder<String> _photos;
  ListBuilder<String> get photos =>
      _$this._photos ??= new ListBuilder<String>();
  set photos(ListBuilder<String> photos) => _$this._photos = photos;

  MapBuilder<String, int> _votes;
  MapBuilder<String, int> get votes =>
      _$this._votes ??= new MapBuilder<String, int>();
  set votes(MapBuilder<String, int> votes) => _$this._votes = votes;

  ExhibitionEntityBuilder();

  ExhibitionEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _description = _$v.description;
      _photos = _$v.photos?.toBuilder();
      _votes = _$v.votes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExhibitionEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ExhibitionEntity;
  }

  @override
  void update(void updates(ExhibitionEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ExhibitionEntity build() {
    _$ExhibitionEntity _$result;
    try {
      _$result = _$v ??
          new _$ExhibitionEntity._(
              id: id,
              name: name,
              description: description,
              photos: photos.build(),
              votes: _votes?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'photos';
        photos.build();
        _$failedField = 'votes';
        _votes?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ExhibitionEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
