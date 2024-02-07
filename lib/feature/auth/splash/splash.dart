import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/core/constands/image_constants.dart';
import 'package:hypnohand/feature/auth/login/repository/auth_repository.dart';
import 'package:hypnohand/feature/auth/login/screen/login.dart';
import 'package:hypnohand/feature/auth/onboarding/onboarding.dart';
import 'package:hypnohand/feature/home/screen/bottom_nav.dart';
import 'package:hypnohand/main.dart';
import 'package:hypnohand/model/usermodel.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';

final onBoardingProvider=StateProvider((ref) => false);

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool? isLogged;
    checkLogin() async {

      if(prefs!.getBool('onBoarding')==true){

     isLogged = prefs!.getBool('logged');
    currentUserId = prefs!.getString('currentuserId');

    if (isLogged == true) {
      var repository = ref.read(authRepositoryProvider);
      userModel = await repository.getUser();
      Future.delayed(Duration(seconds: 1),() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return BottomNav();
        },), (route) => false);
      },);
      print("currentUserId splash true");
      print(currentUserId);
      print("currentUserId prefs splash");
      print(prefs!.getString('currentuserId'));
      print('==============================');

    } else {
      print("currentUserId splash false");
      print(currentUserId);
      print("currentUserId prefs splash");
      // print(prefs.getString('currentuserId splash'));
      print('==============================');
     Future.delayed(Duration(seconds: 1),() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return LoginScreen();
        },), (route) => false);
      },);
    }
      }else{
        Future.delayed(Duration(seconds: 1),() {
           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return OnboardingScreen();
        },), (route) => false);
        },);
      }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }
  
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
      // navigator:  (isLogged== false) ? LoginScreen():BottomNav(),
      durationInSeconds: 2,
    );
  }
}