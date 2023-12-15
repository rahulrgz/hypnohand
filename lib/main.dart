import 'package:flutter/material.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';
import 'package:hypnohand/feature/auth/onboarding/onboarding.dart';
import 'package:hypnohand/feature/auth/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
