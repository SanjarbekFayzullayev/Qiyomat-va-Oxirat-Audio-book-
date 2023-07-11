import 'package:qiyomat_va_oxirat/provider/provider_favorute.dart';
import 'package:qiyomat_va_oxirat/screen/lang_changet_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
//
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const[
        Locale('uz', 'UZ'),
        Locale('uz', 'KR'),
      ], path: 'assets/tres',
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>FavProvider())
      ],child: const MyApp()),));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      theme: ThemeData(

      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
     home:const LangChange(),
    );
  }
}

