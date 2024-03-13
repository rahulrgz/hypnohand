import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexivideoplayer/flexivideoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hypnohand/core/model/courseModel.dart';
import 'package:hypnohand/core/theme/pallete.dart';
import 'package:hypnohand/core/utils.dart';
import 'package:hypnohand/feature/single_course/screen/payMent.dart';
import 'package:hypnohand/feature/single_course/screen/videoscreenplay.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/global_variables/global_variables.dart';


class CourseSingleView extends StatefulWidget {
  final CourseModel courseModel;
  const CourseSingleView({super.key, required this.courseModel});

  @override
  State<CourseSingleView> createState() => _CourseSingleViewState();
}

class _CourseSingleViewState extends State<CourseSingleView> {
    late VideoPlayerController _videoPlayerController1;
     FlexiController? _FlexiController;
    bool isSourceError = false;
      @override
  void initState() {
    super.initState();
    initializePlayer();
  }

     Future<void> initializePlayer() async {

    setState(() {
      isSourceError = false;
    });
    try {
      _videoPlayerController1 =
          VideoPlayerController.networkUrl(Uri.parse(widget.courseModel.demovideolink.toString()));

      await _videoPlayerController1.initialize();


      final subtitles = [

        Subtitle(
          index: 0,
          start: const Duration(seconds: 0),
          end: Duration(seconds: _videoPlayerController1.value.duration.inSeconds),
          text: 'Whats up? :)',

        ),
      ];

      _FlexiController = FlexiController(

        aspectRatio: 16 / 9,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        allowFullScreen: true,
        fullScreenByDefault: false,
        allowedScreenSleep: false,
        videoPlayerController: _videoPlayerController1,
        autoPlay: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          print("Error find : $errorMessage");

          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        additionalOptions: (context) {
          return <OptionItem>[
            OptionItem(
              onTap: toggleVideo,
              iconData: Icons.live_tv_sharp,
              title: 'Toggle Video Src',
            ),
          ];
        },
        subtitle: Subtitles(subtitles),
        subtitleBuilder: (context, dynamic subtitle) =>
            Container(
              padding: const EdgeInsets.all(10.0),
              child: subtitle is InlineSpan
                  ? RichText(
                text: subtitle,
              )
                  : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),

        hideControlsTimer: const Duration(seconds: 3),

        // Try playing around with some of these other options:
        isBrignessOptionDisplay: true,
        isVolumnOptionDisplay: true,

        cupertinoProgressColors: FlexiProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white.withOpacity(0.5),
        ),

      );

      setState(() {});
    }
    catch(exception){

      setState(() {
        isSourceError = true;
      });
      print("exception : $exception");
    }
  }

  Future<void> toggleVideo() async {

    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(  floatingActionButton: FloatingActionButton.extended(onPressed: () {
Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  return PaymentScreen();
},));
      },

        label: Text('Buy Now'),
      ),

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
                      widget.courseModel.coursename.toString(),
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
              // Text(
              //   widget.courseModel.subname,
              //   style: TextStyle(
              //       color: Palette.blackColor,
              //       fontSize: w * 0.056,
              //       fontWeight: FontWeight.w600),
              // ),
              SizedBox(height: h * 0.005),
              // Text(
              //   "Among the many techniques and tricks that one needs to hone, there are also a few skills students need to master to become a mentalist. However, apart from obtaining the skills, people need to practice and sharpen these skills to gain perfection.",
              //   style: TextStyle(
              //       color: Palette.blackColor,
              //       fontSize: w * 0.026,
              //       fontWeight: FontWeight.w300),
              // ),
              // SizedBox(height:h*0.02),
              // SizedBox(height: h * 0.02),
              Container(
                color: Colors.black,
                child:  AspectRatio(aspectRatio: 16/9,
                  child:

                  isSourceError ?

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(CupertinoIcons.exclamationmark_circle,color: Colors.white,size: 30,),
                        SizedBox(height: 10),
                        Text('This video is unavailable',style: TextStyle(color: Colors.white,fontSize: 15),),

                        InkWell(
                          onTap: (){

                            initializePlayer();
                          },
                          child: Container(
                            height: 30,width: 100,alignment: Alignment.center,
                            child: Text("Reload again",style: TextStyle(color: Colors.red,fontSize: 13),),
                          ),
                        )
                      ]
                  )

                      :

                  _FlexiController != null ?
                  // &&
                  //        _FlexiController!
                  //            .videoPlayerController.value.isInitialized
                  //        ?
                  Flexi(
                    controller: _FlexiController!,
                  )
                      : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(strokeWidth: 2,color: Colors.red,),
                        SizedBox(height: 20),
                        Text('Loading',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ]
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.courseModel.listofvideo.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                       onTap:  () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreenPlay(
                           videolink: widget.courseModel.listofvideo[index]['videolink'],
                         ),));


                       },
                      child: Padding(
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
                                    "Level $index",
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
