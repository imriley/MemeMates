import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/models/User.dart';
import 'package:mememates/screens/discover/profile_detail_screen.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<User> users = [];
  int currentCount = 0;
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfilePictureUrl();
      fetchUsers();
    });
  }

  Future<void> fetchUsers() async {
    final data = await fetchAllUsers();
    setState(() {
      users = data;
    });
  }

  Future<void> getProfilePictureUrl() async {
    final user = await getCurrentUser();
    setState(() {
      profilePictureUrl = user!.profileImageUrl!;
    });
  }

  void handleDislike() {
    setState(() {
      users.removeAt(currentCount);
    });
    if (users.isNotEmpty) {
      if (currentCount > 0) {
        setState(() {
          currentCount--;
        });
      }
    }
  }

  void handleLike() async {
    await updateLikesAndMatches(users[currentCount]);
    setState(() {
      users.removeAt(currentCount);
    });
    if (users.isNotEmpty) {
      if (currentCount > 0) {
        setState(() {
          currentCount--;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProfileDetailScreen(
                        user: users[currentCount],
                        onDislike: handleDislike,
                        onLike: handleLike,
                      ),
                    ),
                  );
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < -5) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => ProfileDetailScreen(
                          user: users[currentCount],
                          onDislike: handleDislike,
                          onLike: handleLike,
                        ),
                      ),
                    );
                  }
                },
                child: _buildCard(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: AntDesign.close_outline,
                  color: Colors.orange,
                  onTap: handleDislike,
                ),
                _buildActionButton(
                  icon: IconsaxBold.heart,
                  color: const Color(0xFFE94057),
                  size: 64,
                  onTap: handleLike,
                ),
                _buildActionButton(
                  icon: Icons.star,
                  color: Colors.purple,
                  onTap: () {
                    // Handle superlike
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    if (users.isEmpty) {
      return Center(
        child: Text("No users found"),
      );
    }
    final user = users[currentCount];
    return _buildCarousel(user);
  }

  Widget _buildCarousel(User user) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                initialPage: 0,
              ),
              items: [user.profileImageUrl, ...user.moodBoard!.images]
                  .map((imageUrl) => CachedNetworkImage(
                        imageUrl: imageUrl!,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ))
                  .toList(),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}, ${user.age}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.gender == 'man' ? 'He/Him' : 'She/Her',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    double size = 48,
    required VoidCallback onTap,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onTap,
      ),
    );
  }
}
