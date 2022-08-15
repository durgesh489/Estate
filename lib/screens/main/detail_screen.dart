import 'package:estate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  final String videoUrl;
  const DetailScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
     
    );
  }
}
