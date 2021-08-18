import 'package:firestore_data_repository/src/entities/entities.dart';
import 'package:meta/meta.dart';

@immutable
class ChildUser {
  final String name;
  final String userId;
  final String? phoneNumber;
  final bool isMaster;
  final String parent;

  ChildUser(
      {this.isMaster = false,
      String? name = 'No name',
      String? phoneNumber = 'No number',
      required this.userId,
      required this.parent})
      : this.name = name ?? '',
        this.phoneNumber = phoneNumber ?? '';

  ChildUser copyWith({String? name, String? phoneNumber, String? parent}) {
    return ChildUser(
        userId: userId,
        parent: parent ?? this.parent,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isMaster: isMaster);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        isMaster.hashCode ^
        parent.hashCode ^
        phoneNumber.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChildUser &&
            runtimeType == other.runtimeType &&
            userId == other.userId &&
            name == other.name &&
            isMaster == other.isMaster &&
            parent == other.parent &&
            phoneNumber == other.phoneNumber;
  }

  @override
  String toString() {
    return "ChildUser { name: $name, userId: $userId, isMaster: $isMaster, phoneNumber: $phoneNumber, parent: $parent} ";
  }

  ChildUserEntity toEntity() {
    return ChildUserEntity(
        name: name,
        userId: userId,
        isMaster: isMaster,
        phoneNumber: phoneNumber,
        parent: parent);
  }

  static fromEntity(ChildUserEntity entity) {
    return ChildUser(
        userId: entity.userId,
        parent: entity.parent,
        name: entity.name,
        phoneNumber: entity.phoneNumber,
        isMaster: entity.isMaster);
  }
}
