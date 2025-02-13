import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart';

class ProfileDetailScreen extends StatefulWidget {
  User user;
  ProfileDetailScreen({super.key, required this.user});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1600275669439-14e40452d20b?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      width: double.infinity,
                      height: 450,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: Icons.close,
                            backgroundColor: Colors.white,
                            iconColor: Colors.orange,
                          ),
                          _buildActionButton(
                            icon: Icons.favorite,
                            backgroundColor: const Color(0xFFE94057),
                            iconColor: Colors.white,
                            size: 64,
                          ),
                          _buildActionButton(
                            icon: Icons.star,
                            backgroundColor: Colors.white,
                            iconColor: Colors.purple,
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
                      // Name and Send Message
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jessica Parker, 23',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Professional model',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Color(0xFFE94057),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Location
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFE94057),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Chicago, IL United States',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE8EA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '1 km',
                              style: TextStyle(
                                color: Color(0xFFE94057),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // About
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..',
                        style: TextStyle(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Read more',
                          style: TextStyle(
                            color: Color(0xFFE94057),
                          ),
                        ),
                      ),

                      // Interests
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
                        children: [
                          _buildInterestChip('Travelling', true),
                          _buildInterestChip('Books', true),
                          _buildInterestChip('Music', false),
                          _buildInterestChip('Dancing', false),
                          _buildInterestChip('Modeling', false),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Gallery
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Color(0xFFE94057),
                              ),
                            ),
                          ),
                        ],
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
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size * 0.5,
      ),
    );
  }

  Widget _buildInterestChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFFE94057) : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? const Color(0xFFFFE8EA) : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFFE94057) : Colors.grey[600],
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
      children: List.generate(
        4,
        (index) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://images.unsplash.com/photo-1600275669439-14e40452d20b?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
