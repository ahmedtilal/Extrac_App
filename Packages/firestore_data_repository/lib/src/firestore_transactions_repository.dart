import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firestore_data_repository/firestore_data_repository.dart';

import 'transactions_repository.dart';

class FirestoreTransactionsRepository implements TransactionsRepository {
  FirestoreTransactionsRepository({required this.parentUser});

  final ParentUser parentUser;

  late final transactionsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(parentUser.userId)
      .collection('transactions');

  @override
  Future<void> addNewTransaction(Transaction transaction) async {
    await transactionsCollection
        .doc(transaction.id)
        .set(transaction.toEntity().toDocumentSnapshot());
    throw UnimplementedError();
  }

  @override
  Future<void> approveTransaction(Transaction transaction) async {
    transaction = transaction.copyWith(isApproved: true);
    await transactionsCollection
        .doc(transaction.id)
        .update(transaction.toEntity().toDocumentSnapshot())
        .then((value) => print("Transaction Approved"))
        .catchError((error) => print("Failed to update transaction: $error"));
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) async {
    await transactionsCollection.doc(transaction.id).delete();
    throw UnimplementedError();
  }

  @override
  Stream<List<Transaction>> getTransactions() {
    return transactionsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Transaction.fromEntity(
              TransactionEntity.fromDocumentSnapshot(doc)))
          .toList();
    });
  }
}
