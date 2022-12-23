import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/screens/main/land_detail_screen.dart';
import 'package:estate/screens/others/welcome_screen.dart';
import 'package:estate/services/auth_methods.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: boldText("Real Estate", 20),
        iconTheme: IconThemeData(color: black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 27,
            ),
          ),
          HSpace(12),
        ],
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(50),
        //   child: Column(
        //     children: [
        //       Stack(
        //         alignment: Alignment.centerLeft,
        //         children: [
        //           SizedBox(
        //             height: 55,
        //             width: fullWidth(context),
        //             child: Card(
        //               margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //               shadowColor: black,
        //               color: white,
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(30)),
        //             ),
        //           ),
        //           TextField(
        //             textAlignVertical: TextAlignVertical.center,
        //             controller: searchController,
        //             decoration: InputDecoration(
        //               border: InputBorder.none,
        //               // border: OutlineInputBorder(
        //               //     borderRadius: BorderRadius.circular(30),
        //               //     borderSide: BorderSide(color: black)),
        //               contentPadding:
        //                   EdgeInsets.symmetric(horizontal: 35, vertical: 0),

        //               hintText: "Search Location...",
        //               suffixIcon: InkWell(
        //                 onTap: () {},
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(right: 25),
        //                   child: Image.asset(
        //                     "assets/filter.png",
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  autoPlay: true,
                ),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/banner$i.jpg",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              VSpace(20),
              boldText("Recommended", 20),
              VSpace(10),
              Recommended(),
              VSpace(20),
              boldText("Best Categories", 20),
              VSpace(10),
              BestCategories()
              // VSpace(20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     boldText("Products- List", 17),
              //     InkWell(
              //       onTap: () {},
              //       child: nAppText("View More", 14, grey),
              //     ),
              //   ],
              // ),
              // VSpace(35),
              // Item(),
              // VSpace(20),
              // Item(),
              // VSpace(20),
              // Item(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Item() {
  //   return InkWell(
  //     onTap: () {
  //       goto(context, ProductDetailScreen());
  //     },
  //     child: Container(
  //       height: 110,
  //       child: Row(
  //         children: [
  //           DefaultImage(100, 100),
  //           HSpace(8),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               boldText("Brown Chair", 20),
  //               VSpace(10),
  //               Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(15),
  //                   color: black,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
  //                   child: nAppText("12.00", 16, white),
  //                 ),
  //               ),
  //               Row(
  //                 children: [
  //                   MaterialButton(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30)),
  //                     minWidth: 110,
  //                     height: 25,
  //                     onPressed: () {},
  //                     color: green,
  //                     child: nAppText("Buy Now", 15, white),
  //                   ),
  //                   HSpace(5),
  //                   Icon(Icons.shopping_cart_outlined)
  //                 ],
  //               )
  //             ],
  //           ),
  //           Spacer(),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: lightGrey,
  //                     shape: BoxShape.circle,
  //                     border: Border.all(color: Colors.green, width: 3)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text("80%"),
  //                 ),
  //               ),
  //               IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.favorite,
  //                     size: 30,
  //                     color: red,
  //                   ))
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget Recommended() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Land").snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? snapshot.data!.docs.length == 0
                  ? Center(child: normalText("Not Found", 16))
                  : SizedBox(
                      height: 225,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                goto(
                                    context,
                                    LandDetailScreen(
                                      ds: ds,
                                    ));
                              },
                              child: SizedBox(
                                width: fullWidth(context) - 100,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: Colors.black12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          child: Image.network(
                                            ds["info_images"][index],
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        VSpace(10),
                                        // LocationAndVideo(ds, ds["land_video"]),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 18,
                                                      color: black,
                                                    ),
                                                    HSpace(2),
                                                    boldText(
                                                      ds["location"]["city"],
                                                      16,
                                                    ),
                                                  ],
                                                ),
                                                bAppText(
                                                    "₹" +
                                                        ds["price"].toString(),
                                                    16,
                                                    black),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // VSpace(5),
                                        // Row(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.location_on_outlined,
                                        //       size: 20,
                                        //       color: green,
                                        //     ),
                                        //     HSpace(5),
                                        //   ],
                                        // ),
                                        // VSpace(12),
                                        // NearestLandmarks(ds),
                                        // VSpace(12)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator(
                  color: green,
                ));
        }));
  }

  Widget BestCategories() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("House").snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? snapshot.data!.docs.length == 0
                  ? Center(child: normalText("Not Found", 16))
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 5),
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            goto(
                                context,
                                LandDetailScreen(
                                  ds: ds,
                                ));
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.black12)),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      ds["info_images"][index],
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  VSpace(10),
                                  // LocationAndVideo(ds, ds["land_video"]),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          boldText(
                                            ds["location"]["city"],
                                            16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: nAppText(
                                        "₹" + ds["price"].toString(),
                                        16,
                                        black),
                                  ),
                                  // VSpace(5),
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.location_on_outlined,
                                  //       size: 20,
                                  //       color: green,
                                  //     ),
                                  //     HSpace(5),
                                  //   ],
                                  // ),
                                  // VSpace(12),
                                  // NearestLandmarks(ds),
                                  // VSpace(12)
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )
              : Center(
                  child: CircularProgressIndicator(
                  color: green,
                ));
        }));
  }
}
