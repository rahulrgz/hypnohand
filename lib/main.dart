import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';
import 'package:hypnohand/feature/auth/splash/splash.dart';
import 'package:hypnohand/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpOverrides();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return const MaterialApp(
      home: SafeArea(child: InternetChecker(
          placeHolder: CircularProgressIndicator(),
          internetConnectionText:'Not Internet Connection',
          child: SplashScreen())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}