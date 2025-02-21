import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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

  Future<void> fetchMemes() async {
    setState(() {
      isLoading = true;
    });
    final response = await fetchAllMemes();
    setState(() {
      memes = response;
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
      // handle dislike
    }
    if (direction.name == 'right') {
      final currentUser = userProvider.user!;
      if (!meme.likedUsers.contains(currentUser.uid)) {
        await updateMemeLikedUser(meme);
      }
      if (meme.likedUsers.isNotEmpty) {
        final likedUsersExceptCurrent = meme.likedUsers.where((userId) {
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
                        numberOfCardsDisplayed: 1,
                        allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                          horizontal: true,
                          vertical: false,
                        ),
                        cardsCount: memes.length,
                        backCardOffset: Offset(40, 40),
                        scale: 0.9,
                        maxAngle: 90,
                        isLoop: false,
                        onSwipe: handleSwipe,
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) {
                          final meme = memes[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.05),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.grey.withValues(alpha: 0.2),
                                      Colors.grey.withValues(alpha: 0.7),
                                    ],
                                    stops: const [0.7, 1.0],
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(meme.url),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
