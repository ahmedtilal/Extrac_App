import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ParentUserEntity extends Equatable {
  final String name;
  final String userId;
  final String? phoneNumber;
  final bool isMaster;
  final List<String>? children;

  const ParentUserEntity(
      {required this.name,
      required this.userId,
      required this.isMaster,
      this.children,
      this.phoneNumber});

  static ParentUserEntity fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return ParentUserEntity(
        name: data['name'],
        userId: data['userId'],
        isMaster: data['isMaster'],
        children: data['children'],
        phoneNumber: data['phoneNumber']);
  }

  Map<String, Object?> toDocumentSnapshot() {
    return {
      'name': name,
      'userId': userId,
      'isMaster': isMaster,
      'phoneNumber': phoneNumber,
      'children': children
    };
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "userId": userId,
      "isMaster": isMaster,
      "phoneNumber": phoneNumber,
      "children": children
    };
  }

  static ParentUserEntity fromJson(Map<String, Object> json) {
    return ParentUserEntity(
      name: json['name'] as String,
      userId: json['userId'] as String,
      isMaster: json['isMaster'] as bool,
      phoneNumber: json['phoneNumber'] as String,
      children: json['children'] as List<String>,
    );
  }

  @override
  String toString() {
    return "ParentUserEntity { name: $name, userId: $userId, isMaster: $isMaster, phoneNumber: $phoneNumber, children: $children} ";
  }

  @override
  List<Object?> get props =>
      [name, userId, userId, isMaster, children, phoneNumber];
}
