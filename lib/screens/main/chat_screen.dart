import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/constants/colors.dart';
import 'package:estate/services/database_methods.dart';
import 'package:estate/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final String myId,userId,chatRoomId;
  const ChatScreen(this.myId,this.userId,this.chatRoomId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // String myId = "";
  String messageId = "";

  var messageStream;
  String userTokenId = "";
  bool isUserExist = false;

  TextEditingController messageController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  getAndSetMessages() async {
    print(widget.chatRoomId);
    messageStream = await DatabaseMethods().getMessages(widget.chatRoomId);
  }

  // getUserTokenId() async {
  //   QuerySnapshot tokenIdQS =
  //       await DatabaseMethods().getUserInfo(widget.userPhoneNumber);
  //   if (tokenIdQS.docs.length == 1) {
  //     isUserExist = true;
  //     userTokenId = tokenIdQS.docs[0]["tokenId"];
  //     print(userTokenId);
  //   }
  // }

  doThisOnLaunch() async {
    await getAndSetMessages();
    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  onSendClick(bool send) {
    if (messageController.text != "") {
     
      Map<String, dynamic> messageInfoMap = {
        "message": messageController.text,
        "sendBy": widget.myId,
       
        "ts": DateTime.now(),
      };
      if (messageId == "") {
        messageId = getRandomString(12);
      }
     

      DatabaseMethods()
          .addMessage(widget.chatRoomId, messageId, messageInfoMap)
          .then((value) {});
      if (send) {
       
        messageController.text = "";
        messageId = "";
        setState(() {});
      }
    }
  }

  Widget ChatListTile(ds) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: ds["sendBy"] == widget.myId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: ds["sendBy"] == widget.myId
            ? const EdgeInsets.only(top: 3, bottom: 3, left: 50, right: 8)
            : const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 50),
        decoration: BoxDecoration(
          color: ds["sendBy"] == widget.myId
              ? Colors.grey[200]
              : Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 65.0, bottom: 10, left: 12, top: 10),
              child: Text(
                ds["message"],
                style: TextStyle(
                  fontSize: 16,
                  color: ds["sendBy"] == widget.myId
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: 10,
              child: Text(
                DateFormat("hh:mm:aa").format(ds["ts"].toDate()),
                style: TextStyle(
                  fontSize: 10,
                  color: ds["sendBy"] == widget.myId
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AllChats() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? snapshot.data!.docs.length == 0
                ? Center(child: bAppText("No Chats to show", 15, Colors.grey))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 65),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return ChatListTile(ds);
                    },
                  )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 3,
          backgroundColor: Colors.white,
          // leading: IconButton(onPressed: (){}, icon: Icon(Icons.clear_outlined)),
          leadingWidth: 30,
          title: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: green,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 25,
                ),
              ),
                
              HSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  // Text(
                  //   widget.userPhoneNumber,
                  //   style: TextStyle(color: Colors.black, fontSize: 13),
                  // ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // UrlLauncher.launch("tel:${widget.userPhoneNumber}");
              },
              icon: Icon(
                Icons.call,
              ),
            ),
            // IconButton(
            //   onPressed: () async {
            //     // DocumentSnapshot ds = await DatabaseMethods()
            //     //     .getChatroomAmount(chatRoomId.toString());
            //     // int myAmount = ds[myId];
            //     // int userAmount = ds[widget.userPhoneNumber];
            //     // sendSMS(
            //     //     message: myAmount > 0
            //     //         ? "Dear Sir/Madam, Your payment of $myAmount ₹ is pending at $myId Please Pay  "
            //     //         : "You have gven ${-myAmount} ₹ to $myId Please take",
            //     //     recipients: [widget.userPhoneNumber]);
            //   },
            //   icon: Icon(
            //     Icons.chat,
            //   ),
            // ),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Settings"),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              AllChats(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       chatBool = false;
                      //     });
                      //   },
                      //   icon: Icon(
                      //     Icons.cancel,
                      //     size: 28,
                      //   ),
                      // ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              onChanged: (value) {},
                              minLines: 1,
                              maxLines: 3,
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Message",
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            onSendClick(true);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
