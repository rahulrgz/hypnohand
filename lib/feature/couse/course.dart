import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/global_variables/global_variables.dart';
import '../../core/theme/pallete.dart';
import '../single_course/screen/single_course.dart';

class AllCourse extends StatefulWidget {
  const AllCourse({super.key});

  @override
  State<AllCourse> createState() => _AllCourseState();
}

class _AllCourseState extends State<AllCourse> {
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF8F6F4),
      body: Column(
        children: [
          SizedBox(
            height: h * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: w * 0.05),
                Text(
                  "Courses",
                  style: TextStyle(
                      fontSize: h * 0.023,
                      color: Palette.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.info_circle,
                  size: h * 0.024,
                ),
                SizedBox(width: w * 0.05),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(w * 0.045, h * 0.01, w * 0.045, h * 0.02),
            child: SizedBox(
              height: h * 0.05,
              child: TextFormField(
                style: TextStyle(color: Colors.grey, fontSize: h * 0.02),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey, width: w * 0.002),
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey, width: w * 0.002),
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey, width: w * 0.002),
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  hintText: "Search here",
                  hintStyle: TextStyle(
                      fontSize: h * 0.016,
                      color: Palette.blackColor,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, h * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CourseSingleView(),
                        ),
                      );
                    },
                    child: Container(
                      width: w,
                      height: h * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.04),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(w * 0.033),
                        child: Row(
                          children: [
                            Container(
                              width: w * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w * 0.03),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://imgs.search.brave.com/k9eYS2reZrZ0ZG5zxUXIrbxU4ae9mhgZyH1icMCqcb8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pMS53/cC5jb20vd3d3Lm1l/bnRhbGlzbXByby5j/b20vd3AtY29udGVu/dC91cGxvYWRzL21l/bnRhbGlzbS1jb3Vy/c2UuanBnP3Jlc2l6/ZT02MDAsNDAwJnNz/bD0x"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(width: w * 0.036),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h * 0.025,
                                  width: w * 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: h * 0.02,
                                        width: w * 0.14,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05),
                                          border: Border.all(
                                              color: Colors.black54,
                                              width: w * 0.001),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Level 0",
                                            style: TextStyle(
                                              fontSize: h * 0.013,
                                              color: Palette.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        CupertinoIcons.bookmark,
                                        size: h * 0.025,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: w * 0.5,
                                  height: h * 0.04,
                                  child: Text(
                                    "Mentalism & Mind Reading Tricks | Hypnohand Academy",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: h * 0.016,
                                        color: Palette.blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: w * 0.5,
                                  height: h * 0.024,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "₹1299",
                                        style: TextStyle(
                                            fontSize: h * 0.022,
                                            color: Palette.blackColor,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(width: w * 0.02),
                                      Text(
                                        "₹1799",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: h * 0.015,
                                            color: Palette.blackColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "☆4.5 | 180 Students",
                                  style: TextStyle(
                                    color: Palette.secondaryColor,
                                    fontSize: h * 0.015,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
