import 'package:chacha_caller/features/app/const/app_auth_exception.dart';
import 'package:chacha_caller/features/user/data/models/user_model.dart';
import 'package:chacha_caller/features/user/data/remote_data_source/remote_data_source.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RemoteDataSourceImplementation extends RemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  RemoteDataSourceImplementation({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<void> createUser(UserEntity user) async {
    final uid = await getCurrentUid();
    final userCollection = firestore.collection('users');
    userCollection.doc(uid).get().then(
      (userDoc) {
        final newUser = UserModel(
          username: user.username,
          email: user.email,
          password: user.password,
          accountType: user.accountType,
          isNotification: user.isNotification,
          uid: uid,
        ).toMap();
        if (!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      },
    ).onError(
      (error, stackTrace) {
        debugPrint(error.toString());
      },
    );
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection =
        firestore.collection('users').where("uid", isEqualTo: uid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((e) => UserModel.fromSnapshot(e.data()))
        .toList());
  }

  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
      await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
    } else {
      throw AppAuthException('Fields Cannot be empty');
    }
  }

  @override
  Future<void> signOut() async {
    await OneSignal.logout();
    await auth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    if (user.email!.isNotEmpty &&
        user.password!.isNotEmpty &&
        user.username!.isNotEmpty) {
      if (user.accountType! != 'EMPLOYEE' && user.accountType! != 'WORKER') {
        throw AppAuthException('No account type selected.');
      } else {
        await auth
            .createUserWithEmailAndPassword(
                email: user.email!, password: user.password!)
            .then(
          (value) {
            createUser(user);
          },
        );
      }
    } else {
      throw AppAuthException('Fields cannot be empty');
    }
  }
}
