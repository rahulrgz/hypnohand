import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';
import 'package:hypnohand/feature/auth/login/controller/auth_controller.dart';

 showAlertDialog(BuildContext context,WidgetRef ref) {
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * 0.01),
        ),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(

              children: [
                SizedBox(height: h*0.025,),
                Text('Are you sure you want to logout?',style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: w * 0.035,
                          color: Colors.black,
                        ),),
                SizedBox(height: h*0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text(
                        "cancel",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                          ref.read(authControllerProvider.notifier).logOut(context: context);
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
  
}

void showSnackbar(BuildContext context,String text){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(text),));
}
setSearchParam(String search) {
  List<String> searchList = [];
  for (int i = 0; i <= search.length; i++) {
    for (int j = i + 1; j <= search.length; j++) {
      searchList.add(search.substring(i, j).toUpperCase().trim());
    }
  }
  return searchList;
}