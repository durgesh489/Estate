import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/main/chat_screen.dart';
import 'package:estate/screens/main/house_detail_screen.dart';
import 'package:estate/screens/main/land_screen.dart';
import 'package:estate/screens/main/land_detail_screen.dart';
import 'package:estate/screens/main/play_video_screen.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/services/helper_functions.dart';
import 'package:estate/widgets/custom_textfield.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

var lands;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  int selected = 0;
  int saleTypeIndex = -1;
  int selectedImage = 0;
  double selectedPrice = 250000;
  TabController? tabController;
  // var categories;
  bool isChatLoading = false;
  List<String> categories = ["Land", "House", "Room", "Hostel"];
  List<String> categoriesIcons = ["Field", "Apartment", "Room", "Bunk Bed"];
  TextEditingController searchController = TextEditingController();

  int selectedType = 0;
  int selectedRentalFrequency = 0;
  bool isFilterApplied = false;
  bool isPriceChanged = false;

  Future fetchCategories() async {
    lands = await DatabaseMethods().getCollection(categories[selected]);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    List navs = [Lands(), Houses(), Rooms(), Lands()];
    return Scaffold(
        backgroundColor: grey2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          // title: Padding(
          //   padding: const EdgeInsets.only(left: 8.0),
          //   child: boldText("Real Estate", 20),
          // ),
          iconTheme: IconThemeData(color: black),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.chat_bubble_outline,
          //       size: 27,
          //     ),
          //   ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.notifications_outlined,
          //       size: 27,
          //     ),
          //   ),
          //   HSpace(12),
          // ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            SizedBox(
                              height: 55,
                              width: fullWidth(context),
                              child: Card(
                                shadowColor: black,
                                color: white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            TextField(
                              onChanged: (val) async {
                                if (val == "") {
                                  fetchCategories();
                                  setState(() {});
                                } else {
                                  lands = await DatabaseMethods()
                                      .searchCategoriesByLocation(
                                          categories[selected], val);
                                  setState(() {});
                                }
                              },
                              // textAlignVertical: TextAlignVertical.center,
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(30),
                                //     borderSide: BorderSide(color: black)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 0),

                                hintText: "Search Location...",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: InkWell(
                          onTap: () {
                            show();
                          },
                          child: Card(
                            // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            shadowColor: black,
                            color: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.asset(
                                    "assets/filter.png",
                                    width: 35,
                                    height: 30,
                                  ),
                                  isFilterApplied
                                      ? CircleAvatar(
                                          backgroundColor: green,
                                          radius: 5,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace(8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < navs.length; i++)
                          NavW(categories[i], i, categoriesIcons[i])
                      ],
                    ))
              ],
            ),
          ),
        ),
        body: navs[selected]);
  }

  AnimationController? animationController;
  //
  void show() {
    showBottomSheet(
        backgroundColor: mc,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              animationController: animationController,
              enableDrag: true,
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              builder: (context) {
                return StatefulBuilder(builder: (context, state) {
                  return Container(
                    height: fullHeight(context) - 220,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              boldText("Filter", 20),
                              VSpace(10),
                              Row(
                                children: [
                                  RoundedIcon(Icons.home_outlined),
                                  HSpace(10),
                                  boldText("Property Type", 16),
                                ],
                              ),
                              VSpace(10),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: grey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            selectedType = 0;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: selectedType == 0
                                                ? Colors.green[200]
                                                : white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                              child: Text("RESIDENTIAL")),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            selectedType = 1;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: selectedType == 1
                                                ? Colors.green[200]
                                                : white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child:
                                              Center(child: Text("COMMERCIAL")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              VSpace(15),
                              Row(
                                children: [
                                  RoundedIcon(Icons.date_range),
                                  HSpace(10),
                                  boldText("Rental Frequency", 16),
                                ],
                              ),
                              VSpace(10),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: grey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            selectedRentalFrequency = 0;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: selectedRentalFrequency == 0
                                                ? Colors.green[200]
                                                : white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(child: Text("YEARLY")),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            selectedRentalFrequency = 1;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: selectedRentalFrequency == 1
                                                ? Colors.green[200]
                                                : white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(child: Text("MONTHLY")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              VSpace(15),
                              Row(
                                children: [
                                  RoundedIcon(Icons.local_offer),
                                  HSpace(10),
                                  boldText("Price Range", 16),
                                ],
                              ),
                              Slider(
                                divisions: 10,
                                activeColor: green,
                                thumbColor: green,
                                min: 160000.0,
                                max: 1000000.0,
                                value: selectedPrice,
                                onChanged: (double val) {
                                  isPriceChanged = true;
                                  selectedPrice = val;
                                  print(val);
                                  state(() {});
                                },
                              ),
                              Text(selectedPrice.toString()),
                              VSpace(10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //         child: InkWell(
                              //             onTap: () {
                              //               widget.saleTypeIndex = 0;
                              //               setState(() {});
                              //             },
                              //             child: Padding(
                              //               padding: const EdgeInsets.only(right: 10),
                              //               child: Container(
                              //                 height: 40,
                              //                 decoration: BoxDecoration(
                              //                     color: widget.saleTypeIndex == 0
                              //                         ? Colors.cyan
                              //                         : Colors.transparent,
                              //                     borderRadius: BorderRadius.circular(10),
                              //                     border: Border.all()),
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.symmetric(
                              //                     horizontal: 20,
                              //                   ),
                              //                   child: Center(
                              //                     child: Text(
                              //                       "For Sale",
                              //                       style: TextStyle(fontSize: 16),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ))),
                              //     HSpace(20),
                              //     Expanded(
                              //         child: InkWell(
                              //             onTap: () {
                              //               widget.saleTypeIndex = 1;
                              //               setState(() {});
                              //             },
                              //             child: Padding(
                              //               padding: const EdgeInsets.only(right: 10),
                              //               child: Container(
                              //                 height: 40,
                              //                 decoration: BoxDecoration(
                              //                     color: widget.saleTypeIndex == 1
                              //                         ? Colors.cyan
                              //                         : Colors.transparent,
                              //                     borderRadius: BorderRadius.circular(10),
                              //                     border: Border.all()),
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.symmetric(
                              //                     horizontal: 20,
                              //                   ),
                              //                   child: Center(
                              //                     child: Text(
                              //                       "For Rent",
                              //                       style: TextStyle(fontSize: 16),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ))),
                              //   ],
                              // ),
                            ],
                          ),
                          PrimaryMaterialButton(context, () async {
                            isFilterApplied = true;
                            print(selectedPrice);
                            print(selectedType);

                            lands = await FirebaseFirestore.instance
                                .collection("Land")
                                .where("price",
                                    isLessThan: selectedPrice.toInt())
                                .where("details.property_type",
                                    isEqualTo: selectedType == 0
                                        ? "Residential"
                                        : "Commercial")
                                .snapshots();

                            goBack(context);

                            setState(() {});
                          }, "Apply"),
                          VSpace(5),
                          TextButton(
                              onPressed: () {
                                isFilterApplied = false;
                                fetchCategories();
                                goBack(context);
                              },
                              child: nAppText("Reset", 18, Colors.blue))
                        ],
                      ),
                    ),
                  );
                });
              });
        });
  }

  Widget NavW(String title, int index, String icon) {
    return InkWell(
        onTap: () {
          setState(() {
            selected = index;
            fetchCategories();
          });
        },
        child: Container(
          height: 58,
          child: Column(
            children: [
              Image.asset(
                "assets/$icon.png",
                width: 25,
                height: 25,
                color: selected == index ? green : Colors.black54,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: selected == index ? green : black,
                ),
              ),
              selected == index
                  ? SizedBox(
                      width: 50,
                      child: Divider(
                        color: selected == index ? green : black,
                        thickness: 2,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ));
  }

  Widget IconWithText(String icon, String title, Color? color) {
    return Column(
      children: [
        Card(
          elevation: 2,
          color: white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/$icon.png",
              width: 25,
              height: 25,
              color: color,
            ),
          ),
        ),
        VSpace(4),
        boldText(title, 15)
      ],
    );
  }

  // Widget SaleType(String title, int index) {
  //   return ;
  // }

  Widget Item(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.cyan[800]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            normalText(title, 17),
            normalText(subtitle, 17),
          ],
        ),
      ),
    );
  }

  Widget Lands() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: StreamBuilder(
          stream: lands,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: normalText("Not Found", 16))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Images(ds, ds["sale_type"]),
                                      VSpace(10),
                                      LocationAndVideo(ds, ds["land_video"]),
                                      VSpace(10),
                                      PriceAndArea(
                                          ds["price"],
                                          ds["land_area"].toString(),
                                          ds["land_type"].toString(),
                                          ds["land_video"]),
                                      VSpace(12),
                                      NearestLandmarks(ds),
                                      VSpace(12)
                                    ],
                                  ),
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
          })),
    );
  }

  Widget Houses() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: StreamBuilder(
          stream: lands,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: normalText("Not Found", 16))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                goto(context, HouseDetailScreen(ds: ds));
                              },
                              child: Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(color: Colors.black12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Images(ds, ds["sale_type"]),
                                      VSpace(10),
                                      LocationAndVideo(ds, ds["house_video"]),
                                      VSpace(12),
                                      PriceAndArea(
                                          int.parse(ds["price"].toString()),
                                          ds["land_area"].toString(),
                                          ds["land_type"].toString(),
                                          ds["house_video"]),
                                      VSpace(12),
                                      NearestLandmarks(ds),
                                      VSpace(10),
                                    ],
                                  ),
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
    );
  }

  Widget Rooms() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder(
          stream: lands,
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(child: normalText("Not Found", 16))
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
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(color: Colors.black12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Images(ds, ds["room_type"]),
                                      VSpace(10),
                                      PriceAndArea(1000000, ds["room_type"],
                                          ds["room_type"], ds["room_video"]),
                                      VSpace(12),
                                      LocationAndVideo(ds, ds["room_video"]),
                                      VSpace(12),
                                      NearestLandmarks(ds),
                                      VSpace(10),
                                    ],
                                  ),
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
    );
  }

  //

  Widget VideoButton(String videoUrl, DocumentSnapshot ds) {
    return InkWell(
        onTap: () {
          goto(
              context,
              PlayVideoScreeen(
                videoUrl: videoUrl,
                ds: ds,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                nAppText("Video Tour", 14, black),
                HSpace(5),
                Icon(
                  Icons.play_circle,
                  color: grey,
                ),
              ],
            ),
          ),
        ));
  }

  Widget LocationAndVideo(DocumentSnapshot ds, String videoUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 25,
              color: green,
            ),
            HSpace(5),
            nAppText(ds["location"]["city"], 17, black),
          ],
        ),
        VideoButton(videoUrl, ds)
      ],
    );
  }

  Widget NearestLandmarks(DocumentSnapshot ds) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWithText(
            "hospital", ds["nearest_landmarks"]["hospital"], Colors.grey[700]),
        IconWithText(
            "school", ds["nearest_landmarks"]["hospital"], Colors.grey[700]),
        IconWithText(
            "stop", ds["nearest_landmarks"]["bus_stop"], Colors.grey[700]),
        IconWithText("shopping", ds["nearest_landmarks"]["shopping_mart"],
            Colors.grey[700]),
      ],
    );
  }

  Widget PriceAndArea(int price, String area, String type, String videoUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                bAppText(" ₹ ", 20, black),
                bAppText(
                    price.toString() + " / " + area + " " + type, 18, black),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget Images(DocumentSnapshot ds, String type) {
    List<String> l = prefs!.getStringList("favorites") ?? [];
    return Container(
      decoration: BoxDecoration(
        color: grey2,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 220,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (val) {
              selectedImage = val;
              setState(() {});
            },
            children: [
              for (int i = 0; i < ds["info_images"].length; i++)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    ds["info_images"][i],
                    width: fullWidth(context),
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      bool checkLogin = prefs!.getBool("islogin") ?? false;
                      if (checkLogin) {
                        Map<String, dynamic> data =
                            ds.data() as Map<String, dynamic>;

                        if (l.contains(ds.id)) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(prefs!.getString("id"))
                              .collection(categories[selected])
                              .doc(ds.id)
                              .delete();
                          l.remove(ds.id);
                          showSnackbar(
                              context, "Removed From Favourites Successfully");
                        } else {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(prefs!.getString("id"))
                              .collection(categories[selected])
                              .doc(ds.id)
                              .set(data);
                          l.add(ds.id);
                          showSnackbar(
                              context, "Added In Favourites Successfully");
                        }

                        prefs!.setStringList("favorites", l);

                        setState(() {});
                      } else {
                        showSnackbar(context,
                            "${categories[selected]} cannot be added Please Login First ");
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          l.contains(ds.id)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 25,
                          color: green,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HelperFunction().makeCall();
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.call,
                          size: 25,
                          color: green,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // setState(() {
                      //   isChatLoading = true;
                      // });

                      String chatRoomId = HelperFunction()
                          .getChatRoomIdByPhoneNumbers(
                              prefs!.getString("id") ?? "",
                              "AKLFWVc4IdcIotxet6QQKukRdQY2");
                      print(chatRoomId);
                      Map<String, dynamic> chatRoomInfoMap = {
                        "usersIds": [
                          prefs!.getString("id") ?? "",
                          "AKLFWVc4IdcIotxet6QQKukRdQY2"
                        ],
                        "ts": DateTime.now()
                      };
                      DatabaseMethods()
                          .createChatRoom(chatRoomId, chatRoomInfoMap)
                          .then((value) {
                        setState(() {
                          isChatLoading = false;
                        });
                        goto(
                            context,
                            ChatScreen(prefs!.getString("id") ?? "",
                                "AKLFWVc4IdcIotxet6QQKukRdQY2", chatRoomId));
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          "assets/chat.png",
                          width: 25,
                          height: 25,
                          color: green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.orange,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          //         child: bAppText(type.toUpperCase(), 16, white),
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < ds["info_images"].length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedImage == i ? grey : Colors.white,
                          shape: BoxShape.circle),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget IconWithText(String icon, String text) {
//     return Column(
//       children: [
//         Image.asset(
//           "assets/$icon.png",
//           color: Colors.black54,
//           width: 25,
//           height: 25,
//         ),
//         VSpace(5),
//         bAppText(text, 16, black)
//       ],
//     );
//   }
}

// class BS extends StatefulWidget {
//   double selectedPrice;
//   int saleTypeIndex;

//   BS({
//     Key? key,
//     required this.selectedPrice,
//     required this.saleTypeIndex,
//   }) : super(key: key);

//   @override
//   State<BS> createState() => _BSState();
// }

// class _BSState extends State<BS> {
//   int selectedType = 0;
//   int selectedRentalFrequency = 0;
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }

Widget RoundedIcon(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: grey2,
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Icon(
        icon,
        size: 25,
        color: green,
      ),
    ),
  );
}
