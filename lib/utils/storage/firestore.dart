import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addUser(mememates.User user) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('users');
    final uid = user.uid;

    await userRef.doc(uid).set(user.toMap());
  } catch (e) {
    print('Error adding user: $e');
  }
}

Future<String> uploadProfilePicture(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef = FirebaseStorage.instance
      .ref()
      .child('users')
      .child(user!.uid)
      .child('profile_picture');
  UploadTask uploadTask = storageRef.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<String> uploadMoodBoardImage(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef = FirebaseStorage.instance
      .ref()
      .child('users')
      .child(user!.uid)
      .child('mood_board_images')
      .child('${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');
  UploadTask uploadTask = storageRef.putFile(imageFile);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
