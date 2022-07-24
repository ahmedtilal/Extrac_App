import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChildUserEntity extends Equatable {
  final String name;
  final String userId;
  final String? phoneNumber;
  final bool isMaster;
  final String parent;

  const ChildUserEntity(
      {required this.name,
      required this.userId,
      required this.isMaster,
      required this.parent,
      this.phoneNumber});

  static ChildUserEntity fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return ChildUserEntity(
        name: data['name'],
        userId: data['userId'],
        isMaster: data['isMaster'],
        parent: data['parent'],
        phoneNumber: data['phoneNumber']);
  }

  Map<String, Object?> toDocumentSnapshot() {
    return {
      'name': name,
      'userId': userId,
      'isMaster': isMaster,
      'phoneNumber': phoneNumber,
      'parent': parent
    };
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "userId": userId,
      "isMaster": isMaster,
      "phoneNumber": phoneNumber,
      "parent": parent
    };
  }

  static ChildUserEntity fromJson(Map<String, Object> json) {
    return ChildUserEntity(
      name: json['name'] as String,
      userId: json['userId'] as String,
      isMaster: json['isMaster'] as bool,
      phoneNumber: json['phoneNumber'] as String,
      parent: json['parent'] as String,
    );
  }

  @override
  String toString() {
    return "ParentUserEntity { name: $name, userId: $userId, isMaster: $isMaster, phoneNumber: $phoneNumber, parent: $parent} ";
  }

  @override
  List<Object?> get props =>
      [name, userId, userId, isMaster, parent, phoneNumber];
}
