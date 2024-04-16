import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/common/shimmer.dart';
import 'package:hypnohand/core/constands/image_constants.dart';
import 'package:hypnohand/model/courseModel.dart';
import 'package:hypnohand/feature/auth/login/controller/auth_controller.dart';
import 'package:hypnohand/feature/home/controller/homecontroller.dart';
import 'package:hypnohand/feature/single_course/screen/single_course.dart';
import 'package:hypnohand/model/usermodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/common/error_text.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/theme/pallete.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool performanceDataLoaded=true;

  static const _images = [
    'assets/Banner1.jpg',
    'assets/Banner1.jpg',
    'assets/Banner1.jpg',
  ];

  getUser() {
    ref.read(authControllerProvider.notifier).getUser();
  }

  void launchYouTubeVideo(String uri) async {
    final url = Uri.parse(uri.toString());

    // Check if the URI is empty or null before attempting to launch
    if (uri == null || uri.isEmpty) {
      print('URI is empty or null');
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  void initState() {
    getUser();
    print('home screeeen------------------------');
    print(userModel?.email ?? 'email not found');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.05),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hello ',
                          style: TextStyle(
                              fontSize: h * 0.022,
                              color: Palette.blackColor,
                              fontWeight: FontWeight.w300),
                          children: <TextSpan>[
                            TextSpan(
                              text: userModel?.name ?? 'user',
                              style: TextStyle(
                                  fontSize: h * 0.022,
                                  color: Palette.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Now let's start exploring",
                          style: TextStyle(
                              fontSize: h * 0.018,
                              color: Palette.blackColor,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: w * 0.05,
                    backgroundImage: AssetImage(Constants.logo),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.03),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, 0),
            //   child: Container(
            //     height: h * 0.055,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(w * 0.03),
            //       color: Color(0xFFEFECE8),
            //     ),
            //     child: Row(
            //       children: [
            //         SizedBox(width: w * 0.03),
            //         Icon(
            //           CupertinoIcons.search,
            //           size: h * 0.027,
            //           color: Colors.black38,
            //         ),
            //         SizedBox(width: w * 0.03),
            //         Text(
            //           "Type Something here...",
            //           style: TextStyle(
            //             fontSize: h * 0.017,
            //             color: Colors.black38,
            //           ),
            //         ),
            //         Spacer(),
            //         Icon(
            //           Icons.filter_alt_outlined,
            //           size: h * 0.026,
            //           color: Colors.black38,
            //         ),
            //         SizedBox(width: w * 0.03),
            //       ],
            //     ),
            //     // child: TextFormField(
            //     //   style:
            //     //       TextStyle(color: Palette.blackColor, fontSize: h * 0.02),
            //     //   decoration: InputDecoration(
            //     //     border: OutlineInputBorder(
            //     //       borderSide: BorderSide(
            //     //           color: Palette.whiteColor, width: w * 0.002),
            //     //       borderRadius: BorderRadius.circular(w * 0.03),
            //     //     ),
            //     //     enabledBorder: OutlineInputBorder(
            //     //       borderSide: BorderSide(
            //     //           color: Palette.blackColor, width: w * 0.002),
            //     //       borderRadius: BorderRadius.circular(w * 0.03),
            //     //     ),
            //     //     focusedBorder: OutlineInputBorder(
            //     //       borderSide: BorderSide(
            //     //           color: Palette.whiteColor, width: w * 0.002),
            //     //       borderRadius: BorderRadius.circular(w * 0.03),
            //     //     ),
            //     //     hintText: "Search here",
            //     //     hintStyle: TextStyle(
            //     //         fontSize: h * 0.016,
            //     //         color: Palette.blackColor,
            //     //         fontWeight: FontWeight.w200),
            //     //   ),
            //     // ),
            //   ),
            // ),
            SizedBox(height: h * 0.03),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //     height: h * 0.25,
            //     child: ScrollPageView(
            //       controller: ScrollPageController(),
            //       delay: const Duration(seconds: 3),
            //       indicatorAlign: Alignment.bottomCenter,
            //       indicatorRadius: 3,
            //       children: (_images.reversed)
            //           .map((image) => _imageView(image))
            //           .toList(),
            //     ),
            //   ),
            // ),
            ////////////////////////////////////////////////////////////////////////
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(getBannerFuture).when(
                  data: (data) {
                    print(data.toString());
                    if (data.sliders.isEmpty) {
                      // Handle empty slider data
                      return const Text("No slider images available");
                    }

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: h * 0.28,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        disableCenter: false,
                        padEnds: true,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.0,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: data.sliders.map((data) {
                        print(data);
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(data.toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                  error: (error, stackTrace) {
                    print("sa");
                    return ErrorText(
                      error: error.toString(),
                      mess: "saa",
                    );
                  },
                  loading: () {
                    return const ShimmerWidget();
                  },
                );
              },
            ),

            SizedBox(height: h * 0.02),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, h * 0.003),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Performance",
                    style: TextStyle(
                        color: Palette.secondaryColor,
                        fontSize: w * 0.044,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Palette.blackColor,
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                return ref.watch(getPerformance).when(
                      data: (data) {
                        print(data);
                        return data.isEmpty
                            ? Text("empty")
                            : Padding(
                                padding: EdgeInsets.only(left: w * 0.02),
                                child: SizedBox(
                                  height: h * 0.175,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,

                                    itemBuilder: (context, index) {
                                      // if(data.length>0){
                                      //   performanceDataLoaded=false;
                                      // }
                                      String s =
                                          data[index].videolink.toString();
                                      if (s.isEmpty) {
                                        print("empty");
                                      } else {
                                        print("not empty");
                                      }
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(w * 0.02,
                                            w * 0.02, w * 0.03, w * 0.02),
                                        child: GestureDetector(
                                          onTap: () {
                                            launchYouTubeVideo(s);
                                            // FirebaseFirestore.instance.collection("courses").doc("001").update({
                                            //   "search":setSearchParam("Mentalism Malayalam")
                                            // });
                                          },
                                          child: Container(
                                            width: w * 0.5,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(1, 0),
                                                      blurRadius: 3)
                                                ],
                                                color: Palette.whiteColor,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data[index]
                                                            .perfcontent
                                                            .toString()),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.04),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade50)),
                                            child: Container(
                                              width: w * 0.52,
                                              height: h * 0.175,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.04),
                                                color: Colors.black38,
                                              ),
                                              child: Icon(
                                                CupertinoIcons.play_circle,
                                                color: Colors.white,
                                                size: w * 0.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                      },
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => ShimmerWidget(),
                    );
              },
            ),

            SizedBox(height: h * 0.03),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, h * 0.003),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Courses",
                    style: TextStyle(
                        color: Palette.secondaryColor,
                        fontSize: w * 0.044,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Palette.blackColor,
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(getCourseList).when(
                      data: (data) {
                        return data.isEmpty
                            ? Text("No courses")
                            : Padding(
                                padding: EdgeInsets.only(left: w * 0.02),
                                child: SizedBox(
                                  height: h * 0.255,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      coursemodell = data[index];

                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(w * 0.02,
                                            w * 0.02, w * 0.03, w * 0.02),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    CourseSingleView(
                                                  courseModel: data[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            width: w * 0.5,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            w * 0.04),
                                                    child: Image.network(
                                                      "${data[index].thumbnailImage.toString()}",
                                                      width: w * 0.5,
                                                      height: h * 0.15,
                                                      fit: BoxFit.cover,
                                                    )),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      w * 0.01,
                                                      h * 0.003,
                                                      w * 0.01,
                                                      0),
                                                  child: Text(
                                                    data[index]
                                                        .coursename
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Palette.blackColor,
                                                        fontSize: h * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      w * 0.01, 0, w * 0.02, 0,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text(
                                                      //   "16 Students",
                                                      //   style: TextStyle(
                                                      //       color: Palette.blackColor,
                                                      //       fontSize: w * 0.029,
                                                      //       fontWeight: FontWeight.w400),
                                                      // ),
                                                      Spacer(),
                                                      Icon(CupertinoIcons.star,
                                                          size: w * 0.03),
                                                      Text(
                                                        " 4.5",
                                                        style: TextStyle(
                                                            color: Palette
                                                                .blackColor,
                                                            fontSize: w * 0.032,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                      },
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => ShimmerWidget(),
                    );
              },
            ),
            SizedBox(height: h * 0.01),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, h * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                        color: Palette.secondaryColor,
                        fontSize: w * 0.044,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Palette.blackColor,
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.02),
              child: SizedBox(
                height: h * 0.25,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * 0.02, w * 0.01, w * 0.03, w * 0.02),
                      child: Container(
                        width: w * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Review.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(w * 0.04),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(w * 0.05),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}