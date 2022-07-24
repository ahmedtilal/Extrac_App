import 'dart:async';

import 'package:firestore_data_repository/src/models/models.dart';

abstract class TransactionsRepository {

  Future<void> addNewTransaction(Transaction transaction);

  Future<void> approveTransaction(Transaction transaction);

  Future<void> deleteTransaction(Transaction transaction);

  Stream<List<Transaction>> getTransactions();
}

