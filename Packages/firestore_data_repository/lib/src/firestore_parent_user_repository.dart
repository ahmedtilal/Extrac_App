import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_data_repository/firestore_data_repository.dart';
import 'package:firestore_data_repository/src/models/models.dart';
import 'package:firestore_data_repository/src/parent_user_repository.dart';

class FirestoreParentUserRepository implements ParentUserRepository {
  final parentUsersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewParentUser(ParentUser parentUser) async {
    parentUser.children.add(parentUser.userId);
    await parentUsersCollection
        .doc(parentUser.userId)
        .set(parentUser.toEntity().toDocumentSnapshot());
    throw UnimplementedError();
  }

  @override
  Future<void> deleteParentUser(ParentUser parentUser) async {
    await parentUsersCollection.doc(parentUser.userId).delete();
    throw UnimplementedError();
  }

  @override
  Stream<List> getChildUsers(ParentUser parentUser) {
    return parentUsersCollection
        .doc(parentUser.userId)
        .collection('childUsers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              ChildUser.fromEntity(ChildUserEntity.fromDocumentSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<ParentUser> getParentUser(String userId) async {
    late String parentUserId;
    await parentUsersCollection
        .where('children', arrayContains: userId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        parentUserId = doc.id;
      });
    });
    parentUsersCollection.doc(parentUserId).snapshots().map((snapshot) {
      return ParentUser.fromEntity(
          ParentUserEntity.fromDocumentSnapshot(snapshot));
    });
    throw UnimplementedError();
  }
}
