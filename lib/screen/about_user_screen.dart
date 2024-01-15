import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/provider/provider_favorute.dart';
import 'package:qiyomat_va_oxirat/screen/bottom_nav_bar_screen.dart';
import 'package:qiyomat_va_oxirat/screen/login_screen.dart';
import 'package:qiyomat_va_oxirat/service/ad_mob_service.dart';
import 'package:qiyomat_va_oxirat/util/navigator_settings.dart';
import 'package:qiyomat_va_oxirat/widgets/banner_item.dart';
import 'package:qiyomat_va_oxirat/widgets/product_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUserScreen extends StatefulWidget {
  const AboutUserScreen({Key? key}) : super(key: key);

  @override
  State<AboutUserScreen> createState() => _AboutUserScreenState();
}

class _AboutUserScreenState extends State<AboutUserScreen> {
  String username = '';
  late bool _isDark = true;
  String filName = '';
  late SharedPreferences loginData;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  void initState() {
    _createBottomBannerAd();
    getData();
    initial();
    super.initState();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('darkMode') ?? true;
    setState(() {
      _isDark = darkMode;
    });
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString("username")!;
      filName = loginData.getString("filName")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    final mainProvider = Provider.of<FavProvider>(context, listen: false);
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
      child: Consumer(
        builder: (context, value, child) {
          return FutureBuilder(
            future: mainProvider.getFavList(),
            builder: (context, AsyncSnapshot snapshot) {
              return Scaffold(
                bottomNavigationBar: _isBottomBannerAdLoaded
                    ? Container(
                        height: _bottomBannerAd.size.height.toDouble(),
                        width: _bottomBannerAd.size.width.toDouble(),
                        child: AdWidget(ad: _bottomBannerAd),
                      )
                    : null,
                backgroundColor: _isDark ? Colors.white : Constants().darkLight,
                body: SafeArea(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              NewNavigator.RightToLeft(
                                  context, const BottomNavBar());
                            },
                            icon: const Icon(Icons.arrow_back_ios_new)),
                        BannerItem(
                          Text(
                            snapshot.hasData
                                ? "saveAudios".tr() +
                                    snapshot.data.length.toString() +
                                    "ta".tr()
                                : "saveAudios".tr() + "ta".tr(),
                            style: TextStyle(
                                color: _isDark ? Colors.white : Colors.black,
                                fontSize: 20),
                          ),
                          ClipRect(
                            clipBehavior: Clip.values.elementAt(3),
                            child: Banner(
                              message: "infoUserTopEnd".tr(),
                              location: BannerLocation.topEnd,
                              color:
                                  _isDark ? Colors.green : Constants().darkDark,
                              child: Card(
                                color: _isDark
                                    ? Colors.white
                                    : Constants().darkLight,
                                elevation: 4,
                                shadowColor: Colors.black,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: _isDark
                                          ? Constants().mainColor
                                          : Constants().darkDark,
                                      size: size.height * 0.1 +
                                          size.height * 0.05,
                                    ),
                                    Text(username,
                                        style: TextStyle(
                                            color: _isDark
                                                ? Constants().mainColor
                                                : Constants().darkDark,
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.bold)),
                                    Text(filName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: _isDark
                                                ? Constants().mainColor
                                                : Constants().darkDark,
                                            fontSize: size.height * 0.02)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(),
                          _isDark
                              ? const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(34)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFAB5866),
                                      Color(0xFFAB5866),
                                      Color(0xFFAB7882),
                                      Color(0xFFAF969A),
                                      Color(0xFFAB7882),
                                      Color(0xFFAB5866),
                                      Color(0xFFAB5866),
                                    ],
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(34)),
                                  color: Constants().darkDark),
                          _isDark ? Colors.white : Constants().darkLight,
                        ),
                        !snapshot.hasData
                            ? const Expanded(
                                child: Center(
                                child: CircularProgressIndicator(),
                              ))
                            : Expanded(
                                child: GridView.builder(
                                  itemCount: snapshot.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 6,
                                          crossAxisCount: 2,
                                          mainAxisExtent: size.height * 0.4,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 30),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductItem(
                                      BookModel.bookModel[snapshot.data[index]],
                                      snapshot.data[index],
                                      isFav: true,
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
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
}
