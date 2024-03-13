import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hypnohand/core/global_variables/global_variables.dart';

// File showAlertDialog(BuildContext context) {
//   late File photo;
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(w * 0.01),
//         ),
//         backgroundColor: Colors.white,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     photo = pickImageAndUpdate(ImageSource.gallery) as File;
//                     Navigator.pop(context); // Close the dialog
//                   },
//                   child: Text(
//                     "Select a Photo",
//                     style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w700,
//                       fontSize: w * 0.035,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     photo = pickImageAndUpdate(ImageSource.camera) as File;
//                     Navigator.pop(context); // Close the dialog
//                   },
//                   child: Text(
//                     "Open Camera",
//                     style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w700,
//                       fontSize: w * 0.035,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
//   return photo;
// }

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