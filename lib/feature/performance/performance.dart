import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/common/error_text.dart';
import 'package:hypnohand/core/common/loader.dart';
import 'package:hypnohand/feature/home/controller/homecontroller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/global_variables/global_variables.dart';
import '../../core/theme/pallete.dart';
import '../connectivity/connectivity.dart';

class Performence extends ConsumerStatefulWidget {
  const Performence({super.key});

  @override
  ConsumerState<Performence> createState() => _PerformenceState();
}

class _PerformenceState extends ConsumerState<Performence> {
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

  void launchYouTubeVideo(String uri ) async {
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
    // TODO: implement initState
    print('performnace--------');
    // checkConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final connectivityStatus = ref.watch(connectivityProvider);
    // return ref.watch(internetConnectionStatusProvider)==InternetStatus.disconnected?Center(child: Text("no internet"),):
    return Scaffold(
      backgroundColor: Color(0xFFEFECE8),
      body:connectivityStatus==ConnectivityStatus.disconnected?Center(child: Text("No internet Connection"),) :Column(
        children: [
          Container(
            height: h * 0.08,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: w * 0.04),
                Text(
                  "Performance",
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
                SizedBox(width: w * 0.04),
              ],
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: const BouncingScrollPhysics(),
          //     itemCount: 4,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: EdgeInsets.only(bottom: h * 0.01),
          //         child: Container(
          //           width: w,
          //           height: h * 0.33,
          //           color: Colors.white,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Stack(
          //                 children: [
          //                   Image.network(
          //                     "https://i.ytimg.com/vi/lgZn2A-bDWE/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBR4y-w7vnQPyoib6WekSfVYrshXQ",
          //                     width: w,
          //                     height: h * 0.25,
          //                     fit: BoxFit.cover,
          //                   ),
          //                   Container(
          //                     width: w,
          //                     height: h * 0.25,
          //                     decoration: BoxDecoration(
          //                       color: Colors.black38,
          //                     ),
          //                     child: Icon(
          //                       CupertinoIcons.play_circle,
          //                       color: Colors.white,
          //                       size: w * 0.1,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: h * 0.08,
          //                 child: Row(
          //                   children: [
          //                     SizedBox(width: w * 0.02),
          //                     CircleAvatar(
          //                       backgroundImage: NetworkImage(
          //                           "https://yt3.googleusercontent.com/_zVxlJFcYeTS0VaMNcC6VXGykmOpsdT8F-VuQzBHYTLXB2b7XP38OlOJGE_i9DL3qSnTBeYx=s900-c-k-c0x00ffffff-no-rj"),
          //                       radius: h * 0.025,
          //                     ),
          //                     SizedBox(width: w * 0.02),
          //                     Container(
          //                       width: w * 0.8,
          //                       child: Text(
          //                         "Mentalism & Mind reading Online Course - Dinner Table Routine Clip - Hypnohand Academy",
          //                         maxLines: 2,
          //                         overflow: TextOverflow.ellipsis,
          //                         style: TextStyle(
          //                           fontSize: h * 0.017,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(child: Consumer(builder: (context, ref, child) {
            return ref.watch(getPerformance).when(data: (data) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String s=data[index].videolink.toString();
                  return Padding(
                    padding: EdgeInsets.only(bottom: h * 0.01),
                    child: GestureDetector(
                      onTap: () {
                        launchYouTubeVideo(s);


                      },
                      child: Container(
                        width: w,
                        height: h * 0.33,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                  data[index].perfcontent.toString(),
                                  width: w,
                                  height: h * 0.25,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: w,
                                  height: h * 0.25,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.play_circle,
                                    color: Colors.white,
                                    size: w * 0.1,
                                  ),
                                )
                              ],
                             ),
                            SizedBox(
                              height: h * 0.08,
                              child: Row(
                                children: [
                                  SizedBox(width: w * 0.02),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://yt3.googleusercontent.com/_zVxlJFcYeTS0VaMNcC6VXGykmOpsdT8F-VuQzBHYTLXB2b7XP38OlOJGE_i9DL3qSnTBeYx=s900-c-k-c0x00ffffff-no-rj"),
                                    radius: h * 0.025,
                                  ),
                                  SizedBox(width: w * 0.02),
                                  Container(
                                    width: w * 0.8,
                                    child: Text(""
                                      // "Mentalism & Mind reading Online Course - Dinner Table Routine Clip -"
                                      //     " Hypnohand Academy"
                                      ,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: h * 0.017,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
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
              );
            }, error: (error, stackTrace) => ErrorText(error: error.toString()), loading:() => Loader(),
            );

          },))
        ],
      ),
    );
  }
}
