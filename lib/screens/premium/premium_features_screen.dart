import 'package:flutter/material.dart';

class PremiumFeaturesScreen extends StatefulWidget {
  const PremiumFeaturesScreen({super.key});

  @override
  State<PremiumFeaturesScreen> createState() => _PremiumFeaturesScreenState();
}

class _PremiumFeaturesScreenState extends State<PremiumFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Text("Premium Features Screen"),
      ),
    );
  }
}
