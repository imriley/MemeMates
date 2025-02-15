import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mememates/models/Match.dart';

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

Future<void> updateLikesAndMatches(mememates.User otherUser) async {
  final currentUserFromFirebase = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('users');
  if (currentUserFromFirebase == null) {
    return;
  }
  try {
    final currentUserQuerySnapshot = await userCollection
        .where('uid', isEqualTo: currentUserFromFirebase.uid)
        .get();

    if (currentUserQuerySnapshot.docs.isNotEmpty) {
      final currentUserDoc = currentUserQuerySnapshot.docs.first;
      final currentUserRef = currentUserDoc.reference;
      await currentUserRef.update({
        'likedUsers': FieldValue.arrayUnion([otherUser.uid]),
      });
      try {
        final otherUserDoc = await userCollection.doc(otherUser.uid).get();
        final otherUserFromMap = otherUserDoc.data() as Map<String, dynamic>;
        final otherUserFromFirestore = mememates.User.fromMap(otherUserFromMap);
        final hasLiked = otherUserFromFirestore.likedUsers
            .contains(currentUserFromFirebase.uid);
        final match = Match(
          userId: currentUserFromFirebase.uid,
          hasLiked: hasLiked,
          hasSentMeme: false,
        );
        await userCollection.doc(otherUser.uid).update(
          {
            'matches': FieldValue.arrayUnion([match.toMap()]),
          },
        );
      } catch (e) {
        print('Error updating other user: $e');
      }
    }
  } catch (e) {
    print('Error updating current user: $e');
  }
}

Future<mememates.User?> getCurrentUser() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return null;
  }
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final currentUserUid = currentUser.uid;

  try {
    final querySnapshot =
        await usersCollection.where('uid', isEqualTo: currentUserUid).get();
    final user = mememates.User.fromMap(querySnapshot.docs.first.data());
    return user;
  } catch (e) {
    print('Something went wrong: $e');
    return null;
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
    final temp = querySnapshot.docs[0].data()['matches'];
    print("First user's: $temp");
    final matches = temp.map((e) => Match.fromMap(e)).toList();
    print(matches);
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

Future<String> uploadMoodBoardImage(File imageFile, int index) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageRef = FirebaseStorage.instance
      .ref()
      .child('users')
      .child(user!.uid)
      .child('mood_board_images')
      .child(
          '${DateTime.now().millisecondsSinceEpoch.toString()}_${index.toString()}.jpg');
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
