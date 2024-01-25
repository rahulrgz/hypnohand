import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/core/constands/image_constants.dart';
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
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return EasySplashScreen(
      logoWidth: w * 0.2,
      logo: Image.asset(Constants.logo),
      title: Text(
        "HYPNOHAND",
        style: GoogleFonts.urbanist(
          fontSize: h * 0.04,
          color: Palette.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Palette.blackColor,
      showLoader: false,
      navigator: OnboardingScreen(),
      durationInSeconds: 2,
    );
  }
}
