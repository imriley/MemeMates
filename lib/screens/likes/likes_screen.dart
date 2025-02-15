import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:mememates/utils/storage/firestore.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection('users');
  List<mememates.User> matches = [];

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) return;
    if (currentUser.matches.isNotEmpty) {
      final matchedUserIds =
          currentUser.matches.map((match) => match.userId).toList();
      try {
        final querySnapshot =
            await userCollection.where('uid', whereIn: matchedUserIds).get();
        setState(() {
          matches = querySnapshot.docs
              .map((doc) => mememates.User.fromMap(doc.data()))
              .toList();
        });
      } catch (e) {
        print('Error fetching matches: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: matches.isEmpty
            ? Center(
                child: Text(
                  "When someone likes your profile, you'll find them here!",
                ),
              )
            : ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final matchedUser = matches[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(matchedUser.profileImageUrl ?? ""),
                    ),
                    title: Text(matchedUser.name ?? ""),
                  );
                },
              ),
      ),
    );
  }
}
