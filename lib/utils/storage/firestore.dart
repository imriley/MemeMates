import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mememates/models/Meme.dart';
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

Future<void> updateMemeLikedUser(Meme meme, mememates.User user) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final memeCollection = FirebaseFirestore.instance.collection('memes');
  if (currentUser == null) {
    return;
  }
  try {
    final memeQuerySnapshot =
        await memeCollection.where('url', isEqualTo: meme.url).get();
    if (memeQuerySnapshot.docs.isNotEmpty) {
      final memeDoc = memeQuerySnapshot.docs.first;
      final memeRef = memeDoc.reference;
      final field =
          user.gender == 'man' ? 'maleLikedUsers' : 'femaleLikedUsers';
      await memeRef.update({
        field: FieldValue.arrayUnion([currentUser.uid]),
      });
    }
  } catch (e) {
    print('Error updating liked users in meme: $e');
  }
}

Future<mememates.User?> likeUserAndMatch(
    mememates.User currentUser, mememates.User otherUser) async {
  final userCollection = FirebaseFirestore.instance.collection('users');
  try {
    await userCollection.doc(currentUser.uid).update({
      "likedUsers": FieldValue.arrayUnion([otherUser.uid])
    });
    if (otherUser.likedUsers.contains(currentUser.uid)) {
      await addLikeBackAndMatch(currentUser, otherUser);
    } else {
      final match = Match(
        userId: currentUser.uid!,
        hasLiked: false,
        hasSentMeme: false,
      );
      await userCollection.doc(otherUser.uid).update({
        'matches': FieldValue.arrayUnion([match.toMap()])
      });
    }
    final user = await getCurrentUser();
    return user!;
  } catch (e) {
    print('Error updating users: $e');
    return null;
  }
}

Future<void> addLikeBackAndMatch(
    mememates.User currentUser, mememates.User otherUser) async {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final currentUserMatch = Match(
    userId: otherUser.uid!,
    hasLiked: true,
    hasSentMeme: false,
  );
  final otherUserMatch = Match(
    userId: currentUser.uid!,
    hasLiked: true,
    hasSentMeme: false,
  );
  try {
    await userCollection.doc(currentUser.uid).update({
      "matches": FieldValue.arrayUnion([currentUserMatch.toMap()])
    });
    await userCollection.doc(otherUser.uid).update({
      "matches": FieldValue.arrayUnion([otherUserMatch.toMap()])
    });
  } catch (e) {
    print('Error updating users: $e');
  }
}

Future<void> skipUser(mememates.User otherUser) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return;
  final userCollection = FirebaseFirestore.instance.collection('users');
  try {
    await userCollection.doc(otherUser.uid).update({
      "skippedUsers": FieldValue.arrayUnion([currentUser.uid])
    });
    await userCollection.doc(currentUser.uid).update({
      "skippedUsers": FieldValue.arrayUnion([otherUser.uid])
    });
  } catch (e) {
    print('Error skipping user: $e');
  }
}

Future<void> removeLikeAndMatch(mememates.User otherUser) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('users');
  if (currentUser == null) return;
  try {
    await userCollection.doc(currentUser.uid).update({
      "matches": FieldValue.arrayRemove([
        {
          'userId': otherUser.uid,
          'hasLiked': false,
          'hasSentMeme': false,
        }
      ])
    });
    await userCollection.doc(otherUser.uid).update({
      "likedUsers": FieldValue.arrayRemove([currentUser.uid])
    });
    await skipUser(otherUser);
  } catch (e) {
    print('Error updating users: $e');
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

Future<mememates.User?> fetchUser(String userId) async {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  try {
    final querySnapshot =
        await usersCollection.where('uid', isEqualTo: userId).get();
    final user = mememates.User.fromMap(querySnapshot.docs.first.data());
    return user;
  } catch (e) {
    print('Something went wrong: $e');
  }
  return null;
}

Future<List<Meme>> fetchAllMemes() async {
  final memesCollection = FirebaseFirestore.instance.collection('memes');
  try {
    final querySnapshot = await memesCollection.get();
    List<Meme> memes = querySnapshot.docs.map((doc) {
      return Meme.fromMap(doc.data());
    }).toList();
    return memes;
  } catch (e) {
    print('Error fetching memes: $e');
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
