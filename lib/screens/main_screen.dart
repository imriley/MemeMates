import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:mememates/screens/discover/home_screen.dart';
import 'package:mememates/screens/messaging/chats_screen.dart';
import 'package:mememates/screens/premium/premium_features_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return ChatsScreen();
      case 2:
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
