import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/common/error_text.dart';
import 'package:hypnohand/core/common/loader.dart';
import 'package:hypnohand/model/courseModel.dart';
import 'package:hypnohand/feature/home/controller/homecontroller.dart';

import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../core/global_variables/global_variables.dart';
import '../../core/theme/pallete.dart';
import '../connectivity/connectivity.dart';
import '../single_course/screen/single_course.dart';

class AllCourse extends ConsumerStatefulWidget {
  const AllCourse({super.key});

  @override
  ConsumerState<AllCourse>   createState() => _AllCourseState();
}
final searchcontrol=StateProvider((ref) => "");

class _AllCourseState extends ConsumerState<AllCourse> {
  // final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  // bool _isDeviceConnected = false;
  // var connectionStatus;
  // final internetConnectionStatusProvider =
  // StateProvider<InternetStatus>(
  //         (ref) => InternetStatus.connected);
  //
  // final internetcheckProvider = StateProvider((ref) => false);
  //
  // checkConnection() async {
  //
  //   _isDeviceConnected = await InternetConnection().hasInternetAccess;
  //   if(_isDeviceConnected){
  //     connectionStatus =  InternetStatus.connected;
  //   }else{
  //
  //
  //     connectionStatus =  InternetStatus.disconnected;
  //
  //
  //   }
  //
  //   ref.watch(internetConnectionStatusProvider.notifier).state =
  //       connectionStatus;
  //   ref.watch(internetcheckProvider.notifier).state = _isDeviceConnected;
  //   if (_isDeviceConnected) {
  //     _buttonController.success();
  //   } else {
  //     _buttonController.stop();
  //
  //     const snackBar=SnackBar(content: Text("No active connection found"));
  //
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //
  //   }
  //   InternetConnection().onStatusChange.listen((result) async {
  //     _buttonController.stop();
  //     if (result != InternetStatus.disconnected) {
  //       _isDeviceConnected = await InternetConnection().hasInternetAccess;
  //
  //       connectionStatus =  InternetStatus.connected;
  //
  //       ref.read(internetConnectionStatusProvider.notifier).state =
  //           connectionStatus;
  //       ref.read(internetcheckProvider.notifier).state = _isDeviceConnected;
  //     }
  //     else {
  //       _buttonController.reset();
  //       ref.read(internetConnectionStatusProvider.notifier).state =
  //           InternetStatus.disconnected;
  //       ref.read(internetcheckProvider.notifier).state = false;
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    print('course-------------');
    // checkConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Color(0xFFF8F6F4),
      body:
      // ref.watch(internetConnectionStatusProvider)==InternetStatus.disconnected?Center(child: Text("no internet"),):
       ref.watch(connectivityProvider)==ConnectivityStatus.disconnected?Center(child: Text("No internet Connection"),) :
      Column(
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
                // Icon(
                //   CupertinoIcons.info_circle,
                //   size: h * 0.024,
                // ),
                SizedBox(width: w * 0.05),
              ],
            ),
          ),
          Consumer(builder: (context, ref, child) {
            return Padding(
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
                  onChanged: (value) {
                    ref.watch(searchcontrol.notifier).update((state) => value.trim());

                  },
                ),
              ),
            );
          },),
          ///chabnge
          Consumer(builder: (context, ref, child) {
            final searchdata=ref.watch(searchcontrol);
            return ref.watch(getCoursebysearch(searchdata)).when(data: (data) {
              return data.isEmpty?Text("courses is not found"):Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final models=data[index];

                    return Padding(
                      padding: EdgeInsets.fromLTRB(w * 0.04, 0, w * 0.04, h * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CourseSingleView(
                                courseModel: models,
                              ),
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
                                  width: w * 0.31,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(w * 0.03),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            '${data[index].thumbnailImage}',
                                              // "https://imgs.search.brave.com/k9eYS2reZrZ0ZG5zxUXIrbxU4ae9mhgZyH1icMCqcb8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pMS53/cC5jb20vd3d3Lm1l/bnRhbGlzbXByby5j/b20vd3AtY29udGVu/dC91cGxvYWRzL21l/bnRhbGlzbS1jb3Vy/c2UuanBnP3Jlc2l6/ZT02MDAsNDAwJnNz/bD0x",

                                              ),
                                          fit: BoxFit.fill)),
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
                                                "Course${index+1}",
                                                style: TextStyle(
                                                  fontSize: h * 0.013,
                                                  color: Palette.blackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Icon(
                                          //   CupertinoIcons.bookmark,
                                          //   size: h * 0.025,
                                          // )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.5,
                                      height: h * 0.04,
                                      child: Text(
                                        data[index].coursename.toString(),
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
                                            "₹${data[index].ogprice.toString()}",
                                            style: TextStyle(
                                                fontSize: h * 0.022,
                                                color: Palette.blackColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(width: w * 0.02),
                                          Text(
                                            "₹${data[index].showprice.toString()}",
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
                                      "☆4.5 ",
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
              );
            }, error: (error, stackTrace) {
              print(error.toString());
              return ErrorText(error: error.toString());
            }, loading: () =>   Loader(),);

          },),

        ],
      ),

    );
  }
}
