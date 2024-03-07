import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/theme/pallete.dart';
import 'package:hypnohand/feature/auth/login/controller/auth_controller.dart';
import 'package:hypnohand/feature/auth/login/repository/auth_repository.dart';
import 'package:hypnohand/model/usermodel.dart';
import '../../../core/global_variables/global_variables.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h * 0.08),
                SizedBox(
                  width: w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: h * 0.07,
                        backgroundImage: NetworkImage(
                            "https://lh3.googleusercontent.com/a/ACg8ocImL96IeWUFYcO6A0ZFubKe-GLT4qNh8X69LYJjvhdQId1H=s331-c-no"),
                      ),
                      SizedBox(height: h * 0.01),
                      Text(
                        userModel?.name??'name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.blackColor,
                            fontSize: h * 0.031,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        userModel?.phoneNumber??'',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.primaryColor,
                            fontSize: h * 0.015,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: h * 0.02),
                      Container(
                        height: h * 0.04,
                        width: w * 0.34,
                        decoration: BoxDecoration(
                          color: Palette.secondaryColor,
                          borderRadius: BorderRadius.circular(w * 0.02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: h * 0.02,
                            ),
                            Text(
                              " Edit Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.whiteColor,
                                  fontSize: h * 0.02,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.03),
                Text(
                  "Purchased Courses",
                  style: TextStyle(
                      color: Palette.blackColor,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: h * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Level 0",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Sep 2024",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(thickness: w * 0.0004),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Level 1",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Sep 2024",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(thickness: w * 0.0004),
                SizedBox(height: h * 0.02),
                Text(
                  "Personal Information",
                  style: TextStyle(
                      color: Palette.blackColor,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: h * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Male",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(thickness: w * 0.0004),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "17 Sep 2002",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(thickness: w * 0.0004),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "9744930917",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.036,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.04),
                Center(
                  child: Text(
                    "Version 0.1.10",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(authControllerProvider.notifier).logOut(context: context);
                    },
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: h * 0.018,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
