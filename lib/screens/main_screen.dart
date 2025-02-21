import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:mememates/components/appbar.dart';
import 'package:mememates/screens/discover/home_screen.dart';
import 'package:mememates/screens/likes/likes_screen.dart';
import 'package:mememates/screens/messaging/chats_screen.dart';
import 'package:mememates/screens/premium/premium_features_screen.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _newMatchCount = 0;

  void updateMatchesCount(int count) {
    setState(() {
      _newMatchCount = count;
    });
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _newMatchCount = userProvider.user!.matches.length;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return LikesScreen(
          updateMatchesCount: updateMatchesCount,
        );
      case 2:
        return ChatsScreen();
      case 3:
        return PremiumFeaturesScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _buildPage(_selectedIndex),
      ),
      appBar: TopAppBar(
        title: _selectedIndex == 0
            ? "Discover"
            : _selectedIndex == 1
                ? "Liked You"
                : _selectedIndex == 2
                    ? "Messages"
                    : "Premium",
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          indicatorColor: Colors.white,
          overlayColor: const WidgetStatePropertyAll<Color>(Colors.white),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                IconsaxOutline.discover_1,
                size: 28,
              ),
              selectedIcon: Icon(
                IconsaxBold.discover,
                size: 28,
                color: Color(0xFFe94057),
              ),
              label: "Discover",
            ),
            NavigationDestination(
              icon: Stack(
                children: [
                  Icon(
                    IconsaxOutline.lovely,
                    size: 28,
                  ),
                  if (_selectedIndex != 1 && _newMatchCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '$_newMatchCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              selectedIcon: Icon(
                IconsaxBold.lovely,
                size: 28,
                color: Color(0xFFe94057),
              ),
              label: "Likes",
            ),
            NavigationDestination(
              icon: Icon(
                IconsaxOutline.message,
                size: 28,
              ),
              selectedIcon: Icon(
                IconsaxBold.message,
                size: 28,
                color: Color(0xFFe94057),
              ),
              label: "Messages",
            ),
            NavigationDestination(
              icon: Icon(
                IconsaxOutline.star_1,
                size: 28,
              ),
              selectedIcon: Icon(
                IconsaxBold.star,
                size: 28,
                color: Color(0xFFe94057),
              ),
              label: "Premium",
            ),
          ],
        ),
      ),
    );
  }
}
