import 'package:estate/constants/colors.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mc,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButtonW(context, Icons.arrow_back_ios),
        title: Text("Personal Information"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                VSpace(20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: btnCol,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          "assets/person.png",
                          color: white,
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: green,
                      onPressed: () {},
                      child: Icon(Icons.camera_alt_outlined),
                    )
                  ],
                ),
                VSpace(40),
                Item("Name", "User"),
                Item("Email", "user@gmail.com"),
                Item("Phone Number", "9876543210"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Item(String field, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(field, 16),
        VSpace(10),
        Container(
          width: fullWidth(context),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nAppText(value, 17, black),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                    ))
              ],
            ),
          ),
        ),
        VSpace(35)
      ],
    );
  }
}
