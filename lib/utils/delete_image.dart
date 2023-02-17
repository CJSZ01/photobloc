import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<bool> deleteImage({required File file, required String userId}) =>
    FirebaseStorage.instance
        .ref(userId)
        .delete()
        .then((_) => true)
        .catchError((_) => false);
