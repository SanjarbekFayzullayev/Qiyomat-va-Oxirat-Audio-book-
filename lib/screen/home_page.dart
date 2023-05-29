import 'dart:io';
import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/provider/provider_favorute.dart';
import 'package:qiyomat_va_oxirat/screen/bottom_nav_bar_screen.dart';
import 'package:qiyomat_va_oxirat/screen/auth_screen.dart';
import 'package:qiyomat_va_oxirat/util/navigator_settings.dart';
import 'package:qiyomat_va_oxirat/widgets/banner_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/screen/login_screen.dart';
import 'package:qiyomat_va_oxirat/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  late SharedPreferences loginData;
  String username = '';
  String filName = '';
  late bool _isDark = true;

  @override
  void initState() {
    getData();
    initial();
    super.initState();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString("username")!;
      filName = loginData.getString("filName")!;
    });
  }

  void saveData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
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
    return Consumer<FavProvider>(
      builder: (context, value, child) {
        return WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
              context: context,
              builder: (context) => AlderDilaogNew(),
            );
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          },
          child: Consumer<FavProvider>(
            builder: (context, value, child) {
              return SafeArea(
                child: Scaffold(
                  backgroundColor:
                      _isDark ? Colors.white : Constants().darkLight,
                  appBar: AppBar(
                    leadingWidth: 40,
                    leading: leading(),
                    iconTheme: const IconThemeData(color: Colors.black),
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      "hi".tr() + username,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    actions: [actions()],
                    backgroundColor:
                        _isDark ? Colors.white : Constants().darkLight,
                  ),
                  body: body(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget body() {
    final mainProvider = Provider.of<FavProvider>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return FutureBuilder(
      future: mainProvider.getFavList(),
      builder: (context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            BannerItem(
              Text(
                "bookName".tr(),
                style: TextStyle(
                    color: _isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
               Expanded(
                child: SizedBox(
                  height: size.height*0.2
                ),
              ),
              CircleAvatar(
                backgroundColor: _isDark ? Colors.white : Constants().darkLight,
                child: IconButton(
                    onPressed: () {
                      _alderDialog2();
                    },
                    icon: _isDark
                        ? Icon(
                            Icons.dark_mode,
                            color: Constants().mainColor,
                          )
                        : Icon(
                            Icons.light_mode,
                            color: Constants().darkDark,
                          )),
              ),
              _isDark
                  ? const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/a.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(34)),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Color(0xff478CE8),
                      //     Color(0xFF5796EC),
                      //     Color(0xFF6BA3F3),
                      //     Color(0xff9DC1FF),
                      //     Color(0xFF6BA3F3),
                      //     Color(0xFF5796EC),
                      //     Color(0xff478CE8),
                      //   ],
                      // ),
                    )
                  : const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(34)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/a.jpg"),
                          fit: BoxFit.cover),
                    ),
              _isDark ? Colors.white : Constants().darkLight,
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: BookModel.bookModel.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 6,
                          crossAxisCount: 2,
                          mainAxisExtent: size.height * 0.4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 30),
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(
                          future: getFavList(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.contains(index)) {
                                return ProductItem(
                                  BookModel.bookModel[index],
                                  index,
                                  isFav: true,
                                );
                              } else {
                                return ProductItem(
                                  BookModel.bookModel[index],
                                  index,
                                  isFav: false,
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<int>> getFavList() async {
    final mainProvider = Provider.of<FavProvider>(context, listen: false);
    return await mainProvider.getFavList();
  }

  Widget AlderDilaogNew() {
    return AlertDialog(
      title: Card(
          elevation: 20,
          shadowColor: Colors.grey,
          child: Image.asset("assets/images/img.png")),
      content: Text("info".tr(),
          style: TextStyle(
              fontSize: 24,
              color: _isDark ? Constants().mainColor : Constants().darkDark,
              fontWeight: FontWeight.w600)),
      backgroundColor: _isDark ? Colors.white : Constants().darkLight,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    _isDark ? Constants().mainColor : Constants().darkDark)),
            onPressed: () {
              Navigator.of(context).pop(exit(1));
// exit(0);
            },
            child: Text("yes".tr())),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    _isDark ? Constants().mainColor : Constants().darkDark)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("no".tr())),
      ],
    );
  }

  void _alderDialog() async {
    await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: _isDark ? Colors.white : Constants().darkLight,
              title: Text(
                "$username $filName",
                style: TextStyle(
                    fontSize: 20,
                    color:
                        _isDark ? Constants().mainColor : Constants().darkDark),
              ),
              content: Text("info2".tr()),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(_isDark
                            ? Constants().mainColor
                            : Constants().darkDark)),
                    onPressed: () async {
                      loginData.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text("yes".tr())),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(_isDark
                            ? Constants().mainColor
                            : Constants().darkDark)),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.of(context).pop(false);
                    },
                    child: Text("no".tr())),
              ],
            ));
  }

  void _alderDialog2() async {
    await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: _isDark ? Colors.white : Constants().darkLight,
              title: Text(
                _isDark ? "moon".tr() : "sun".tr(),
                style: TextStyle(
                    fontSize: 20,
                    color:
                        _isDark ? Constants().mainColor : Constants().darkDark),
              ),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(_isDark
                            ? Constants().mainColor
                            : Constants().darkDark)),
                    onPressed: () async {
                      setState(
                        () {
                          _isDark = !_isDark;
                        },
                      );
                      saveData(_isDark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavBar(),
                          ));
                    },
                    child: Text("yes".tr())),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(_isDark
                            ? Constants().mainColor
                            : Constants().darkDark)),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.of(context).pop(false);
                    },
                    child: Text("no".tr())),
              ],
            ));
  }

  Widget actions() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        _alderDialog();
      },
      child: CircleAvatar(
        backgroundColor: _isDark ? Constants().mainColor : Constants().darkDark,
        child: Icon(
          CupertinoIcons.square_arrow_right,
          color: _isDark ? Colors.white : Constants().darkLight,
        ),
      ),
    );
  }

  Widget leading() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        NewNavigator.RightToLeft(context, HilolNashrScreen());
      },
      child: CircleAvatar(
        backgroundColor: _isDark ? Constants().mainColor : Constants().darkDark,
        child: Icon(
          Icons.info_outline,
          color: _isDark ? Colors.white : Constants().darkLight,
        ),
      ),
    );
  }
}
