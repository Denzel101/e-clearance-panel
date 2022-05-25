import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageRepository {
  static UploadTask? uploadFile(
      {required String destination, required File file}) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
