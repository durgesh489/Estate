import 'package:estate/constants/colors.dart';
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
      backgroundColor: mc,
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: AppName(25, true),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(controller: searchController, validators: [],hintText: "Search Home",)

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
