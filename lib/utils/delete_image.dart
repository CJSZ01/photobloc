import 'package:firebase_storage/firebase_storage.dart';

Future<bool> deleteImage({required Reference image, required String userId}) =>
    FirebaseStorage.instance
        .ref(image.fullPath)
        .delete()
        .then((_) => true)
        .catchError((_) => false);
