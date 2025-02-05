import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadProfilePicture(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef =
      FirebaseStorage.instance.ref().child('Profile Pictures').child(user!.uid);
  UploadTask uploadTask = storageRef.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}

Future<String> uploadMoodBoardImage(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef = FirebaseStorage.instance
      .ref()
      .child('Mood Board Images')
      .child(user!.uid)
      .child('${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');
  UploadTask uploadTask = storageRef.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
