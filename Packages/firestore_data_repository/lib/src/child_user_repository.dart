import 'dart:async';

import 'package:firestore_data_repository/firestore_data_repository.dart';

abstract class ChildUserRepository {
  Future<void> addNewChildUser(ChildUser childUser, ParentUser parentUser);

  Future<ParentUser> getParentUser(String userId);

  Future<ChildUser> getChildUser(String userId);

  Future<void> deleteChildUser(ChildUser childUser, ParentUser parentUser);
}
