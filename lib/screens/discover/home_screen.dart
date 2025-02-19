import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:mememates/models/Meme.dart';
import 'package:mememates/utils/storage/firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int currentIndex = 0;
  List<Meme> memes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMemes();
    });
  }

  Future<void> fetchMemes() async {
    final response = await fetchAllMemes();
    setState(() {
      memes = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: memes.isEmpty
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
                                  color: Colors.black.withValues(alpha: 0.05),
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
