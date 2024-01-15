import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5679645962457544/2173198152";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5679645962457544/2173198152";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5679645962457544/2173198152";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5679645962457544/2173198152";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}