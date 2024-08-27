import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../../core/constands/image_constants.dart';
import '../../../../core/global_variables/global_variables.dart';
import '../../../../core/utils.dart';
import '../../../../theme/pallete.dart';
import '../../../connectivity/connectivity.dart';
import '../controller/auth_controller.dart';

class  SignUp_page extends ConsumerStatefulWidget {
  const SignUp_page({super.key});

  @override
  ConsumerState createState() => _SignUp_pageState();
}

class _SignUp_pageState extends ConsumerState<SignUp_page> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  // Timer? _timer;

  bool passwordMask = false;
  bool confirmMask = false;

  bool clicked = false;

  signInUser() async {
    ref.read(authControllerProvider.notifier).createUserWithEmailAndPassword(
        ref: ref,
        email: _emailcontroller.text,
        password: passwordController.text,
        context: context,
        name: _namecontroller.text,
        number: _numbercontroller.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    passwordController.dispose();
    _numbercontroller.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Urbanist',
              fontSize: w * 0.042,
              color: Colors.black),
        ),
      ),
      body:       ref.watch(connectivityProvider)==ConnectivityStatus.disconnected?Center(child: Text("No internet Connection"),) :
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: h * 0.03),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.0688,
                  width: w * 0.2,
                  decoration: BoxDecoration(

                      // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: textGreyColor,
                          width: w * 0.003,
                        ),
                        left:
                            BorderSide(color: textGreyColor, width: w * 0.003),
                        top: BorderSide(color: textGreyColor, width: w * 0.003),
                        right:
                            BorderSide(color: textGreyColor, width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(w * 0.08),
                          topLeft: Radius.circular(w * 0.08))
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                      ),
                  child: Center(
                    child: Text(
                      "Name",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.034,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.0688,
                  width: w * 0.68,
                  child: TextFormField(
                    cursorColor: greyColor,
                    controller: _namecontroller,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixStyle: const TextStyle(
                          backgroundColor: blackColor,
                          decoration: TextDecoration.lineThrough),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: greyColor, width: w * 0.003),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(w * 0.08),
                          topRight: Radius.circular(
                            w * 0.08,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(w * 0.08),
                          bottomRight: Radius.circular(w * 0.08),
                        ),
                        borderSide: const BorderSide(color: greyColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.0688,
                  width: w * 0.2,
                  decoration: BoxDecoration(

                      // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: w * 0.003,
                        ),
                        left: BorderSide(color: Colors.grey, width: w * 0.003),
                        top: BorderSide(color: Colors.grey, width: w * 0.003),
                        right: BorderSide(color: Colors.grey, width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(w * 0.08),
                        topLeft: Radius.circular(w * 0.08),
                      )
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                      ),
                  child: Center(
                    child: Text(
                      "Email",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.034,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.0688,
                  width: w * 0.68,
                  // color: Colors.red,
                  child: TextFormField(
                    cursorColor: greyColor,
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixStyle: const TextStyle(
                          backgroundColor: Colors.red,
                          decoration: TextDecoration.lineThrough),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: w * 0.003),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(w * 0.08),
                          topRight: Radius.circular(w * 0.08),
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(w * 0.08),
                          bottomRight: Radius.circular(w * 0.08),
                        ),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.03,
            ),
            SizedBox(
              width: w * 0.9,
              child: IntlPhoneField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: greyColor,
                  controller: _numbercontroller,
                  validator: (value) {
                    if (_numbercontroller.text.isEmpty) {
                      return "  Enter Valid Number";
                    }
                    return null;
                  },
                  flagsButtonPadding: EdgeInsets.only(left: w * 0.03),
                  textInputAction: TextInputAction.next,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.046,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  showDropdownIcon: true,
                  dropdownDecoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: greyColor, width: w * 0.004),
                    ),
                  ),
                  dropdownIconPosition: IconPosition.trailing,
                  showCountryFlag: false,
                  dropdownTextStyle: GoogleFonts.inter(
                    fontSize: w * 0.046,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    hintStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                        fontSize: w * 0.038),
                    prefix: SizedBox(
                      width: w * 0.05,
                    ),
                    suffixIcon: Padding(
                      padding:
                          EdgeInsets.only(right: w * 0.055, left: w * 0.01),
                      child: _numbercontroller.text.length == 10
                          ? SvgPicture.asset(Constants.tickIcon)
                          : const CircleAvatar(
                              backgroundColor: Colors.transparent,
                            ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.07),
                      borderSide: const BorderSide(color: greyColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.07),
                      borderSide: const BorderSide(color: greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.07),
                      borderSide: const BorderSide(color: greyColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.07),
                      borderSide: const BorderSide(color: greyColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: w * 0.03, vertical: w * 0.02),
                  ),
                  initialCountryCode: "IN"),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.0688,
                  width: w * 0.2,
                  decoration: BoxDecoration(

                      // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: w * 0.003,
                        ),
                        left: BorderSide(color: Colors.grey, width: w * 0.003),
                        top: BorderSide(color: Colors.grey, width: w * 0.003),
                        right: BorderSide(color: Colors.grey, width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(w * 0.08),
                        topLeft: Radius.circular(w * 0.08),
                      )
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                      ),
                  child: Center(
                    child: Text(
                      "Password",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.034,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.0688,
                  width: w * 0.68,
                  child: TextFormField(
                    cursorColor: greyColor,
                    obscureText: passwordMask,
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // ref.watch(showPasswordProvider.notifier).update((state) => !state);
                          setState(
                            () {
                              passwordMask = !passwordMask;
                            },
                          );
                        },
                        child: Icon(
                          passwordMask
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xff909090),
                        ),
                      ),
                      prefixStyle: const TextStyle(
                          backgroundColor: blackColor,
                          decoration: TextDecoration.lineThrough),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: greyColor, width: w * 0.003),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(w * 0.08),
                          topRight: Radius.circular(
                            w * 0.08,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(w * 0.08),
                          bottomRight: Radius.circular(w * 0.08),
                        ),
                        borderSide: const BorderSide(color: greyColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.0688,
                  width: w * 0.2,
                  decoration: BoxDecoration(

                      // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: w * 0.003,
                        ),
                        left: BorderSide(color: Colors.grey, width: w * 0.003),
                        top: BorderSide(color: Colors.grey, width: w * 0.003),
                        right: BorderSide(color: Colors.grey, width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(w * 0.08),
                          topLeft: Radius.circular(w * 0.08))
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                      ),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.034,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.0688,
                  width: w * 0.68,
                  child: TextFormField(
                    cursorColor: greyColor,
                    obscureText: confirmMask,
                    controller: confirmController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // ref.watch(showPasswordProvider.notifier).update((state) => !state);
                          setState(
                            () {
                              confirmMask = !confirmMask;
                            },
                          );
                        },
                        child: Icon(
                          confirmMask ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xff909090),
                        ),
                      ),
                      prefixStyle: const TextStyle(
                          backgroundColor: blackColor,
                          decoration: TextDecoration.lineThrough),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: greyColor, width: w * 0.003),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(w * 0.08),
                          topRight: Radius.circular(w * 0.08),
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(w * 0.08),
                          bottomRight: Radius.circular(w * 0.08),
                        ),
                        borderSide: const BorderSide(color: greyColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.03),
                        borderSide: const BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.3),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          passwordController.text.isEmpty
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Please complete your own password")))
              : passwordController.text.length < 6
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("password length must be greater than 6")))
                  : confirmController.text.isEmpty
                      ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("please confirm your password")))
                      : confirmController.text != passwordController.text
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("your password does not match")))
                          : _emailcontroller.text.isNotEmpty &&
                                  _emailcontroller.text.contains('@') &&
                                  _emailcontroller.text.contains('.com')
                              ? signInUser()
                              : showSnackbar(context, 'enter valid email');
        },
        child: Container(
          width: w * 0.9,
          height: h * 0.07,
          decoration: BoxDecoration(
              color: orangeColor, borderRadius: BorderRadius.circular(w * 0.1)),
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
///chabnge