import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:firebase_storage/firebase_storage.dart';

Future<void> addUser(mememates.User user) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users');
    user.uid = uid;
    await userRef.doc(uid).set(user.toMap());
  } catch (e) {
    print('Error adding user: $e');
  }
}

Future<List<mememates.User>> fetchAllUsers() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return [];
  }
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final currentUserUid = currentUser.uid;

  try {
    final querySnapshot =
        await usersCollection.where('uid', isNotEqualTo: currentUserUid).get();
    List<mememates.User> users = querySnapshot.docs.map((doc) {
      return mememates.User.fromMap(doc.data());
    }).toList();

    return users;
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

Future<String> uploadProfilePicture(File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef = FirebaseStorage.instance
      .ref()
      .child('users')
      .child(user!.uid)
      .child('profile_picture');
  final toUpload = await compressFile(imageFile);
  UploadTask uploadTask = storageRef.putFile(toUpload);
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
  final toUpload = await compressFile(imageFile);
  UploadTask uploadTask = storageRef.putFile(toUpload);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<File> compressFile(File file) async {
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: 20,
  );
  return File(result!.path);
}
