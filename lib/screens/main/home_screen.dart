import 'package:estate/constants/colors.dart';
import 'package:estate/screens/authentication/signup_screen.dart';
import 'package:estate/screens/others/welcome_screen.dart';
import 'package:estate/services/auth_methods.dart';
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
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: boldText("Real Estate", 20),
          ),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SizedBox(
                      height: 55,
                      width: fullWidth(context),
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        shadowColor: black,
                        color: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    TextField(
                    
                      textAlignVertical: TextAlignVertical.center,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(30),
                        //     borderSide: BorderSide(color: black)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 0),

                        hintText: "Search Location...",
                        suffixIcon: InkWell(
                          onTap: () {
                           
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Image.asset(
                              "assets/filter.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
            

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
}
