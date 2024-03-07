import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/feature/auth/login/controller/auth_controller.dart';
import 'package:hypnohand/theme/pallete.dart';
import '../../../../core/constands/image_constants.dart';
import '../../../../core/global_variables/global_variables.dart';
import '../../../../core/utils.dart';
import '../../../../theme/pallete.dart';

class EmailSignIn extends ConsumerStatefulWidget {
  const EmailSignIn({super.key});

  @override
  ConsumerState<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends ConsumerState<EmailSignIn> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int passwordError = 0;
  int emailValidation = 0;
  bool emailEntered = false;

  signIn(){
    if(emailController.text.isNotEmpty&&emailController.text.contains('@')&&emailController.text.contains('.com')){
      ref.read(authControllerProvider.notifier).signInWithEmailAndPassword(email: emailController.text, password: passwordController.text ,context: context,ref: ref);
    }else{
      showSnackbar(context, 'enter valid email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.06,
                  width: w * 0.2,
                  decoration: BoxDecoration(
                    // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: emailValidation == 0
                              ? Colors.grey
                              : emailValidation == 1
                              ? Colors.red
                              : Colors.green,
                          width: w * 0.003,
                        ),
                        left: BorderSide(
                            color: emailValidation == 0
                                ? Colors.grey
                                : emailValidation == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.003),
                        top: BorderSide(
                            color: emailValidation == 0
                                ? Colors.grey
                                : emailValidation == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.003),
                        right: BorderSide(
                            color: emailValidation == 0
                                ? Colors.grey
                                : emailValidation == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(w * 0.08),
                          topLeft: Radius.circular(w * 0.08))
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                  ),
                  child: Center(
                    child: Text(
                      "Email",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.06,
                  width: w * 0.68,
                  // color: Colors.red,
                  child: TextFormField(
                    cursorColor: greyColor,
                    onChanged: (value) {
                      setState(
                            () {
                          emailEntered = true;
                        },
                      );
                      if (value!.isEmpty) {
                        emailValidation = 0;
                        setState(() {});
                        return;
                      }
                      final emailRegexp = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegexp.hasMatch(value)) {
                        emailValidation = 1;
                        setState(() {});
                        return;
                      }
                      emailValidation = 2;
                      setState(() {});
                      return;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixStyle: const TextStyle(
                          backgroundColor: Colors.red,
                          decoration: TextDecoration.lineThrough),
                      hintText: emailEntered
                          ? "please enter email"
                          : "",
                      hintStyle: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: w * 0.033),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: emailValidation == 0
                                ? Colors.grey
                                : emailValidation == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.003),
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
                        borderSide: BorderSide(
                          color: emailValidation == 0
                              ? Colors.grey
                              : emailValidation == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(w * 0.03),
                        borderSide: BorderSide(
                          color: emailValidation == 0
                              ? Colors.grey
                              : emailValidation == 1
                              ? Colors.red
                              : Colors.green,
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
                  height: h * 0.06,
                  width: w * 0.2,
                  decoration: BoxDecoration(
                    // border: Border.(color: Colors.grey),
                      border: Border(
                        bottom: BorderSide(
                          color: passwordError == 0
                              ? Colors.grey
                              : passwordError == 1
                              ? Colors.red
                              : Colors.green,
                          width: w * 0.003,
                        ),
                        left: BorderSide(
                            color: passwordError == 0
                                ? Colors.grey
                                : passwordError == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.003),
                        top: BorderSide(
                            color: passwordError == 0
                                ? Colors.grey
                                : passwordError == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.003),
                        right: BorderSide(
                            color: passwordError == 0
                                ? Colors.grey
                                : passwordError == 1
                                ? Colors.red
                                : Colors.green,
                            width: w * 0.001),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(w * 0.08),
                          topLeft: Radius.circular(w * 0.08))
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.08),topLeft: Radius.circular(w*0.08)),

                  ),
                  child: Center(
                      child: Text(
                          "Password",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: w * 0.04))),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    // bool mask = ref.watch(showPasswordProvider);
                    return SizedBox(
                      height: h * 0.06,
                      width: w * 0.68,
                      // color: Colors.red,
                      child: TextFormField(
                          cursorColor: greyColor,
                          // obscureText: mask,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              passwordError = 0;
                              setState(() {});
                            } else if (value.length < 8) {
                              passwordError = 1;
                              setState(() {});
                              // return "  Enter Atleast 8 Characters";
                            } else {
                              passwordError = 2;
                              setState(() {});
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: w * 0.015, left: w * 0.03),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // print("mask---$mask");
                                // ref.read( showPasswordProvider.notifier).update((state) => !mask);
                                // print(mask);
                              },
                              child: Padding(
                                padding:
                                EdgeInsets.all(w * 0.032),
                                child: SvgPicture.asset(
                                  Constants.maskPassword,
                                  height: h * 0.02,
                                ),
                              ),
                            ),
                            prefixStyle: TextStyle(
                                backgroundColor: Colors.red,
                                decoration:
                                TextDecoration.lineThrough),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: passwordError == 0
                                      ? Colors.grey
                                      : passwordError == 1
                                      ? Colors.red
                                      : Colors.green,
                                  width: w * 0.003),
                              borderRadius: BorderRadius.only(
                                bottomRight:
                                Radius.circular(w * 0.08),
                                topRight: Radius.circular(
                                  w * 0.08,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(w * 0.08),
                                bottomRight:
                                Radius.circular(w * 0.08),
                              ),
                              borderSide: BorderSide(
                                color: passwordError == 0
                                    ? Colors.grey
                                    : passwordError == 1
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(w * 0.03),
                                borderSide: BorderSide(
                                  color: passwordError == 0
                                      ? Colors.grey
                                      : passwordError == 1
                                      ? Colors.red
                                      : Colors.green,
                                )),
                          )),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: w * 0.05),
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.roboto(
                      letterSpacing: 0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: w * 0.042),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            GestureDetector(
              onTap: () {
                {
                  if (emailController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            padding: EdgeInsets.only(
                                top: w * 0.026, bottom: w * 0.026),
                            backgroundColor: redColor,
                            content: Center(
                              child: Text(
                                "Please Enter Email",
                                style: GoogleFonts.roboto(
                                    letterSpacing: 0,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: w * 0.038),
                              ),
                            )));
                  } else if (emailController.text.trim().length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            padding: EdgeInsets.only(
                                top: w * 0.026, bottom: w * 0.026),
                            backgroundColor: redColor,
                            content: Center(
                              child: Text(
                                "Please Enter Valid Email",
                                style: GoogleFonts.roboto(
                                    letterSpacing: 0,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: w * 0.038),
                              ),
                            )));
                  } else if (passwordController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            padding: EdgeInsets.only(
                                top: w * 0.026, bottom: w * 0.026),
                            backgroundColor: redColor,
                            content: Center(
                              child: Text(
                                "Please Enter Password",
                                style: GoogleFonts.roboto(
                                    letterSpacing: 0,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: w * 0.038),
                              ),
                            )));
                  } else {
                    if (formkey.currentState!.validate()) {
                      passwordError = 2;
                      Map d = {
                        "email": emailController.text.trim(),
                        "password": passwordController.text.trim()
                      };
                      // String data = jsonEncode(d);
                      // userLogin(context, data);
                      signIn();

                    }
                  }
                }
                ;
              },
              child: Container(
                height: h * 0.06,
                width: w * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.08),
                    // gradient: Palette.gradient1,
                    color: orangeColor,
                    ),
                child: Center(
                  child: Text(
                    "Login",
                    style: GoogleFonts.roboto(
                        letterSpacing: 0,
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: w * 0.048),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
      
          ],
        ),
      ),
    );
  }
}
