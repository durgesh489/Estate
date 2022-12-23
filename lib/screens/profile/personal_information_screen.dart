import 'dart:io';

import 'package:estate/constants/colors.dart';
import 'package:estate/main.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      backgroundColor: grey2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButtonW(context, Icons.arrow_back_ios),
        title: Text(
          "Personal Information",
          style: TextStyle(color: black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                VSpace(20),
                Stack(
                  // alignment: Alignment.bottomRight,
                  children: [
                    prefs!.getString("profile") != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(130),
                            child: Image.file(
                              File(prefs!.getString("profile")!),
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 60,
                            ),
                          ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: InkWell(
                        onTap: () {
                          takeImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: green,
                          radius: 20,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VSpace(40),
                Item("Name", prefs!.getString("name") ?? "Unknown", true,
                    "name"),
                Item("Email", prefs!.getString("email") ?? "unknown@gmail.com",
                    false, "email"),
                Item(
                    "Phone Number",
                    prefs!.getString("phone") ?? "No Phone Number",
                    true,
                    "phone"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController controller = TextEditingController();
  Widget Item(String title, String value, bool isEdited, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(title, 16),
        VSpace(10),
        Container(
          width: fullWidth(context),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nAppText(value, 17, black),
                isEdited
                    ? InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Enter"),
                                  content: TextField(
                                    controller: controller,
                                    decoration:
                                        InputDecoration(hintText: title),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          goBack(context);
                                        },
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          prefs!.setString(
                                              field, controller.text);
                                          setState(() {});
                                          goBack(context);
                                          controller.text = "";
                                        },
                                        child: Text("Ok")),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.edit,
                          size: 22,
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
        VSpace(20)
      ],
    );
  }

  String? image;
  bool isImageSelected = false;
  final ImagePicker picker = new ImagePicker();
  var imageUrl;

  Future getImageFromGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile.path;
        prefs!.setString("profile", image!);

        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  Future captureImageFromCamera() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile.path;
        prefs!.setString("profile", image!);
        isImageSelected = true;
      } else {
        print("no image selected");
      }
    });
  }

  Future imageUpload() async {}

  takeImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Select any option",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  getImageFromGallery();
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture Image from Camera",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  captureImageFromCamera();
                }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
