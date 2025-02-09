import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mememates/firebase_options.dart';
import 'package:mememates/screens/main_screen.dart';
import 'package:mememates/screens/onboarding/welcome_screen.dart';

import 'package:mememates/screens/splash_screen.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const MemeMates(),
    ),
  );
}

class MemeMates extends StatelessWidget {
  const MemeMates({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemeMates',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasError) {
            print("Something went wrong: ${snapshot.error}");
            return WelcomeScreen();
          } else if (snapshot.data != null) {
            return MainScreen();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
