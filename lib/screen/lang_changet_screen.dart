import 'package:qiyomat_va_oxirat/screen/onboarding_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_bar_screen.dart';

class LangChange extends StatefulWidget {
  const LangChange({Key? key}) : super(key: key);

  @override
  State<LangChange> createState() => _LangChangeState();
}

class _LangChangeState extends State<LangChange> {
  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 120,
            width: 200,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              onTap: () {
                context.setLocale(const Locale("uz", "UZ"));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardingScreen(),
                    ));
              },
              child: Card(
                shadowColor: Colors.blue,
                elevation: 24,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    "O'ZBEK",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            onTap: () {
              context.setLocale(const Locale("uz", "KR"));
              print(context.locale);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnBoardingScreen(),
                ));
            },
            child: SizedBox(
              height: 120,
              width: 200,
              child: Card(
                shadowColor: Colors.blue,
                elevation: 24,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    "КИРИЛ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
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
