import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mememates/screens/onboarding/profile_picture_screen.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final List<InterestItem> interests = [
    InterestItem(icon: Icons.local_cafe_outlined, label: 'Coffee'),
    InterestItem(icon: Icons.pets_outlined, label: 'Pets'),
    InterestItem(icon: Icons.book_outlined, label: 'Reading'),
    InterestItem(icon: Icons.movie_outlined, label: 'Movies'),
    InterestItem(icon: Icons.local_pizza_outlined, label: 'Foodie'),
    InterestItem(icon: Icons.beach_access_outlined, label: 'Beaches'),
    InterestItem(icon: Icons.forest_outlined, label: 'Hiking'),
    InterestItem(icon: Icons.local_library_outlined, label: 'Learning'),
    InterestItem(icon: Icons.fitness_center_outlined, label: 'Fitness'),
    InterestItem(icon: Icons.videogame_asset_outlined, label: 'Gaming'),
    InterestItem(icon: Icons.local_drink_outlined, label: 'Drinks'),
    InterestItem(icon: Icons.mic_none_outlined, label: 'Podcasts'),
    InterestItem(icon: Icons.code_outlined, label: 'Coding/Programming'),
    InterestItem(icon: Icons.casino_outlined, label: 'Board Games'),
    InterestItem(icon: Icons.create_outlined, label: 'DIY'),
    InterestItem(icon: Icons.collections_outlined, label: 'Art'),
    InterestItem(icon: Icons.nature_outlined, label: 'Nature'),
    InterestItem(icon: Icons.local_mall_outlined, label: 'Shopping'),
    InterestItem(icon: Icons.local_dining_outlined, label: 'Cooking'),
    InterestItem(icon: Icons.sports_outlined, label: 'Sports'),
    InterestItem(icon: Icons.card_travel_outlined, label: 'Travel'),
  ];

  Set<String> selectedInterests = {};
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            IconsaxOutline.arrow_left_2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            LinearProgressIndicator(
              value: 71 / 100,
              color: Color(0xFFe94158),
              backgroundColor: Color(0xFFE3E5E5),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What are your interests?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Select a few of your interests and let everyone\nknow what you\'re passionate about.',
                      style: TextStyle(
                        color: hasError ? Color(0xFFE94158) : Color(0xFF7D7D7D),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: interests.map((interest) {
                          final isSelected =
                              selectedInterests.contains(interest.label);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedInterests.remove(interest.label);
                                } else {
                                  selectedInterests.add(interest.label);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE94158)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFFE94158)
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    interest.icon,
                                    size: 18,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    interest.label,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 32,
              ),
              child: TextButton(
                onPressed: () async {
                  if (selectedInterests.isEmpty) {
                    setState(() {
                      hasError = true;
                    });
                    return;
                  }
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  userProvider.updateUser(userProvider.user!.copyWith(
                    interests: selectedInterests.toList(),
                  ));
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProfilePictureScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFE94158),
                  padding: EdgeInsets.all(
                    16,
                  ),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InterestItem {
  final IconData icon;
  final String label;

  InterestItem({required this.icon, required this.label});
}
