import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:mememates/components/meme_card.dart';
import 'package:mememates/models/Meme.dart';
import 'package:mememates/screens/discover/profile_detail_screen.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Meme> memes = [];
  List<Widget> cards = [];
  bool isLoading = false;
  late UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMemes();
    });
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      width: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  Future<void> fetchMemes() async {
    setState(() {
      isLoading = true;
    });
    final response = await fetchAllMemes();
    setState(() {
      memes = response;
      cards = memes.map((meme) => MemeCard(meme: meme)).toList();
      isLoading = false;
    });
  }

  Future<bool> handleSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    final meme = memes[previousIndex];
    if (direction.name == 'left') {
      showSnackBar(context, "Skipped");
    }
    if (direction.name == 'right') {
      showSnackBar(context, "Liked");
      final currentUser = userProvider.user!;
      final currentLikedUsers = currentUser.gender == 'man'
          ? meme.maleLikedUsers
          : meme.femaleLikedUsers;
      if (!currentLikedUsers.contains(currentUser.uid)) {
        await updateMemeLikedUser(meme, currentUser);
      }
      final currentUserPreferences = currentUser.preferenceGender == 'man'
          ? meme.maleLikedUsers
          : currentUser.preferenceGender == 'woman'
              ? meme.femaleLikedUsers
              : meme.maleLikedUsers + meme.femaleLikedUsers;
      if (currentUserPreferences.isNotEmpty) {
        final likedUsersExceptCurrent = currentUserPreferences.where((userId) {
          if (userId == currentUser.uid) {
            return false;
          }

          if (currentUser.skippedUsers.contains(userId)) {
            return false;
          }

          if (currentUser.likedUsers.contains(userId)) {
            return false;
          }

          return true;
        }).toList();
        if (likedUsersExceptCurrent.isEmpty) {
          return true;
        }

        final random = Random();
        final randomIndex = random.nextInt(likedUsersExceptCurrent.length);
        final randomUserID = likedUsersExceptCurrent[randomIndex];
        final randomUser = await fetchUser(randomUserID);
        if (randomUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfileDetailScreen(
                  user: randomUser,
                  canPop: false,
                );
              },
            ),
          );
        } else {
          return true;
        }
      }
    }
    if (currentIndex == null) {
      setState(() {
        memes = [];
        cards = [];
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : memes.isEmpty
              ? Center(
                  child: Text('No memes found'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CardSwiper(
                        numberOfCardsDisplayed: 2,
                        allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                          horizontal: true,
                          vertical: false,
                        ),
                        cardsCount: memes.length,
                        backCardOffset: Offset(20, 20),
                        scale: 0.9,
                        maxAngle: 30,
                        isLoop: false,
                        onSwipe: handleSwipe,
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) {
                          return cards[index];
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
