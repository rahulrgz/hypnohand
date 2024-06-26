import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/feature/auth/login/controller/auth_controller.dart';
import 'package:hypnohand/feature/auth/login/screen/emailSignIn.dart';
import 'package:hypnohand/feature/auth/login/screen/signup_page.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constands/image_constants.dart';
import '../../../../core/global_variables/global_variables.dart';
import '../../../../core/theme/pallete.dart';

final devideIdProvider = StateProvider<String>((ref) => 'device Id');
///chabnge
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

    // final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();

  @override
  void initState() {
    initDeviceId();
    super.initState();
  }

    Future<void> initDeviceId() async {
    String deviceId;
    try {
      // deviceId = await _mobileDeviceIdentifierPlugin.getDeviceId() ??
      //     'Unknown platform version';

          // print('$deviceId \n device idddddddddddddddd');
    } on PlatformException {
      deviceId = 'Failed to get platform version.';
      print('device id failed ');
    }

    if (!mounted) return;
    
    // ref.read(devideIdProvider.notifier).update((state) => deviceId);
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final isLoading = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body:isLoading==true?Center(child: CircularProgressIndicator()): SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Lottie.asset(Constants.login, height: h * 0.5)),
                Text("Let's get you in",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        fontSize: h * 0.036,
                        color: Palette.blackColor)),
                SizedBox(height: h * 0.04),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BottomNav(),
                    //   ),
                    // );
                    ref.read(authControllerProvider.notifier).signInWithGoogle(ref: ref, context: context);
                  },
                  child: Container(
                    height: h * 0.065,
                    width: w * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        color: Palette.whiteColor,
                        border: Border.all(color: Palette.secondaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Constants.google,
                          height: h * 0.027,
                        ),
                        SizedBox(
                          width: w * 0.03,
                        ),
                        Text("Continue with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: h * 0.015,
                                color: Palette.blackColor)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: h * 0.015),

                SizedBox(height: h * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: h * 0.001,
                      width: w * 0.4,
                      color: Palette.blackColor,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                          color: Palette.blackColor, fontSize: h * 0.02),
                    ),
                    Container(
                      height: h * 0.001,
                      width: w * 0.4,
                      color: Palette.blackColor,
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return EmailSignIn();
                    },));
                  },
                  child: Container(
                    height: h * 0.065,
                    width: w * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        color: Palette.secondaryColor),
                    child: Center(
                        child: Text(
                      "Sign in with  password",
                      style: TextStyle(
                          color: Palette.whiteColor, fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                SizedBox(height: h * 0.03),
                Center(
                  child: GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SignUp_page();
                    },));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                              color: Palette.blackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: h * 0.017),
                          children: [
                            TextSpan(
                                text: "  Sign up",
                                style: TextStyle(
                                    color: Palette.secondaryColor,
                                    fontWeight: FontWeight.w400))
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
