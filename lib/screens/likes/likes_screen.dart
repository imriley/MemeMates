import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart' as mememates;
import 'package:mememates/screens/discover/profile_detail_screen.dart';
import 'package:mememates/utils/storage/firestore.dart';

class LikesScreen extends StatefulWidget {
  final Function(int) updateMatchesCount;
  const LikesScreen({super.key, required this.updateMatchesCount});

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
    print(currentUser.matches);
    final unlikedMatches = currentUser.matches.where((match) {
      print(match.hasLiked);
      if (match.hasLiked == true) {
        return false;
      }
      return true;
    }).toList();
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
        widget.updateMatchesCount(matches.length);
      } catch (e) {
        print('Error fetching matches: $e');
      }
    } else {
      setState(() {
        matches = [];
      });
      widget.updateMatchesCount(matches.length);
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
          widget.updateMatchesCount(matches.length);
        } catch (e) {
          print('Error fetching new users: $e');
        }
      }
    });
  }

  Future<void> onLike() async {
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
            ? const Center(child: Text('No matches yet'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final matchedUser = matches[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => ProfileDetailScreen(
                            user: matchedUser,
                            canPop: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(matchedUser.profileImageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 8,
                            left: 16,
                            right: 8,
                            child: Text(
                              "${matchedUser.name}, ${matchedUser.age}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
