import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/screens/main/play_video_screen.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class LandScreen extends StatefulWidget {
  final String categoryName;
  const LandScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<LandScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<LandScreen> {
  int selected = 0;
  int saleTypeIndex = -1;
  int selectedImage = 0;
  double selectedPrice = 250000;
  TextEditingController searchController = TextEditingController();
  var lands;
  Future fetchLands() async {
    lands = await DatabaseMethods().getCollection(widget.categoryName);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mc,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   title: boldText("Lands", 25),
        //   centerTitle: true,
        //   leading: IconButton(
        //       onPressed: () {
        //         goBack(context);
        //       },
        //       icon: Icon(Icons.arrow_back_ios)),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
              stream: lands,
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return snapshot.hasData
                    ? snapshot.data!.docs.length == 0
                        ? Center(child: bAppText("Not Found", 16, white))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 30,
                                                  ),
                                                  HSpace(5),
                                                  nAppText(
                                                      ds["location"]["city"],
                                                      20,
                                                      black),
                                                ],
                                              ),
                                              Icon(
                                                Icons.favorite_outline,
                                                size: 30,
                                                color: red,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 220,
                                          child: Stack(
                                            children: [
                                              PageView(
                                                onPageChanged: (val) {
                                                  selectedImage = val;
                                                  setState(() {});
                                                },
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          ds["info_images"]
                                                              .length;
                                                      i++)
                                                    Image.network(
                                                      ds["info_images"][i],
                                                      width: fullWidth(context),
                                                      height: 220,
                                                    )
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ds["sale_type"] ==
                                                              "Sale"
                                                          ? Colors.orange
                                                          : Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 5),
                                                      child: bAppText(
                                                          ds["sale_type"]
                                                              .toString()
                                                              .toUpperCase(),
                                                          16,
                                                          white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            ds["info_images"]
                                                                .length;
                                                        i++)
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        width:
                                                            selectedImage == i
                                                                ? 8
                                                                : 6,
                                                        height:
                                                            selectedImage == i
                                                                ? 8
                                                                : 6,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          bAppText(
                                                              "Price: " +
                                                                  "Rs. " +
                                                                  ds["price"]
                                                                      .toString(),
                                                              20,
                                                              black),
                                                        ],
                                                      ),
                                                      VSpace(3),
                                                      bAppText(
                                                          "Area: " +
                                                              ds["land_area"] +
                                                              " " +
                                                              ds["land_type"]
                                                                  .toString(),
                                                          18,
                                                          black),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      goto(
                                                          context,
                                                          PlayVideoScreeen(
                                                            videoUrl: ds[
                                                                "land_video"],
                                                                ds: ds,
                                                          ));
                                                    },
                                                    child: Image.asset(
                                                      "assets/video.png",
                                                      color: grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              VSpace(15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconWithText(
                                                      "hospital",
                                                      ds["nearest_landmarks"]
                                                          ["hospital"]),
                                                  IconWithText(
                                                      "school",
                                                      ds["nearest_landmarks"]
                                                          ["hospital"]),
                                                  IconWithText(
                                                      "stop",
                                                      ds["nearest_landmarks"]
                                                          ["bus_stop"]),
                                                  IconWithText(
                                                      "shopping",
                                                      ds["nearest_landmarks"]
                                                          ["shopping_mart"]),
                                                ],
                                              ),
                                              VSpace(15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  MaterialButton(
                                                    minWidth: 150,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    height: 45,
                                                    color: btnCol,
                                                    onPressed: () {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.call,
                                                          color: white,
                                                        ),
                                                        HSpace(10),
                                                        bAppText(
                                                            "Call", 18, white)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    height: 45,
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: black),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      onPressed: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/chat.png",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          HSpace(10),
                                                          bAppText(
                                                              "Chat", 18, black)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        VSpace(10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                    : Center(
                        child: CircularProgressIndicator(
                        color: white,
                      ));
              })),
        ));
  }

  Widget IconWithText(String icon, String text) {
    return Column(
      children: [
        Image.asset("assets/$icon.png"),
        VSpace(5),
        bAppText(text, 20, black)
      ],
    );
  }
}
