import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUsers();
    });
  }

  Future<void> fetchUsers() async {
    final data = await fetchAllUsers();
    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Discover",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1600275669439-14e40452d20b?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
            ),
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      body: GestureDetector(
        onVerticalDragStart: (value) {
          print('Swipped');
        },
        child: Column(
          children: [
            Expanded(
              child: _buildCard(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    color: Colors.orange,
                    onTap: () {
                      // Handle dislike
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.favorite,
                    color: const Color(0xFFE94057),
                    size: 64,
                    onTap: () {
                      // Handle like
                    },
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
            ),
          ],
        ),
      ),
      // body: Container(
      //   child: Consumer<DiscoverUserProvider>(
      //     builder: (context, provider, child) {
      //       if (provider.isLoading) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (provider.error != null) {
      //         return Center(
      //           child: Text(provider.error!),
      //         );
      //       } else if (provider.users.isEmpty) {
      //         return Center(
      //           child: Text("No users found"),
      //         );
      //       } else {
      //         return PageView.builder(
      //           itemCount: provider.users.length,
      //           itemBuilder: (context, index) {
      //             final user = provider.users[index];
      //             return Column(
      //               children: [
      //                 Expanded(
      //                   child: _buildUserProfileCard(user),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.symmetric(
      //                     vertical: 8,
      //                     horizontal: 16,
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                       _buildActionButton(
      //                         icon: Icons.close,
      //                         color: Colors.orange,
      //                         onTap: () {
      //                           // Handle dislike
      //                         },
      //                       ),
      //                       _buildActionButton(
      //                         icon: Icons.favorite,
      //                         color: const Color(0xFFE94057),
      //                         size: 64,
      //                         onTap: () {
      //                           // Handle like
      //                         },
      //                       ),
      //                       _buildActionButton(
      //                         icon: Icons.star,
      //                         color: Colors.purple,
      //                         onTap: () {
      //                           // Handle superlike
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             );
      //           },
      //         );
      //       }
      //     },
      //   ),
      // ),
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

  Widget _buildCard() {
    if (users.isEmpty) {
      return Center(
        child: Text("No users found"),
      );
    }
    final user = users[2];
    return _buildUserProfileCard(user);
  }

  Widget _buildUserProfileCard(User user) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
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
      ),
    );
  }
}
