import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hypnohand/core/theme/pallete.dart';
import '../../../../core/global_variables/global_variables.dart';
import '../chiew.dart';

class CourseSingleView extends StatefulWidget {
  const CourseSingleView({super.key});

  @override
  State<CourseSingleView> createState() => _CourseSingleViewState();
}

class _CourseSingleViewState extends State<CourseSingleView> {
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F6F4),
        body: Padding(
          padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: Palette.blackColor,
                        size: w * 0.06,
                      ),
                    ),
                    Text(
                      "Course One",
                      style: TextStyle(
                          color: Palette.blackColor,
                          fontSize: w * 0.044,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.more_vert_rounded,
                      color: Palette.blackColor,
                      size: w * 0.06,
                    ),
                  ],
                ),
              ),
              Text(
                "How to be Mentalist",
                style: TextStyle(
                    color: Palette.blackColor,
                    fontSize: w * 0.056,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: h * 0.005),
              Text(
                "Among the many techniques and tricks that one needs to hone, there are also a few skills students need to master to become a mentalist. However, apart from obtaining the skills, people need to practice and sharpen these skills to gain perfection.",
                style: TextStyle(
                    color: Palette.blackColor,
                    fontSize: w * 0.026,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: h * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChewieDemo(),
                    ),
                  );
                },
                child: Container(
                  height: h * 0.25,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: h * 0.11,
                                width: w * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w * 0.02),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/Banner1.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: h * 0.11,
                                width: w * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w * 0.02),
                                  color: Colors.black54,
                                ),
                                child: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: w * 0.02),
                          SizedBox(
                            width: w * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "How to be Mentalist",
                                  style: TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Tutor: Nafih",
                                  style: TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: w * 0.038,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Class 1",
                                  style: TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: w * 0.03,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "The class is about to teach them the tricks that one needs to hone. There are also a few skills students need to master to become a mentalist",
                                  style: TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: w * 0.02,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
