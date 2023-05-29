class OnBoarding {
  String image;
  String nameUZ;
  String nameKR;
  String decriptonUZ;
  String decriptonKR;

  OnBoarding(
      {required this.image,
      required this.nameUZ,
      required this.nameKR,
      required this.decriptonUZ,
      required this.decriptonKR});
}

List<OnBoarding> model = [
  OnBoarding(
      image: "assets/lottie/famliyredingbook.json",
      nameKR: "Еслатма",
      nameUZ: "Eslatma",
      decriptonKR:
          "Дастурдан фойдаланишдан олдин покланишни тавсия қиламиз яний (ғусул ёки таҳорат) зеро Ислом дини поклик динидир!",
      decriptonUZ:
          "Dasturdan foydalanishdan oldin poklanishni tavsiya qilamiz yaniy (g'usul yoki tahorat) zero 'Islom' dini poklik dinidir!"),
  OnBoarding(
      image: "assets/lottie/zakat.json",
      nameUZ: "Iltimosimiz",
      nameKR: "Илтимосимиз",
      decriptonUZ:
          "Dasturni o'zingizga foydali deb bilsangiz yaqinlaringizga ulashing!Qo'lingizdan kelsa fikirlaringizni bo'lishing.Zero sababchi bo'lgan qilganbilan barobardur!",
      decriptonKR:
          "Дастурни ўзингизга фойдали деб билсангиз яқинларингизга улашинг!Қўлингиздан келса фикирларингизни бўлишинг.Зеро сабабчи бўлган қилганбилан баробардур!"),
  OnBoarding(
      image: "assets/lottie/duamuslim.json",
      nameUZ: "Unutmang",
      nameKR: "Унутманг",
      decriptonUZ:
          "Dasturdan o'zingizga foydali ma'naviy ozuqa olasangiz duolaringizda ABU HAMID MUHAMMAD AL G’AZZOLIY xaziratlarini eslashni unutmang!",
      decriptonKR:
          "Дастурдан ўзингизга фойдали маънавий озуқа оласангиз дуоларингизда АБУ ҲАМИД МУҲАММАД АЛ ҒАЗЗОЛИЙ хазиратларини еслашни унутманг!"),
];
