import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/screen/desalis_screen.dart';
import 'package:qiyomat_va_oxirat/util/navigator_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItem extends StatefulWidget {
  BookModel bookModel;
  var index;

  MenuItem(this.bookModel, this.index, {Key? key}) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          NewNavigator.RightToLeft(context, DetalsPage(widget.bookModel));
        },
        child: SizedBox(
          height: 50,
          child: Card(
            color: _isDark ? Constants().mainColor : Constants().darkDark,
            elevation: 12,
            shadowColor: _isDark ? Constants().mainColor : Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                      context.locale.toString().toString() == "uz_UZ"
                          ? "${widget.index + 1}. 🎧 📜 ${widget.bookModel.nameUZ!}"
                          :  "${widget.index + 1}. 🎧 📜 ${widget.bookModel.nameKR!}",
                      style: TextStyle(
                          color: _isDark ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
