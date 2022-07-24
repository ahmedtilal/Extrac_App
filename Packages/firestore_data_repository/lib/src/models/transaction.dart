import 'package:firestore_data_repository/src/entities/entities.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Transaction {
  final String id;
  final String user;
  final int amount;
  final bool isApproved;
  final String category;
  final String description;
  final DateTime time;

  Transaction({
    this.isApproved = false,
    required this.user,
    String? category = "No category",
    String? id,
    String? description = '',
    int? amount = 0,
    required this.time,
  })  : this.id = id ?? Uuid().v4(),
        this.category = category ?? '',
        this.description = description ?? '',
        this.amount = amount ?? 1;

  Transaction copyWith(
      {String? user,
      int? amount,
      bool? isApproved,
      String? category,
      String? description,
      DateTime? time}) {
    return Transaction(
        id: id,
        user: user ?? this.user,
        amount: amount ?? this.amount,
        isApproved: isApproved ?? this.isApproved,
        category: category ?? this.category,
        description: description ?? this.description,
        time: time ?? this.time);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        amount.hashCode ^
        isApproved.hashCode ^
        category.hashCode ^
        description.hashCode ^
        time.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Transaction &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            user == other.user &&
            amount == other.amount &&
            isApproved == other.isApproved &&
            category == other.category &&
            description == other.description &&
            time == other.time;
  }

  @override
  String toString() {
    return "Transaction { id: $id, user: $user, amount: $amount, isApproved: $isApproved, category: $category, time: $time, description: $description} ";
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
        id: id,
        user: user,
        amount: amount,
        isApproved: isApproved,
        category: category,
        description: description,
        time: time);
  }

  static Transaction fromEntity(TransactionEntity entity) {
    return Transaction(
        id: entity.id,
        user: entity.user,
        time: entity.time,
        amount: entity.amount,
        isApproved: entity.isApproved,
        category: entity.category,
        description: entity.description);
  }
}
