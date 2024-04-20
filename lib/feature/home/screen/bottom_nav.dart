import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypnohand/feature/profile/screen/profile_screen.dart';

import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';
import '../../Saved_course/Saved_course.dart';
import '../../couse/course.dart';
import '../../performance/performance.dart';
import 'home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}
///chabnge
class _BottomNavState extends State<BottomNav> {
  late List<Widget> _screens;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      AllCourse(),
      Performence(),
      SavedCourse(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: w * 0.03,
          iconSize: w * 0.06,
          backgroundColor: Palette.whiteColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Palette.primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.list_bullet_below_rectangle),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_stack_person_crop),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.news),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
