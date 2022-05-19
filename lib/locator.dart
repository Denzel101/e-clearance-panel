import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:schoolmanagement/repository/cloud_repository.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  // Repository

  locator.registerSingleton(
    CloudRepository(
      firestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ),
  );
}
