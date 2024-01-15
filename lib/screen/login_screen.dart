import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/screen/bottom_nav_bar_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var nameController = TextEditingController();

  var filNameController = TextEditingController();

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset("assets/lottie/muslimandchildredingbook.json",height: size.height*0.3,width: size.height*0.3),
                 Text(
                  "register".tr(),
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    SizedBox(
                      width: size.width * 0.88,
                      height: 60,
                      child: TextFormField(
                        controller: nameController,
                        decoration:  InputDecoration(
                          hintText: "hitNam".tr(),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: "hitNam".tr(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.88,
                      height: 60,
                      child: TextField(
                        controller: filNameController,
                        decoration:  InputDecoration(
                          hintText: "hinFam".tr(),
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: "hinFam".tr(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  onTap: () {
                    String username = nameController.text;
                    String filName = filNameController.text;
                    if(username.length<14 && filName.length<14){
                      if (username != '' && filName != '') {
                        loginData.setBool("login", false);
                        loginData.setString("username", username);
                        loginData.setString("filName", filName);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                      } else {
                        Constants().snackBar('errorText'.tr(), context,const Color(0xff478CE8));
                      }
                    }else{
                      Constants().snackBar("errorText2".tr(),context,const Color(0xff478CE8));
                    }


                  },
                  child: SizedBox(
                    width: size.width * 0.88,
                    height: 50,
                    child:  Material(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          "okButton".tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool("login") ?? true);
    if (newUser==false) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    filNameController.dispose();
    super.dispose();
  }
}
