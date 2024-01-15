import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:qiyomat_va_oxirat/service/ad_mob_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetalsPage extends StatefulWidget {
  BookModel bookModel;

  DetalsPage(this.bookModel, {Key? key}) : super(key: key);

  @override
  State<DetalsPage> createState() => _DetalsPageState();
}

class _DetalsPageState extends State<DetalsPage> {
  String username = '';
  var view = 16;
  late SharedPreferences loginData;
  late bool _isDark = true;
  late bool _isFull = true;
  late bool _isDown = false;
  bool playSound = false;
  final player = AudioPlayer();
  late AudioCache audioCache;
  Duration duration = Duration.zero;
  Duration duration2 = Duration.zero;
  Duration position = Duration.zero;
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
    super.initState();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        playSound = state == PlayerState.PLAYING;
      });
    });
    player.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    player.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    getData();
    getDown();
    getInt();
    getFull();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString("username")!;
    });
  }

  void getFull() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('fullMode') ?? true;
    setState(() {
      _isFull = darkMode;
    });
  }

  void saveFull(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fullMode', value);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('darkMode') ?? true;
    setState(() {
      _isDark = darkMode;
    });
  }

  void getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt("view") ?? 16;
    setState(() {
      view = value;
    });
  }

  void saveIntData(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('view', value);
  }

  void saveData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  void saveDown(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.bookModel.nameUZ!, value);
  }

  void getDown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool(widget.bookModel.nameUZ!) ?? true;
    setState(() {
      _isDown = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: _isDark ? Colors.white : Constants().darkLight,
            title: Text(
              "homeDialog".tr(),
              style: TextStyle(
                  fontSize: 25.0,
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
                    Navigator.of(context).pop(true);
                    player.stop();
                  },
                  child: Text("yes".tr())),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(_isDark
                          ? Constants().mainColor
                          : Constants().darkDark)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("no".tr())),
            ],
          ),
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: _isDark ? Colors.white : const Color(0xFF9D5919),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                player.stop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(
            context.locale.toString() == "uz_UZ"
                ? widget.bookModel.nameUZ!
                : widget.bookModel.nameKR!,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(context.locale.toString() == "uz_UZ"
                      ? 'Assalomu aleykum!\n Men ${username}man men Imom G’azzoliyning "Qiyomat va Oxirat" '
                          'kitobini audio va matn shaklida '
                          'mutolaa qilayabman va sizgaham '
                          'tavsiya qilaman!\n\n https://play.google.com/store/apps/dev?id=6201008957698378119'
                      : 'Ассалому алейкум!\н Мен ${username}ман мен Имом Ғаззолийнинг "Қиёмат ва Охират" '
                          'китобини аудио ва матн шаклида '
                          'мутолаа қилаябман ва сизгаҳам '
                          'тавсия қиламан!'
                          '\n\n https://play.google.com/store/apps/dev?id=6201008957698378119');
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                )),
          ],
          backgroundColor: _isDark ? Colors.white : const Color(0xFF9D5919),
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isFull ? headBar() : const SizedBox(),
               _isBottomBannerAdLoaded
                    ? Container(
                  height: _bottomBannerAd.size.height.toDouble(),
                  width: _bottomBannerAd.size.width.toDouble(),
                  child: AdWidget(ad: _bottomBannerAd),
                ) :SizedBox(),
                Expanded(
                  child: SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          _isFull ? const SizedBox() : headBar(),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 12),
                            child: Text(
                              context.locale.toString() == "uz_UZ"
                                  ? widget.bookModel.nameUZ!
                                  : widget.bookModel.nameKR!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 12),
                            child: Text(
                              "auth".tr(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.3,
                                right: 4,
                                left: 4),
                            child: Text(
                              context.locale.toString() == "uz_UZ"
                                  ? widget.bookModel.descriptionUZ!
                                  : widget.bookModel.descriptionKR!,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: view.toDouble()),
                            ),
                          ),
                        ],
                      ))),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: _isFull ? bottomBar(context) : const SizedBox())
          ],
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 8,
        shadowColor: _isDark ? Colors.indigoAccent : Colors.black,
        child: Container(
          height: size.width * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _isDark ? Colors.white : const Color(0xFF653610),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: size.height * 0.06,
                backgroundColor: const Color(0xffdcdfe0),
                foregroundImage: const AssetImage("assets/images/img.png"),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 6),
                      child: Text(
                        context.locale.toString() == "uz_UZ"
                            ? "${widget.bookModel.nameUZ}"
                            : widget.bookModel.nameKR!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (_isDown) {
                                // downloadFile("assets/${widget.bookModel.audioUrl}");
                                Constants().snackBar(
                                    "saveInfo".tr(),
                                    context,
                                    _isDark
                                        ? Constants().mainColor
                                        : Constants().darkDark);
                                setState(() {
                                  _isDown = false;
                                  saveDown(_isDown);
                                });
                              } else {
                                Constants().snackBar(
                                    "oldSave".tr(),
                                    context,
                                    _isDark
                                        ? Constants().mainColor
                                        : Constants().darkDark);
                              }
                            },
                            icon: Icon(
                              _isDown ? Icons.save_alt : Icons.save_outlined,
                              color: _isDark
                                  ? Constants().mainColor
                                  : const Color(0xFF9D5919),
                              size: 30,
                            )),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              playSound = !playSound;

                              if (playSound) {
                                audioCache = AudioCache(fixedPlayer: player);
                                audioCache.play(widget.bookModel.audioUrl!);
                              } else {
                                player.pause();
                              }
                            });
                          },
                          icon: Icon(
                            playSound
                                ? CupertinoIcons.pause_fill
                                : CupertinoIcons.play_arrow_solid,
                            color: _isDark
                                ? Constants().mainColor
                                : const Color(0xFF9D5919),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Slider(
                              activeColor: _isDark
                                  ? Constants().mainColor
                                  : const Color(0xFF9D5919),
                              inactiveColor: _isDark
                                  ? Constants().mainColor
                                  : Colors.brown,
                              min:0.0,
                              max: duration.inSeconds.toDouble()+20,
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await player.seek(position);
                                await player.resume();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(formatTime(duration2 + position),
                              style: const TextStyle(color: Colors.black)),
                          Text(formatTime(duration),
                              style: const TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headBar() {
    return Column(
      children: [
        _isDark
            ? Container(
                margin: const EdgeInsets.all(12),
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(34)),
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().mainColor)),
                      child: const Icon(Icons.zoom_in, color: Colors.white),
                      onPressed: () {
                        setState(
                          () {
                            if (view <= 30) {
                              ++view;
                            }
                          },
                        );
                        saveIntData(view);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().mainColor)),
                      child: const Icon(Icons.zoom_out, color: Colors.white),
                      onPressed: () {
                        setState(
                          () {
                            if (view >= 18) {
                              --view;
                            }
                          },
                        );
                        saveIntData(view);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().mainColor)),
                      child: Icon(
                          _isFull ? Icons.open_in_full : Icons.close_fullscreen,
                          color: Colors.white),
                      onPressed: () {
                        setState(
                          () {
                            _isFull = !_isFull;
                          },
                        );

                        saveFull(_isFull);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().mainColor)),
                      child:  Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: context.locale.toString() == "uz_UZ"  ? widget.bookModel.descriptionUZ!
                              : widget.bookModel.descriptionKR!,
                        ));
                        Constants().snackBar(
                            context.locale.toString() == "uz_UZ"
                                ? "Ushbu sahifadan nusxa olindi!"
                                : "Ушбу саҳифадан нусха олинди!",
                            context,
                            Constants().mainColor);
                      },
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Lottie.asset(
                    //         "assets/lottie/bookPages.json",
                    //         width: double.infinity,
                    //         height: double.infinity),
                    //   ),
                    // ),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.all(12),
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(34)),
                  color: Color(0xFF653610),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().darkLight)),
                      child: const Icon(Icons.zoom_in, color: Colors.black),
                      onPressed: () {
                        setState(
                          () {
                            if (view <= 30) {
                              ++view;
                            }
                          },
                        );
                        saveIntData(view);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().darkLight)),
                      child: const Icon(Icons.zoom_out, color: Colors.black),
                      onPressed: () {
                        setState(
                          () {
                            if (view >= 18) {
                              --view;
                            }
                          },
                        );
                        saveIntData(view);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().darkLight)),
                      child: Icon(
                          _isFull ? Icons.open_in_full : Icons.close_fullscreen,
                          color: Colors.black),
                      onPressed: () {
                        setState(
                          () {
                            _isFull = !_isFull;
                          },
                        );

                        saveFull(_isFull);
                      },
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Constants().darkLight)),
                      child: const Icon(Icons.copy, color: Colors.black),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: context.locale.toString() == "uz_UZ"
                              ? widget.bookModel.nameUZ!
                              : widget.bookModel.nameKR!,
                        ));
                      },
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Lottie.asset(
                    //         "assets/lottie/bookPages.json",
                    //         width: double.infinity,
                    //         height: double.infinity),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ],
    );
  }

  String formatTime(Duration duration) {
    String twDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twDigits(duration.inHours);
    final minutes = twDigits(duration.inMinutes.remainder(60));
    final seconds = twDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
