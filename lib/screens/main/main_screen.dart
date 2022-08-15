import 'package:estate/constants/colors.dart';
import 'package:estate/screens/main/land_screen.dart';
import 'package:estate/screens/main/categories_screen.dart';
import 'package:estate/screens/main/chat_screen.dart';
import 'package:estate/screens/main/favorite_screen.dart';
import 'package:estate/screens/main/home_screen.dart';
import 'package:estate/screens/main/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<MainScreen> {
  List screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mc,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: mc,
          selectedLabelStyle: TextStyle(color: Colors.orange),
          unselectedLabelStyle: TextStyle(color: white),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          iconSize: 32,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list,size: 35,),
              label: "Categories",
              activeIcon: Icon(Icons.list,size: 35),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favourites",
              activeIcon: Icon(
                Icons.favorite,
              ),
            ),
             BottomNavigationBarItem(
              icon: Image.asset("assets/chat.png",color: white,width: 32,height: 32,),
              label: "Chat",
              activeIcon:  Image.asset("assets/chat.png",color: Colors.orange,width: 32,height: 32,),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
              activeIcon: Icon(Icons.person),
            ),
           
          ],
        ),
        body: screens[currentIndex]);
  }
}
