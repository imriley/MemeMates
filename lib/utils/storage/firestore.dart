import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  print("Current User UID: $currentUserUid");
  final temp = await usersCollection.get();
  final something = temp.docs[0].data();
  print(mememates.User.fromMap(something).toString());

  try {
    final querySnapshot =
        await usersCollection.where('uid', isNotEqualTo: currentUserUid).get();
    print("Number of Documents Returned: ${querySnapshot.docs.length}");
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
