import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String user;
  final int amount;
  final bool isApproved;
  final String category;
  final String? description;
  final DateTime time;

  const TransactionEntity(
      {required this.id,
      required this.user,
      required this.amount,
      required this.isApproved,
      required this.category,
      required this.time,
      this.description});

  static TransactionEntity fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return TransactionEntity(
        id: data['id'],
        user: data['user'],
        amount: data['amount'],
        isApproved: data['isApproved'],
        category: data['category'],
        time: data['time'],
        description: data['description']);
  }

  Map<String, Object?> toDocumentSnapshot() {
    return {
      'id': id,
      'user': user,
      'amount': amount,
      'isApproved': isApproved,
      'category': category,
      'time': time,
      'description': description
    };
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user': user,
      'amount': amount,
      'isApproved': isApproved,
      'category': category,
      'time': time,
      'description': description
    };
  }

  static TransactionEntity fromJson(Map<String, Object> json) {
    return TransactionEntity(
        id: json['id'] as String,
        user: json['user'] as String,
        amount: json['amount'] as int,
        isApproved: json['isApproved'] as bool,
        category: json['category'] as String,
        time: json['time'] as DateTime,
        description: json['description'] as String);
  }

  @override
  String toString() {
    return "TransactionEntity { id: $id, user: $user, amount: $amount, isApproved: $isApproved, category: $category, time: $time, description: $description} ";
  }

  @override
  List<Object?> get props =>
      [id, user, amount, isApproved, category, time, description];
}
