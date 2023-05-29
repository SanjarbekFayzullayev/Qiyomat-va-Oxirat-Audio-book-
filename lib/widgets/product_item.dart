import 'package:audioplayers/audioplayers.dart';
import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:qiyomat_va_oxirat/provider/provider_favorute.dart';
import 'package:qiyomat_va_oxirat/screen/desalis_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/util/navigator_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductItem extends StatefulWidget {
  BookModel bookModel;
  final index;
  final bool isFav;

  ProductItem(this.bookModel, this.index, {this.isFav = false, Key? key})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Card(
      color: _isDark ? Colors.white : Constants().darkDark,
      margin: const EdgeInsets.only(left: 8, right: 8),
      elevation: 26,
      shadowColor: _isDark
          ? widget.isFav
              ? Constants().mainColor
              : Colors.grey
          : widget.isFav
              ? Colors.white30
              : Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: _isDark ? Constants().mainColor :const  Color(0xFFBD641F),
              width: widget.isFav ? 2 : 0)),
      child: ClipRect(
        child: Banner(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          location: BannerLocation.topEnd,
          color: _isDark ? Constants().mainColor : Constants().darkLight,
          message: "infoCardTopEnd".tr(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                maxRadius: size.height * 0.1,
                foregroundImage: const AssetImage("assets/images/img.png"),
              ),
              Expanded(
                child: Text(
                  context.locale.toString().toString() == "uz_UZ"
                      ? widget.bookModel.nameUZ!
                      : widget.bookModel.nameKR!,
                  textAlign: TextAlign.center,
                  style:  TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.04),
                ),
              ),
              Text(
                "auth".tr(),
                textAlign: TextAlign.center,
                style:  TextStyle(fontSize: size.height*0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.isFav) {
                        Constants().snackBar("favRemove".tr(), context,_isDark? Constants().mainColor:Constants().darkDark);
                        removeFav(widget.index);
                      } else {
                        Constants().snackBar("favAdd".tr(), context,_isDark? Constants().mainColor:Constants().darkDark);
                        favAdd();
                      }
                    },
                    icon: Icon(
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
                      color: _isDark
                          ?  Constants().mainColor
                          : Constants().darkLight,
                    ),
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: _isDark
                            ?  Constants().mainColor
                            : Constants().darkLight,
                      ),
                      child: IconButton(
                        onPressed: () {
                          NewNavigator.RightToLeft(
                              context, DetalsPage(widget.bookModel));
                        },
                        icon: const Icon(
                          Icons.read_more_rounded,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void favAdd() async {
    final mainProvider = Provider.of<FavProvider>(context, listen: false);
    List<int> favList = await mainProvider.getFavList();
    var newList = List.of(favList);
    if (!newList.contains(widget.index)) {
      newList.add(widget.index);
    }
    mainProvider.savFavList(newList);
  }

  void removeFav(index) async {
    final mainProvider = Provider.of<FavProvider>(context, listen: false);
    List<int> favList = await mainProvider.getFavList();
    var newList = List.of(favList);
    newList.remove(index);
    mainProvider.savFavList(newList);
  }

  AudioPlayer player = AudioPlayer();
  late AudioCache audioCache;
}
