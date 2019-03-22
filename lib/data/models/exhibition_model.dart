import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:expo/data/models/models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:uuid/uuid.dart';

part 'exhibition_model.g.dart';

class ExhibitionFields {
  static const String id = 'id';

  static const String name = 'name';

  static const String description = 'description';

  static const String photos = 'photos';

  static const String votes = 'votes';
}

abstract class ExhibitionEntity extends Object
    with BaseEntity
    implements Built<ExhibitionEntity, ExhibitionEntityBuilder> {
  String get id;

  String get name;

  String get description;

  BuiltList<String> get photos;

  @nullable
  BuiltMap<String, int> get votes;

  factory ExhibitionEntity() {
    return _$ExhibitionEntity._(
      id: Uuid().v4(),
      name: '',
      description: '',
      photos: BuiltList<String>(),
      votes: BuiltMap<String, int>(),
    );
  }

  String get displayName {
    return name;
  }

  int compareTo(
      ExhibitionEntity exhibition, String sortField, bool sortAscending) {
    int response = 0;
    ExhibitionEntity exhibitionA = sortAscending ? this : exhibition;
    ExhibitionEntity exhibitionB = sortAscending ? exhibition : this;

    switch (sortField) {
      case ExhibitionFields.id:
        response = exhibitionA.id.compareTo(exhibitionB.id);
        break;

      case ExhibitionFields.name:
        response = exhibitionA.name.compareTo(exhibitionB.name);
        break;

      case ExhibitionFields.description:
        response = exhibitionA.description.compareTo(exhibitionB.description);
        break;

      case ExhibitionFields.photos:
        //response = exhibitionA.photos.compareTo(exhibitionB.photos);
        break;

      case ExhibitionFields.votes:
        //response = exhibitionA.votes.compareTo(exhibitionB.votes);
        break;
    }

    if (response == 0) {
      return exhibitionA.id.compareTo(exhibitionB.id);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    if (id.toLowerCase().contains(search)) {
      return true;
    }

    if (name.toLowerCase().contains(search)) {
      return true;
    }

    if (description.toLowerCase().contains(search)) {
      return true;
    }

    if (photos.contains(search)) {
      return true;
    }

    if (votes.containsValue(search)) {
      return true;
    }

    return false;
  }

  ExhibitionEntity._();
  static Serializer<ExhibitionEntity> get serializer =>
      _$exhibitionEntitySerializer;
}
