import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/screen/about_user_screen.dart';
import 'package:qiyomat_va_oxirat/screen/info_screen.dart';
import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:qiyomat_va_oxirat/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> pages = [
     InfoScreen(),
    const HomePage(),
    const AboutUserScreen(),
  ];
  int _index = 1;
  late bool _isDark=true;

  @override
  void initState() {
    getData();
    super.initState();
  }
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('darkMode') ?? true;
    setState(() {
      _isDark = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      extendBody: false,
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          selectedItemBackgroundColor: _isDark?Constants().mainColor:Constants().darkDark,
          selectedItemBorderColor: _isDark?Colors.white:Constants().darkLight,
barBackgroundColor: _isDark?Colors.white:Constants().darkDark,
            // selectedItemBackgroundColor: Colors.white,
            // selectedItemIconColor: Colors.blue,
            barHeight: 40),
        selectedIndex: _index,
        onSelectTab: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          FFNavigationBarItem(iconData: Icons.list_alt_outlined,),
          FFNavigationBarItem(iconData: Icons.home),
          FFNavigationBarItem(iconData: Icons.account_circle_rounded),
        ],
      ),
    );
  }
}
