import 'package:estate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreeen extends StatefulWidget {
  final String videoUrl;
  const PlayVideoScreeen({Key? key, required this.videoUrl}) : super(key: key);

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
                                color: grey3,
                                size: 60,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/heart.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/ring.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/message.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/eye.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
}
