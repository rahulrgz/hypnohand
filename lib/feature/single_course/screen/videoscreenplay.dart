import 'package:flexivideoplayer/flexivideoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:screen_protector/screen_protector.dart';


class VideoScreenPlay extends StatefulWidget {
  final String videolink;
  const VideoScreenPlay({super.key, required this.videolink});

  @override
  State<VideoScreenPlay> createState() => _VideoScreenPlayState();
}

class  _VideoScreenPlayState extends State<VideoScreenPlay> {
    late VideoPlayerController _videoPlayerController1;
  FlexiController?  _FlexiController;
  bool isSourceError = false;
  @override
  void initState() {
     super.initState();
     initializePlayer();
    avoidscreenshot();

  }
  avoidscreenshot()async{
    await ScreenProtector.protectDataLeakageOn();

  }


  Future<void> initializePlayer() async {
    setState(() {
      isSourceError = false;
    });
    try {
      _videoPlayerController1 = VideoPlayerController.networkUrl(
          Uri.parse(widget.videolink.toString()));

      await _videoPlayerController1.initialize();

      final subtitles = [
        Subtitle(
          index: 0,
          start: const Duration(seconds: 0),
          end: Duration(
              seconds: _videoPlayerController1.value.duration.inSeconds),
          text: '',
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
        fullScreenByDefault: true,
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
        subtitleBuilder: (context, dynamic subtitle) => Container(
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
    } catch (exception) {
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
  void dispose() {
    _FlexiController!.dispose();
    _videoPlayerController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: isSourceError
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This video is unavailable',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      initializePlayer();
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        "Reload again",
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  )
                ])
              : _FlexiController != null
                  ?
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
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Loading',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ]),
        ),
      ),
    );
  }
}
