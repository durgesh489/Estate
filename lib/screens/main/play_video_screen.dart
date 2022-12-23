import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreeen extends StatefulWidget {
  final String videoUrl;
  final DocumentSnapshot ds;
  const PlayVideoScreeen({Key? key, required this.videoUrl, required this.ds})
      : super(key: key);

  @override
  State<PlayVideoScreeen> createState() => _PlayVideoScreeenState();
}

class _PlayVideoScreeenState extends State<PlayVideoScreeen> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  bool isPlay = true;

  loadVideoPlayer() {
    controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
    // controller = VideoPlayerController.network(widget.videoUrl);
    initializeVideoPlayerFuture = controller.initialize();
    controller.play();
    controller.setLooping(true);

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
      body: SafeArea(
          child: FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? Stack(
                        children: [
                          VideoPlayer(controller),
                          Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () {
                                if (controller.value.isPlaying) {
                                  controller.pause();
                                } else {
                                  controller.play();
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: white,
                                size: 50,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RoundedIcon("heart"),
                                  VSpace(10),
                                  RoundedIcon("eye"),
                                  VSpace(10),
                                  RoundedIcon("message"),
                                  VSpace(10),
                                  RoundedIcon("ring"),
                                  VSpace(70),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/location.png",
                                        color: white,
                                        width: 20,
                                        height: 20,
                                      ),
                                      HSpace(5),
                                      nAppText(widget.ds["location"]["city"],
                                          16, white)
                                    ],
                                  ),
                                  VSpace(3),
                                  nAppText(widget.ds["location"]["street"], 16,
                                      white)
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: white,
                        ),
                      );
              })),
    );
  }

  Widget RoundedIcon(String icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          "assets/$icon.png",
          width: 23,
          height: 23,
          color: black,
        ),
      ),
    );
  }
}
