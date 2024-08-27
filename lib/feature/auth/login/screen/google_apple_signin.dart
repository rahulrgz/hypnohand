import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:hypnohand/core/constands/image_constants.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';
import 'package:hypnohand/core/utils.dart';
import 'package:hypnohand/feature/connectivity/connectivity.dart';
import 'package:hypnohand/theme/pallete.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controller/auth_controller.dart';
///chabnge
class GoogleApplesignin extends ConsumerStatefulWidget {
  const GoogleApplesignin({super.key});

  @override
  ConsumerState<GoogleApplesignin> createState() => _GoogleApplesigninState();
}

class _GoogleApplesigninState extends ConsumerState<GoogleApplesignin> {
  signInUser() async {
    ref.read(authControllerProvider.notifier).upDateGoogleSignInDoc(
        ref: ref,
         phone: _numbercontroller.text,
        name: _namecontroller.text,
        context: context);
    // showSnackbar(context, 'mobile Number not Verified..try again');
  }

  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _namecontroller.dispose();
    _numbercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Fill your Profile",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Urbanist',
              fontSize: w * 0.039,
              color: Colors.black),
        ),
      ),
      body:ref.watch(connectivityProvider)==ConnectivityStatus.disconnected?Center(child: Text("No Internet Connection"),):SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.3,
              child: Center(
                  child: Image.asset(
                Constants.logo,
                height: h * 0.2,
              )),
            ),
            SizedBox(height: h * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.0688,
                  width: w * 0.22,
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
                      " Name ",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: w * 0.04),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.0688,
                  width: w * 0.68,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    controller: _namecontroller,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixStyle: const TextStyle(
                          backgroundColor: Colors.black,
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
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.04),
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
                        right: BorderSide(color: greyColor, width: w * 0.004)),
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
                      contentPadding:
                          EdgeInsets.only(left: w * 0.03, bottom: w * 0.02)),
                  initialCountryCode: "IN"),
            ),
            SizedBox(height: h * 0.2),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (_namecontroller.text == '' || _namecontroller.text.length < 4) {
            showSnackbar(context, 'name should be atleast 4 charecters');
          } else if (_numbercontroller.text == '' ||
              _numbercontroller.text.length != 10) {
            showSnackbar(context, 'enter valid number');
          } else {
            signInUser();
          }
        },
        child: Container(
          width: w * 0.91,
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
