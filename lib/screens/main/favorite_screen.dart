import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/screens/main/chat_screen.dart';
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

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<FavoriteScreen> {
  int selected = 0;
  int saleTypeIndex = -1;
  int selectedImage = 0;
  double selectedPrice = 250000;
  // var categories;

  List<String> categories = ["Land", "House", "Room", "Hostel"];
  List<String> categoriesIcons = ["Field", "Apartment", "Room", "Bunk Bed"];
  TextEditingController searchController = TextEditingController();

  Future fetchCategories() async {
    lands = await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("id"))
        .collection(categories[selected])
        .snapshots();

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
      backgroundColor: grey2,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: grey2,
        title: boldText("Favourites", 20),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < navs.length; i++)
                    NavW(categories[i], i, categoriesIcons[i])
                ],
              )),
        ),
      ),
      body: navs[selected],
    );
  }

  //

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
                    ? Center(
                        child: bAppText(
                            "No ${categories[selected]} in Favorites!",
                            16,
                            black))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          List<String> l =
                              prefs!.getStringList("favorites") ?? [];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(color: Colors.black12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ImageW(ds),
                                      HSpace(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 20,
                                              ),
                                              HSpace(5),
                                              nAppText(ds["location"]["city"],
                                                  17, black),
                                            ],
                                          ),
                                          VSpace(10),
                                          Row(
                                            children: [
                                              bAppText(" ₹ ", 20, black),
                                              bAppText(
                                                  ds["price"].toString() +
                                                      " / " +
                                                      ds["land_area"] +
                                                      " " +
                                                      ds["land_type"],
                                                  18,
                                                  black),
                                            ],
                                          ),
                                          VSpace(5),
                                          CallAndChatButton()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                : Center(child: CircularProgressIndicator());
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
                    ? Center(
                        child: bAppText(
                            "No ${categories[selected]} in Favorites!",
                            16,
                            black))
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ImageW(ds),
                                      HSpace(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 20,
                                              ),
                                              HSpace(5),
                                              nAppText(ds["location"]["city"],
                                                  17, black),
                                            ],
                                          ),
                                          VSpace(10),
                                          Row(
                                            children: [
                                              bAppText(" ₹ ", 20, black),
                                              bAppText(
                                                  ds["price"].toString() +
                                                      " / " +
                                                      ds["land_area"] +
                                                      " " +
                                                      ds["land_type"],
                                                  18,
                                                  black),
                                            ],
                                          ),
                                          VSpace(5),
                                          CallAndChatButton()
                                        ],
                                      ),
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
                    ? Center(
                        child: bAppText(
                            "No ${categories[selected]} in Favorites!",
                            16,
                            black))
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ImageW(ds),
                                      HSpace(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 20,
                                              ),
                                              HSpace(5),
                                              nAppText(ds["location"]["city"],
                                                  17, black),
                                            ],
                                          ),
                                          VSpace(10),
                                          Row(
                                            children: [
                                              bAppText(" ₹ ", 20, black),
                                              bAppText(
                                                  10000000.toString() + " / "
                                                  // +
                                                  // ds["room_area"]
                                                  //  +
                                                  // " " +
                                                  // ds["room_type"]
                                                  ,
                                                  18,
                                                  black),
                                            ],
                                          ),
                                          VSpace(5),
                                          CallAndChatButton()
                                        ],
                                      ),
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

  Widget ImageW(DocumentSnapshot ds) {
    List<String> l = prefs!.getStringList("favorites") ?? [];
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            ds["info_images"][0],
            width: 120,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
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
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget CallAndChatButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          minWidth: 90,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          height: 35,
          color: green,
          onPressed: () {
            HelperFunction().makeCall();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call,
                color: white,
                size: 15,
              ),
              HSpace(5),
              bAppText("Call", 14, white)
            ],
          ),
        ),
        HSpace(5),
        SizedBox(
          width: 90,
          height: 35,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              String chatRoomId = HelperFunction().getChatRoomIdByPhoneNumbers(
                  prefs!.getString("id") ?? "", "AKLFWVc4IdcIotxet6QQKukRdQY2");
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
                setState(() {});
                goto(
                    context,
                    ChatScreen(prefs!.getString("id") ?? "",
                        "AKLFWVc4IdcIotxet6QQKukRdQY2", chatRoomId));
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/chat.png",
                  width: 20,
                  height: 20,
                ),
                HSpace(5),
                bAppText("Chat", 14, black)
              ],
            ),
          ),
        )
      ],
    );
  }
}
