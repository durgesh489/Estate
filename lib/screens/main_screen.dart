import 'package:estate/constants/colors.dart';
import 'package:estate/screens/cart_screen.dart';
import 'package:estate/screens/favorite_screen.dart';
import 'package:estate/screens/home_screen.dart';
import 'package:estate/screens/profile_screen.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<MainScreen> {
  List screens = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
   
    ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: Colors.orange),
          unselectedLabelStyle: TextStyle(color: black),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
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
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Cart",
              activeIcon: Icon(Icons.shopping_cart),
            ),
          
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favourites",
              activeIcon: Icon(
                Icons.favorite,
               
              ),
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
