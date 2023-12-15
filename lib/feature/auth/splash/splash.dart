import 'package:flutter/material.dart';
import 'package:hypnohand/feature/auth/onboarding/onboarding.dart';

import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "HYPNOHAND",
                style: TextStyle(
                  fontSize: h * 0.04,
                  color: Palette.whiteColor,
                ),
              ),
            ),
            Text(
              "Where the learning starts...",
              style: TextStyle(
                fontSize: h * 0.017,
                color: Palette.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
