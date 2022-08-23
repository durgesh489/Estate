import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  final DocumentSnapshot ds;
  const DetailScreen({Key? key, required this.ds}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedImage = 0;
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
      backgroundColor: grey2,
      bottomNavigationBar: Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CallAndChatButton(),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Images(widget.ds),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Header1(),
                    Header2(),
                    Header3(),
                    Amenities(),
                    Description(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Images(DocumentSnapshot ds) {
    return Container(
      color: grey3,
      height: 220,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (val) {
              selectedImage = val;
              setState(() {});
            },
            children: [
              for (int i = 0; i < ds["info_images"].length; i++)
                Image.network(
                  ds["info_images"][i],
                  width: fullWidth(context),
                  height: 220,
                  fit: BoxFit.cover,
                )
            ],
          ),
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < ds["info_images"].length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: selectedImage == i ? grey : white,
                        shape: BoxShape.circle),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Header1() {
    return SizedBox(
      width: fullWidth(context),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithText("details", "Detail"),
              IconWithText("near", "Near By"),
              IconWithText("location", "Map View"),
              IconWithText("play_button", "Video Tour")
            ],
          ),
        ),
      ),
    );
  }

  Widget Header2() {
    return SizedBox(
      width: fullWidth(context),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normalText(
                  "Land For " +
                      widget.ds["sale_type"] +
                      " At " +
                      widget.ds["location"]["city"],
                  18),
              VSpace(5),
              Text(
                widget.ds["location"]["street"],
                style: TextStyle(color: grey, fontSize: 14),
                maxLines: 2,
              ),
              VSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bAppText(
                      "Price" +
                          " ₹" +
                          widget.ds["price"].toString() +
                          " / " +
                          widget.ds["land_area"] +
                          " " +
                          widget.ds["land_type"],
                      16,
                      black),
                  Container(
                    color: green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: nAppText("Negotiable", 13, white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Header3() {
    return SizedBox(
      width: fullWidth(context),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText("Details", 18),
              VSpace(10),
              TableItem(
                  "Property Face", widget.ds["more_details"]["property_face"]),
              TableItem("Road Type", widget.ds["more_details"]["road_type"]),
              TableItem(
                  "Land Usability", widget.ds["more_details"]["land_usability"])
            ],
          ),
        ),
      ),
    );
  }

  Widget Description() {
    return SizedBox(
      width: fullWidth(context),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText("Description", 18),
              VSpace(5),
              normalText(widget.ds["description"], 16)
            ],
          ),
        ),
      ),
    );
  }

  Widget IconWithText(String icon, String title) {
    return Column(
      children: [
        Card(
          elevation: 5,
          color: white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black12)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              "assets/$icon.png",
              width: 30,
              height: 30,
            ),
          ),
        ),
        VSpace(2),
        normalText(title, 13)
      ],
    );
  }

  Widget TableItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(flex: 3, child: normalText(title, 15)),
          Expanded(flex: 1, child: normalText("-", 20)),
          Expanded(flex: 2, child: boldText(value, 15))
        ],
      ),
    );
  }

  Widget Amenities() {
    return SizedBox(
      width: fullWidth(context),
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText("Amenities", 18),
              VSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWithText("Parking", "Parking"),
                  IconWithText("Wi-Fi", "Wi Fi"),
                  IconWithText("Plumbing", "Water Supply"),
                  IconWithText("Wall Mount Camera", "Security"),
                  IconWithText("Sprout", "Garden")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CallAndChatButton() {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            // minWidth: 90,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 45,
            color: green,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call,
                  color: white,
                  size: 25,
                ),
                HSpace(5),
                bAppText("Call", 18, white)
              ],
            ),
          ),
        ),
        HSpace(10),
        Expanded(
          child: SizedBox(
            // width: 90,
            height: 45,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/chat.png",
                    width: 30,
                    height: 30,
                  ),
                  HSpace(5),
                  bAppText("Chat", 18, black)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
