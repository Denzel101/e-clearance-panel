import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

import '../auths/ob/over_model.dart';

class OverRepository {
  OverRepository({
    required FirebaseFirestore firestore,
    required auth.FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  //init
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  static const String overPath = 'overs';

  Stream<auth.User?> get userStream => _firebaseAuth.authStateChanges();

  //map detaiils to firestore
  Future<OverModel?> registerDetails({
    required String overType,
    required String name,
    required String narrative,
    required String site,
    String? acceptingName,
    String? comment,
    bool isPending = true,
  }) async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;
      final id = _firestore.collection(overPath).doc().id;

      final overModel = OverModel(
        id: id,
        overType: overType,
        name: name,
        site: site,
        uid: uid,
        narrative: narrative,
        acceptingName: acceptingName,
        handedOverAt: DateTime.now(),
        takeOverAt: DateTime.now(),
        comment: comment,
        isPending: isPending,
      );

      await _firestore.collection(overPath).doc(id).set(overModel.toMap());
    } on auth.FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  // //retrieve data from firestore
  Stream<List<OverModel>> getOccurenceList() {
    final uid = _firebaseAuth.currentUser?.uid;
    final data = _firestore
        .collection(overPath)
        .orderBy('handedOverAt', descending: true)
        .snapshots();

    return data.map((query) {
      return query.docs.map((e) {
        return OverModel.fromMap(e.data());
      }).toList();
    });
  }

  //delete data from firestore
  Future<void> deleteOccurenceEntry(String id) async {
    await _firestore.collection(overPath).doc(id).delete();
  }

  //update data from firestore
  Future<OverModel?> updateDetailsEntry({
    required String id,
    required String acceptingName,
    required String comment,
    bool? isPending,
    required String overType,
  }) async {
    await _firestore.collection(overPath).doc(id).update({
      'acceptingName': acceptingName,
      'comment': comment,
      'isPending': isPending = false,
      'takeOverAt': DateTime.now().millisecondsSinceEpoch,
      'overType': overType,
    });
    return null;
  }
}
