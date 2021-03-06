import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/pages/cart_page.dart';
import 'package:toko_app/pages/history_page.dart';
import 'package:toko_app/pages/home_page.dart';
import 'package:toko_app/pages/profile_page.dart';
import 'package:toko_app/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            controller: _pageController,
            children: [
              HomePage(),
              HistoryPage(),
              CartPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          iconSize: 24,
          showElevation: false,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          containerHeight: 70,
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Image.asset('assets/home.png', width: 24),
              title: const Text('Home'),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/document.png', width: 24),
              title: const Text('History'),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/buy.png', width: 24),
              title: const Text('Cart'),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset('assets/profile.png', width: 24),
              title: const Text('Profile'),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Apakah anda ingin keluar dari Aplikasi?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                //return false when click on "NO"
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  primary: redColor,
                ),
                //return true when click on "Yes"
                child: Text('Keluar'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
