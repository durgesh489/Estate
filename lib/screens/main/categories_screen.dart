import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/main/land_screen.dart';
import 'package:estate/screens/main/detail_screen.dart';
import 'package:estate/screens/main/play_video_screen.dart';
import 'package:estate/services/database_methods.dart';
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

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selected = 0;
  int saleTypeIndex = -1;
  int selectedImage = 0;
  double selectedPrice = 250000;
  // var categories;

  List<String> categories = ["Land", "House", "Room", "Hostel"];
  TextEditingController searchController = TextEditingController();

  Future fetchCategories() async {
    lands = await DatabaseMethods().getCollection(categories[selected]);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    List navs = [Lands(), Houses(), Rooms(), Lands()];
    return Scaffold(
      backgroundColor: mc,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: mc,
        title: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: white)),
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
                    textAlignVertical: TextAlignVertical.center,
                    controller: searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        hintText: "Location",
                        suffixIcon: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            HSpace(10),
            InkWell(
              onTap: () {
                show();
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/filter.png",
                  color: white,
                ),
              ),
            )
          ],
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return NavW(categories[index], index);
                },
              ),
            )),
      ),
      body: navs[selected],
    );
  }

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
              backgroundColor: mc,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              onClosing: () {
                setState(() {});
              },
              builder: (context) {
                return BS(
                  selectedPrice: selectedPrice,
                  saleTypeIndex: saleTypeIndex,
                );
              });
        });
  }

  Widget NavW(String title, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            selected = index;
            fetchCategories();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
                color: selected == index ? btnCol : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: white)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: white, fontSize: 16),
                ),
              ),
            ),
          ),
        ));
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
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LocationAndFavorite(
                                        ds, ds["location"]["city"]),
                                    Images(ds, ds["sale_type"]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PriceAndArea(
                                              ds["price"],
                                              ds["land_area"].toString(),
                                              ds["land_type"].toString(),
                                              ds["land_video"]),
                                          VSpace(15),
                                          NearestLandmarks(ds),
                                          VSpace(15),
                                          CallAndChatButton()
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
    );
  }

  Widget Houses() {
    return Padding(
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
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LocationAndFavorite(
                                        ds, ds["location"]["city"]),
                                    Images(ds, ds["sale_type"]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PriceAndArea(
                                              int.parse(ds["price"].toString()),
                                              ds["land_area"].toString(),
                                              ds["land_type"].toString(),
                                              ds["house_video"]),
                                          VSpace(15),
                                          NearestLandmarks(ds),
                                          VSpace(15),
                                          CallAndChatButton()
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
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LocationAndFavorite(
                                        ds, ds["location"]["city"]),
                                    Images(ds, ds["room_type"]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // PriceAndArea(
                                          //     ds["price"],
                                          //     ds["land_area"].toString(),
                                          //     ds["land_type"].toString(),
                                          //     ds["house_video"]),
                                          VSpace(15),
                                          NearestLandmarks(ds),
                                          VSpace(15),
                                          CallAndChatButton()
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
    );
  }

  Widget CallAndChatButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          minWidth: 150,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          height: 45,
          color: btnCol,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call,
                color: white,
              ),
              HSpace(10),
              bAppText("Call", 18, white)
            ],
          ),
        ),
        SizedBox(
          width: 150,
          height: 45,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
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
                HSpace(10),
                bAppText("Chat", 18, black)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget VideoButton(String videoUrl) {
    return InkWell(
      onTap: () {
        goto(
            context,
            PlayVideoScreeen(
              videoUrl: videoUrl,
            ));
      },
      child: Image.asset(
        "assets/video.png",
        color: grey,
      ),
    );
  }

  Widget LocationAndFavorite(DocumentSnapshot ds, String city) {
    List<String> l = prefs!.getStringList("favorites") ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 30,
              ),
              HSpace(5),
              nAppText(city, 20, black),
            ],
          ),
          InkWell(
            onTap: () async {
              bool checkLogin = prefs!.getBool("islogin") ?? false;
              if (checkLogin) {
                Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

                if (l.contains(ds.id)) {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(prefs!.getString("id"))
                      .collection(categories[selected])
                      .doc(ds.id)
                      .delete();
                  l.remove(ds.id);
                  showSnackbar(context, "Removed From Favourites Successfully");
                } else {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(prefs!.getString("id"))
                      .collection(categories[selected])
                      .doc(ds.id)
                      .set(data);
                  l.add(ds.id);
                  showSnackbar(context, "Added In Favourites Successfully");
                }

                prefs!.setStringList("favorites", l);

                setState(() {});
              } else {
                showSnackbar(context,
                    "${categories[selected]} cannot be added Please Login First ");
              }
            },
            child: Icon(
              l.contains(ds.id) ? Icons.favorite : Icons.favorite_outline,
              size: 30,
              color: red,
            ),
          )
        ],
      ),
    );
  }

  Widget NearestLandmarks(DocumentSnapshot ds) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconWithText("hospital", ds["nearest_landmarks"]["hospital"]),
        IconWithText("school", ds["nearest_landmarks"]["hospital"]),
        IconWithText("stop", ds["nearest_landmarks"]["bus_stop"]),
        IconWithText("shopping", ds["nearest_landmarks"]["shopping_mart"]),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bAppText("Price: " + "Rs. " + price.toString(), 20, black),
              ],
            ),
            VSpace(3),
            bAppText("Area: " + area + " " + type, 18, black),
          ],
        ),
        VideoButton(videoUrl)
      ],
    );
  }

  Widget Images(DocumentSnapshot ds, String type) {
    return Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: bAppText(type.toUpperCase(), 16, white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < ds["info_images"].length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: selectedImage == i ? 8 : 6,
                    height: selectedImage == i ? 8 : 6,
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget IconWithText(String icon, String text) {
    return Column(
      children: [
        Image.asset("assets/$icon.png"),
        VSpace(5),
        bAppText(text, 18, black)
      ],
    );
  }
}

class BS extends StatefulWidget {
  double selectedPrice;
  int saleTypeIndex;

  BS({
    Key? key,
    required this.selectedPrice,
    required this.saleTypeIndex,
  }) : super(key: key);

  @override
  State<BS> createState() => _BSState();
}

class _BSState extends State<BS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                boldText("Price: " + widget.selectedPrice.toString(), 20),
                VSpace(5),
                Slider(
                  divisions: 10,
                  activeColor: white,
                  thumbColor: btnCol,
                  min: 160000.0,
                  max: 1000000.0,
                  value: widget.selectedPrice,
                  onChanged: (double val) {
                    widget.selectedPrice = val;
                    print(val);
                    setState(() {});
                  },
                ),
                VSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              widget.saleTypeIndex = 0;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: widget.saleTypeIndex == 0
                                        ? btnCol
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: white)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "For Sale",
                                      style:
                                          TextStyle(color: white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                    HSpace(20),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              widget.saleTypeIndex = 1;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: widget.saleTypeIndex == 1
                                        ? btnCol
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: white)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "For Rent",
                                      style:
                                          TextStyle(color: white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                  ],
                ),
              ],
            ),
            PrimaryMaterialButton(context, () async {
              lands = await DatabaseMethods()
                  .searchCategoriesByPrice("Land", widget.selectedPrice.toInt())
                  .then((value) {
                goBack(context);
              });
            }, "Apply")
          ],
        ),
      ),
    );
  }
}
