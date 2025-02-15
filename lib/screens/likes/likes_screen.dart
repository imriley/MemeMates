import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:mememates/screens/discover/profile_detail_screen.dart';
import 'package:mememates/utils/storage/firestore.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  List<mememates.User> matches = [];
  StreamSubscription? _matchesSubscription;

  @override
  void initState() {
    super.initState();
    _loadMatches();
    _listenForMatches();
  }

  @override
  void dispose() {
    _matchesSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadMatches() async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) return;
    final unlikedMatches =
        currentUser.matches.where((match) => !match.hasLiked).toList();
    if (unlikedMatches.isNotEmpty) {
      final matchedUserIds =
          unlikedMatches.map((match) => match.userId).toList();
      try {
        final querySnapshot =
            await usersCollection.where('uid', whereIn: matchedUserIds).get();
        setState(() {
          matches = querySnapshot.docs
              .map((doc) => mememates.User.fromMap(doc.data()))
              .toList();
        });
      } catch (e) {
        print('Error fetching matches: $e');
      }
    } else {
      setState(() {
        matches = [];
      });
    }
  }

  void _listenForMatches() {
    _matchesSubscription = usersCollection
        .doc(currentUserUid)
        .snapshots()
        .listen((snapshot) async {
      final currentUser =
          mememates.User.fromMap(snapshot.data() as Map<String, dynamic>);
      final newMatches = currentUser.matches
          .where((match) =>
              matches.every((existingMatch) =>
                  (match is String ? match : match.userId) !=
                  (existingMatch.uid)) &&
              !match.hasLiked)
          .toList();
      if (newMatches.isNotEmpty) {
        final newMatchUserIds =
            newMatches.map((match) => match.userId).toList();
        try {
          final querySnapshot = await usersCollection
              .where('uid', whereIn: newMatchUserIds)
              .get();
          final newUsers = querySnapshot.docs
              .map((doc) => mememates.User.fromMap(doc.data()))
              .toList();
          setState(() {
            matches.addAll(newUsers);
          });
        } catch (e) {
          print('Error fetching new users: $e');
        }
      }
    });
  }

  void onLike() async {
    print("Like");
  }

  void onDislike() async {}

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
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => ProfileDetailScreen(
                            user: matchedUser,
                            onLike: onLike,
                            onDislike: () async {
                              await removeLikeAndMatch(matchedUser);
                            },
                          ),
                        ),
                      );
                    },
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
