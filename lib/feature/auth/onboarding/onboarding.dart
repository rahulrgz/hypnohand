import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hypnohand/feature/auth/splash/splash.dart';
import 'package:hypnohand/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constands/image_constants.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';
import '../login/screen/login.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  int pageIndex = 0;

  final List<Map<String, dynamic>> onBoardingData = [
    {
      'imagePath': Constants.onboard1,
      'text': "Grab all course now on \nyour hands",
      'content':
          "Being able to study efficiently is an\n important skill for students.",
    },
    {
      'imagePath': Constants.onboard2,
      'text': "Monitored by certified\n Teachers.",
      'content':
          "Being able to study efficiently is an\n important skill for students.",
    },
    {
      'imagePath': Constants.onboard3,
      'text': "Let's enroll your favorite \ncourse right now!",
      'content':
          "Being able to study efficiently is an\n important skill for students.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.6,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                    isLastPage = index == onBoardingData.length - 1;
                  });
                },
                children: [
                  SizedBox(
                    width: w,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Constants.onboard1,
                          height: h * 0.4,
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        Text(
                          'Grab all course now on \nyour hands',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.03,
                            color: Palette.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h * 0.023,
                        ),
                        Text(
                          'Being able to study efficiently is an\n important skill for students.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.017,
                            color: Palette.blackColor,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Constants.onboard2,
                          height: h * 0.43,
                        ),
                        // SizedBox(
                        //   height: h * 0.01,
                        // ),
                        Text(
                          'Monitored by skilled\n Tutors.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.03,
                            color: Palette.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h * 0.023,
                        ),
                        Text(
                          'Being able to study efficiently is an\n important skill for students.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.017,
                            color: Palette.blackColor,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          Constants.onboard3,
                          height: h * 0.36,
                        ),
                        SizedBox(
                          height: h * 0.06,
                        ),
                        Text(
                          "Let's enroll your favorite \ncourse right now!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.03,
                            color: Palette.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h * 0.023,
                        ),
                        Text(
                          'Being able to study efficiently is an\n important skill for students.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: h * 0.017,
                            color: Palette.blackColor,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            SmoothPageIndicator(
              controller: controller,
              count: onBoardingData.length,
              effect: ExpandingDotsEffect(
                dotWidth: w * 0.025,
                dotHeight: h * 0.01,
                activeDotColor: Palette.primaryColor,
              ),
            ),
            SizedBox(height: h * 0.02),
            pageIndex == onBoardingData.length - 1
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      // ref.read(onBoardingProvider.notifier).update((state) => true);
                      prefs!.setBool('onBoarding', true);
                    },
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.05,
                      decoration: BoxDecoration(
                        color: Palette.secondaryColor,
                        borderRadius: BorderRadius.circular(h * 0.06),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.03,
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.05,
                      decoration: BoxDecoration(
                        color: Palette.secondaryColor,
                        borderRadius: BorderRadius.circular(h * 0.06),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.03,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: h * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
