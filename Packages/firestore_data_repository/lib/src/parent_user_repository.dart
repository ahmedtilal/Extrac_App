import 'dart:async';

import 'package:firestore_data_repository/firestore_data_repository.dart';

abstract class ParentUserRepository {
  Future<void> addNewParentUser(ParentUser parentUser);

  Future<ParentUser> getParentUser(String userId);

  Future<void> deleteParentUser(ParentUser parentUser);

  Stream<List> getChildUsers(ParentUser parentUser);
}
