import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/core/constands/image_constants.dart';
import 'package:hypnohand/feature/auth/login/repository/auth_repository.dart';
import 'package:hypnohand/feature/auth/login/screen/login.dart';
import 'package:hypnohand/feature/auth/onboarding/onboarding.dart';
import 'package:hypnohand/feature/connectivity/connectivity.dart';
import 'package:hypnohand/feature/home/screen/bottom_nav.dart';
import 'package:hypnohand/main.dart';
import 'package:hypnohand/model/usermodel.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';

final onBoardingProvider=StateProvider((ref) => false);

class SplashScreen extends ConsumerStatefulWidget {

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
// final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  // bool _isDeviceConnected = false;
  // var connectionStatus;
  // final internetConnectionStatusProvider =
  // StateProvider<InternetStatus>(
  //         (ref) => InternetStatus.connected);
  //
  // final internetcheckProvider = StateProvider((ref) => false);
  //
  // checkConnection() async {
  //
  //   _isDeviceConnected = await InternetConnection().hasInternetAccess;
  //   if(_isDeviceConnected){
  //     connectionStatus =  InternetStatus.connected;
  //   }else{
  //
  //
  //     connectionStatus =  InternetStatus.disconnected;
  //
  //
  //   }
  //
  //   ref.watch(internetConnectionStatusProvider.notifier).state =
  //       connectionStatus;
  //   ref.watch(internetcheckProvider.notifier).state = _isDeviceConnected;
  //   if (_isDeviceConnected) {
  //     _buttonController.success();
  //   } else {
  //     _buttonController.stop();
  //
  //     const snackBar=SnackBar(content: Text("No active connection found"));
  //
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //
  //   }
  //   InternetConnection().onStatusChange.listen((result) async {
  //     _buttonController.stop();
  //     if (result != InternetStatus.disconnected) {
  //       _isDeviceConnected = await InternetConnection().hasInternetAccess;
  //
  //       connectionStatus =  InternetStatus.connected;
  //
  //       ref.read(internetConnectionStatusProvider.notifier).state =
  //           connectionStatus;
  //       ref.read(internetcheckProvider.notifier).state = _isDeviceConnected;
  //     }
  //     else {
  //       _buttonController.reset();
  //       ref.read(internetConnectionStatusProvider.notifier).state =
  //           InternetStatus.disconnected;
  //       ref.read(internetcheckProvider.notifier).state = false;
  //     }
  //     });
  //   }

  bool? isLogged;
    checkLogin() async {

      if(prefs!.getBool('onBoarding')==true){
        ///chabnge
     isLogged = prefs!.getBool('logged');
    currentUserId = prefs!.getString('currentuserId');

    if (isLogged == true) {
      var repository = ref.read(authRepositoryProvider);
      userModel = await repository.getUser();

      Future.delayed(Duration(seconds: 1),() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return currentUserId!=null? BottomNav():LoginScreen();
        },), (route) => false);
      },);
      print("currentUserId splash true");
      print(currentUserId);
      print("currentUserId prefs splash");
      print(prefs!.getString('currentuserId'));
      print('==============================');

    }
    else {
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
    // checkConnection();
    // getConnectivity();
    super.initState();
  }
  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //           (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         if (!isDeviceConnected && isAlertSet == false) {
  //
  //
  //           showDialogBox();
  //           setState(() => isAlertSet = true);
  //         }
  //       },
  //     );
  // showDialogBox() => showCupertinoDialog<String>(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: const Text('No Connection'),
  //     content: const Text('Please check your internet connectivity'),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () async {
  //           Navigator.pop(context, 'Cancel');
  //           setState(() => isAlertSet = false);
  //           isDeviceConnected =
  //           await InternetConnectionChecker().hasConnection;
  //           if (!isDeviceConnected && isAlertSet == false) {
  //             showDialogBox();
  //             setState(() => isAlertSet = true);
  //           }
  //         },
  //         child: const Text('OK'),
  //       ),
  //     ],
  //   ),
  // );
  @override
  Widget build(BuildContext context) {



      h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
  return ref.watch(connectivityProvider)==ConnectivityStatus.disconnected?Center(child: Text("No internet Connection"),) :
    // ref.watch(internetConnectionStatusProvider)==InternetStatus.disconnected?Center(child: Text("no internet"),):
     EasySplashScreen(
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