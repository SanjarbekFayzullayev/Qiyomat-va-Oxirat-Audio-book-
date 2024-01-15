import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/service/ad_mob_service.dart';
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
      child: Scaffold(
        bottomNavigationBar: _isBottomBannerAdLoaded
            ? Container(
          height: _bottomBannerAd.size.height.toDouble(),
          width: _bottomBannerAd.size.width.toDouble(),
          child: AdWidget(ad: _bottomBannerAd),
        )
            : null,
        backgroundColor: _isDark ? Colors.white : Constants().darkLight,
        body: SafeArea(
          child: Column(
            children: [
              Text(
                "head".tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
        ),
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
