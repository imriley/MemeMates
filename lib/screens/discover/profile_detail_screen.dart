import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/models/User.dart';

class ProfileDetailScreen extends StatefulWidget {
  User user;
  void Function() onLike;
  void Function() onDislike;
  ProfileDetailScreen(
      {super.key,
      required this.user,
      required this.onLike,
      required this.onDislike});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.delta.dy > 20) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Image.network(
                        widget.user.profileImageUrl!,
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: AntDesign.close_outline,
                            backgroundColor: Colors.white,
                            iconColor: Colors.orange,
                            onTap: () {
                              widget.onDislike();
                              Navigator.of(context).pop();
                            },
                          ),
                          _buildActionButton(
                            icon: IconsaxBold.heart,
                            backgroundColor: const Color(0xFFE94057),
                            iconColor: Colors.white,
                            size: 64,
                            onTap: () {
                              widget.onLike();
                              Navigator.of(context).pop();
                            },
                          ),
                          _buildActionButton(
                            icon: Icons.star,
                            backgroundColor: Colors.white,
                            iconColor: Colors.purple,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Profile Info Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.user.name}, ${widget.user.age}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              IconsaxOutline.send_2,
                              color: Color(0xFFE94057),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Interests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.user.interests
                            .map((ele) => _buildInterestChip(ele))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'MoodBoard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildGalleryGrid(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top +
                  10, // Adds padding for status bar
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  iconSize: 20,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    double size = 48,
    required VoidCallback onTap,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        iconSize: size * 0.5,
      ),
    );
  }

  Widget _buildInterestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE94057),
        ),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFE8EA),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFFE94057),
        ),
      ),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: widget.user.moodBoard!.images
          .map((url) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
    );
  }
}
