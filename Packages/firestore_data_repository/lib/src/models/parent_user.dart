import 'package:firestore_data_repository/src/entities/entities.dart';
import 'package:meta/meta.dart';

@immutable
class ParentUser {
  final String name;
  final String userId;
  final String phoneNumber;
  final bool isMaster;
  final List<String> children;

  ParentUser(
      {this.isMaster = true,
      String? name = 'No name',
      String? phoneNumber = 'No number',
      required this.userId,
      required this.children})
      : this.name = name ?? '',
        this.phoneNumber = phoneNumber ?? '';

  ParentUser copyWith(
      {String? name, String? phoneNumber, List<String>? children}) {
    return ParentUser(
        userId: userId,
        children: children ?? this.children,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isMaster: isMaster);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        isMaster.hashCode ^
        children.hashCode ^
        phoneNumber.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ParentUser &&
            runtimeType == other.runtimeType &&
            userId == other.userId &&
            name == other.name &&
            isMaster == other.isMaster &&
            children == other.children &&
            phoneNumber == other.phoneNumber;
  }

  @override
  String toString() {
    return "ParentUser { name: $name, userId: $userId, isMaster: $isMaster, phoneNumber: $phoneNumber, children: $children} ";
  }

  ParentUserEntity toEntity() {
    return ParentUserEntity(
        name: name,
        userId: userId,
        isMaster: isMaster,
        phoneNumber: phoneNumber,
        children: children);
  }

  static fromEntity(ParentUserEntity entity) {
    return ParentUser(
        userId: entity.userId,
        children: entity.children ?? [],
        name: entity.name,
        phoneNumber: entity.phoneNumber,
        isMaster: entity.isMaster);
  }
}
