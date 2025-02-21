import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mememates/firebase_options.dart';
import 'package:mememates/screens/splash_screen.dart';
import 'package:mememates/utils/providers/audio_player_provider.dart';
import 'package:mememates/utils/providers/user_provider.dart';
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
        ),
        ChangeNotifierProvider(
          create: (context) => AudioPlayerProvider(),
        )
      ],
      child: const MemeMates(),
    ),
  );
}

class MemeMates extends StatelessWidget {
  const MemeMates({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemeMates',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
