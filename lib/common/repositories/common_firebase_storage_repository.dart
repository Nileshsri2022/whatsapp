import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// this have not any controller because it is SingleFunction
// so it can directly connect with authRepository
final commonFirebaseStorageRepositoryProvider = Provider(
  (ref)=> CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance)
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({required this.firebaseStorage});
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    // upload to FirebaseStorage
    TaskSnapshot snap = await uploadTask;
    //now get the url from FirebaseStorage and store to FirebaseFireStore
    String downloadUrl = await snap.ref.getDownloadURL();
    // return String in async function makes Future<String>
    return downloadUrl;
  }
}
