import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

import '../auths/ob/ob_model.dart';

class CloudRepository {
  CloudRepository({
    required FirebaseFirestore firestore,
    required auth.FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  //init
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  static const String incidentsPath = 'incidents';

  Stream<auth.User?> get userStream => _firebaseAuth.authStateChanges();

  //map detaiils to firestore
  Future<ObModel?> registerDetails(
      {required DateTime dateTime,
      required String incidentType,
      required String reportedBy,
      required String incidentBrief,
      required String resolution,
      required String department,
      required String escalatedTo,
      required String site,
      required String threatLevel,
      String? other}) async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;
      final id = _firestore.collection(incidentsPath).doc().id;

      final obModel = ObModel(
          id: id,
          uid: uid,
          dateTime: dateTime,
          site: site,
          incidentType: incidentType,
          reportBy: reportedBy,
          incidentBrief: incidentBrief,
          resolution: resolution,
          department: department,
          escalateTo: escalatedTo,
          threatLevel: threatLevel,
          other: other);

      await _firestore.collection(incidentsPath).doc(id).set(obModel.toMap());
    } on auth.FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return null;
  }

  // //retrieve data from firestore
  Stream<List<ObModel>> getOccurenceList() {
    final uid = _firebaseAuth.currentUser?.uid;
    final data = _firestore
        .collection(incidentsPath)
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots();

    return data.map((query) {
      return query.docs.map((e) {
        return ObModel.fromMap(e.data());
      }).toList();
    });
  }

  Future<String> getCollectionStats() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(incidentsPath).get();

    return querySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .length
        .toString();
  }
}
