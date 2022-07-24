import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_data_repository/src/child_user_repository.dart';
import 'package:firestore_data_repository/src/models/child_user.dart';
import 'package:firestore_data_repository/src/models/parent_user.dart';

import 'entities/entities.dart';

class FirestoreChildUserRepository implements ChildUserRepository {
  final parentUserCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewChildUser(
      ChildUser childUser, ParentUser parentUser) async {
    await parentUserCollection
        .doc(parentUser.userId)
        .update({
          'children': FieldValue.arrayUnion([childUser.userId])
        })
        .then((value) => print("User Added to array"))
        .catchError((error) => print("Failed to add user: $error"));
    await parentUserCollection
        .doc(parentUser.userId)
        .collection("childUsers")
        .doc(childUser.userId)
        .set({
          'isMaster': false,
          'name': childUser.name,
          'phoneNumber': childUser.phoneNumber,
          'parent': parentUser.userId
        })
        .then((value) => print('User Doc created'))
        .catchError((error) => print("Failed to add user: $error"));
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChildUser(ChildUser childUser, ParentUser parentUser) {
    parentUserCollection
        .doc(parentUser.userId)
        .collection('childUsers')
        .doc(childUser.userId)
        .delete();
    throw UnimplementedError();
  }

  @override
  Future<ChildUser> getChildUser(String userId) async {
    ParentUser parentUser = await getParentUser(userId);
    parentUserCollection
        .doc(parentUser.userId)
        .collection('childUsers')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return ChildUser.fromEntity(
          ChildUserEntity.fromDocumentSnapshot(snapshot));
    });
    throw UnimplementedError();
  }

  @override
  Future<ParentUser> getParentUser(String userId) async {
    late String parentUserId;
    await parentUserCollection
        .where('children', arrayContains: userId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        parentUserId = doc.id;
      });
    });
    parentUserCollection.doc(parentUserId).snapshots().map((snapshot) {
      return ParentUser.fromEntity(
          ParentUserEntity.fromDocumentSnapshot(snapshot));
    });
    throw UnimplementedError();
  }
}
