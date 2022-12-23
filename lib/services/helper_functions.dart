import 'package:url_launcher/url_launcher.dart';

class HelperFunction {
  makeCall() async {
    await launch("tel:9841665340");
  }
  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
