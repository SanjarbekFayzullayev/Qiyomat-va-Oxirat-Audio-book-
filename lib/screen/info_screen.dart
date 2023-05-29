import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/widgets/menu_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late bool _isDark = true;

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
      backgroundColor: _isDark?Colors.white:Constants().darkLight,
        body: SafeArea(
      child: Column(
        children: [
          Text(
            "head".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: BookModel.bookModel.length,
              itemBuilder: (context, index) {
                return MenuItem(BookModel.bookModel[index], index);
              },
            ),
          )
        ],
      ),
    ));
  }
}
