// splash_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mememates/screens/main_screen.dart';
import 'package:mememates/screens/onboarding/welcome_screen.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    if (mounted) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userFromFirebase = await getCurrentUser();
        userProvider.updateUser(userFromFirebase!);
      }
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              user != null ? const MainScreen() : WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
