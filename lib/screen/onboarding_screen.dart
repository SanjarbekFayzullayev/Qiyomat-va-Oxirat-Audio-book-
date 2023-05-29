import 'package:qiyomat_va_oxirat/screen/bottom_nav_bar_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qiyomat_va_oxirat/moduls/onboardin_model.dart';
import 'package:qiyomat_va_oxirat/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    checkLogin();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var uz = const Locale('uz', 'UZ');
  var kr = const Locale('uz', 'KR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff478CE8),
                Color(0xFF5796EC),
                Color(0xFF6BA3F3),
                Color(0xff9DC1FF),
                Color(0xFF6BA3F3),
                Color(0xFF5796EC),
                Color(0xff478CE8),
              ]),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: model.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(34),
                      child: Column(
                        children: [
                          Lottie.asset(
                            model[i].image,
                          ),
                          Text(
                            context.locale.toString() == "uz_UZ"
                                ? model[i].nameUZ
                                : model[i].nameKR,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                context.locale.toString() == 'uz_UZ'
                                    ? model[i].decriptonUZ
                                    : model[i].decriptonKR,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    model.length,
                    (index) => builder(context, index),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: InkWell(
                        onTap: () {
                          if (currentIndex == model.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Icon(
                          currentIndex == model.length - 1
                              ? Icons.play_arrow
                              : Icons.play_arrow_outlined,
                          color: const Color(0xff478CE8),
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builder(BuildContext context, int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 10,
      margin: const EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
    );
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool("login") ?? true);
    if (newUser == false) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ));
    }
  }
}
