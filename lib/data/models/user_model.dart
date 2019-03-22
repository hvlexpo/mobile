import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:expo/data/models/models.dart';
import 'package:uuid/uuid.dart';

part 'user_model.g.dart';

class UserFields {
  static const String id = 'id';
}

abstract class UserEntity extends Object
    with BaseEntity
    implements Built<UserEntity, UserEntityBuilder> {
  String get id;

  factory UserEntity() {
    return _$UserEntity._(
      id: Uuid().v4(),
    );
  }

  String get displayName {
    return id;
  }

  int compareTo(UserEntity user, String sortField, bool sortAscending) {
    int response = 0;
    UserEntity userA = sortAscending ? this : user;
    UserEntity userB = sortAscending ? user : this;

    switch (sortField) {
      case UserFields.id:
        response = userA.id.compareTo(userB.id);
        break;
    }

    if (response == 0) {
      return userA.id.compareTo(userB.id);
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

    return false;
  }

  UserEntity._();
  static Serializer<UserEntity> get serializer => _$userEntitySerializer;
}
