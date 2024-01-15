import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiyomat_va_oxirat/service/ad_mob_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HilolNashrScreen extends StatefulWidget {
  HilolNashrScreen({Key? key}) : super(key: key);

  @override
  State<HilolNashrScreen> createState() => _HilolNashrScreenState();
}

class _HilolNashrScreenState extends State<HilolNashrScreen> {
  String hilolNashirTg = "https://t.me/HilolNashr";
  String kitoblaruz = "https://kitoblardunyosi.uz";
  String hilolNashr = "https://hilolnashr.uz";
  String developer = "https://t.me/SanjarbekFayzullayev";
  var view = 16;
  late SharedPreferences loginData;
  late bool _isDark = true;
  late bool _isFull = true;
  String username = '';
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
    initial();
    getData();
    getInt();
    getFull();
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

  @override
  Widget build(BuildContext context) {
    String name = loginData.getString("username")!;
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
        height: _bottomBannerAd.size.height.toDouble(),
        width: _bottomBannerAd.size.width.toDouble(),
        child: AdWidget(ad: _bottomBannerAd),
      )
          : null,
      backgroundColor: _isDark ? Colors.white : const Color(0xFF9D5919),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.locale.toString() == "uz_UZ" ? "MANBA" : "МАНБА",
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showPopupMenu();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
        ],
        backgroundColor: _isDark ? Colors.white : const Color(0xFF9D5919),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6, left: 16),
                      child: Text(
                        textWidthBasis: TextWidthBasis.longestLine,
                        context.locale.toString() == "uz_UZ"
                            ? "     Bismillahir Rohmanir Rohim!\n\n"
                            "Abu Homid G'azzoliyning 'Qiyomat va Oxirat' "
                            "kitobi, insan hayotining haqiqiy ma'nosi va "
                            "uning oxiratiga oid ko'plab savollarga javob "
                            "topishga yordam beradi. Kitobda muallif, o'z "
                            "fikrlari va tajribalari bilan dunyodagi eng"
                            " muhim mavzularni qamrab o'tiradi va uni "
                            "o'qigan har bir kishi uchun maqsadli va manfaatli bo'ladi."
                            "Kitobda hayot, olam, shaxsiy rivojlanish, "
                            "\muxabbat, do'stlar, qiyomat va oxiratga oid "
                            "ko'plab mantiqiy savollar muhokama qilinadi. "
                            "Muallifning shakllantirdigi tahlillar juda chuqur"
                            " va nazariydir. U yana jahon adabiyoti tarixida qolgan "
                            "eng zamonaviy yondashuvlarni ham ishlatib chiqadi."
                            "'Qiyomat va Oxirat' kitobi, butunlay aql "
                            "fikrlarini ishlatib yozilgan bo'lib, o'qituvchilar, "
                            "ilm-fanlar, mashaqqatchilar va barcha insonlarga tavsiya etiladi."
                            " Bu kitobga ega bo'lgan har bir kishi "
                            "hayotni tushunishiga yordam beruvchi "
                            "fikr-mulohazalarni topishi mumkin. "
                            "Shuningdek, bu kitobning tarixi "
                            "ham juda uzunligi bilan tasdiqlangan."
                            "$username sizga tavsiya qilamanki  bu kitobni o'qishni boshlashingizni."
                            " Bu sizning hayotga oid fikrlaringizni o'zgartirishga yordam beradi."
                            "Kitobda o'tkazilgan mantiqiy muhokamalar va o'zbekcha tarjimasi ham juda qulaydir.\n"
                            "🔈 Audiolar: Solihlar Gulshani kanalidan olindi\n"
                            "🌐 Tarjimon: Otabek G‘aybulloh o‘g‘li\n"
                            "📚 Manba: ziyouz.com\n"
                            "\n Assalomu alaykum va rohnatulloxi va barokatux!"
                            : "     Бисмиллаҳир Роҳманир Роҳим!\n\n"
                            "Абу Ҳомид Ғаззолийнинг 'Қиёмат ва Охират' "
                            "китоби, инсан ҳаётининг ҳақиқий маъноси ва "
                            "унинг охиратига оид кўплаб саволларга жавоб "
                            "топишга ёрдам беради. Китобда муаллиф, ўз "
                            "фикрлари ва тажрибалари билан дунёдаги энг"
                            " муҳим мавзуларни қамраб ўтиради ва уни "
                            "ўқиган ҳар бир киши учун мақсадли ва манфаатли бўлади."
                            "Китобда ҳаёт, олам, шахсий ривожланиш, "
                            "мухаббат, дўстлар, қиёмат ва охиратга оид "
                            "кўплаб мантиқий саволлар муҳокама қилинади. "
                            "Муаллифнинг шакллантирдиги таҳлиллар жуда чуқур"
                            " ва назарийдир. У яна жаҳон адабиёти тарихида қолган "
                            "энг замонавий ёндашувларни ҳам ишлатиб чиқади."
                            "'Қиёмат ва Охират' китоби, бутунлай ақл "
                            "фикрларини ишлатиб ёзилган бўлиб, ўқитувчилар, "
                            "илм-фанлар, машаққатчилар ва барча инсонларга тавсия этилади."
                            " Бу китобга эга бўлган ҳар бир киши "
                            "ҳаётни тушунишига ёрдам берувчи "
                            "фикр-мулоҳазаларни топиши мумкин. "
                            "Шунингдек, бу китобнинг тарихи "
                            "ҳам жуда узунлиги билан тасдиқланган."
                            "$username сизга тавсия қиламанки  бу китобни ўқишни бошлашингизни."
                            " Бу сизнинг ҳаётга оид фикрларингизни ўзгартиришга ёрдам беради."
                            "Китобда ўтказилган мантиқий муҳокамалар ва ўзбекча таржимаси ҳам жуда қулайдир.\n"
                            "🔈 Аудиолар: Солиҳлар Гулшани каналидан олинди\n"
                            "🌐 Таржимон: Отабек Ғайбуллоҳ ўғли\n"
                            "📚 Манба: ziyouz.com\n"
                            "\n Ассалому алайкум ва роҳнатуллохи ва барокатух!",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: view.toDouble(),
                            height: 1.5,
                            textBaseline: TextBaseline.alphabetic,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "by ",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          " Muslim Soft LLC",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.lightBlue,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchUrl(url) async {
    await launch(url);
  }

  // Future<void> _launchUrl(String urls) async {
  //   final Uri url = Uri.parse(urls);
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
  void _showPopupMenu() async {
    await showMenu(
      color: _isDark ? Colors.white : Colors.brown,
      constraints: BoxConstraints.loose(
        Size.fromHeight(MediaQuery
            .of(context)
            .size
            .height * 0.3),
      ),
      context: context,
      items: [
        PopupMenuItem(
          child: InkWell(
            child: const Icon(Icons.search),
            onTap: () {
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
        ),
        PopupMenuItem(
          child: InkWell(
            child: const Icon(Icons.search_off),
            onTap: () {
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
        ),
        PopupMenuItem(
          child: InkWell(
            child: Icon(_isFull ? Icons.open_in_full : Icons.close_fullscreen),
            onTap: () {
              setState(
                    () {
                  _isFull = !_isFull;
                },
              );

              saveFull(_isFull);
            },
          ),
        ),
      ],
      elevation: 8.0,
      position: const RelativeRect.fromLTRB(1, 0, 0, 0),
    );
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString("username")!;
    });
  }
}
