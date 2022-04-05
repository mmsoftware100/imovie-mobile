import 'dart:io';

class AdHelper {

  static const bool production = false;

  static const String androidBannerAdUnitId = "ca-app-pub-1260377822287392/4852842631";
  static const String androidBannerTestAdUnitId = "ca-app-pub-3940256099942544/6300978111";

  static const String iOsBannerAdUnitId = "";
  static const String iOsBannerTestAdUnitId = "ca-app-pub-3940256099942544/2934735716";

  static const String androidInterstitialAdUnitId = "ca-app-pub-1260377822287392/8217372571";
  static const String androidInterstitialTestAdUnitId = "ca-app-pub-3940256099942544/1033173712";

  static const String iOsInterstitialAdUnitId = "";
  static const String iOsInterstitialTestAdUnitId = "ca-app-pub-3940256099942544/4411468910";

  static const String androidRewardAdUnitId = "ca-app-pub-3345081364391043/3041987380";
  static const String androidRewardTestAdUnitId = "ca-app-pub-3940256099942544/5224354917";

  static const String iOsRewardAdUnitId = "";
  static const String iOsRewardTestAdUnitId = "ca-app-pub-3940256099942544/1712485313";


  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if(production) return androidBannerAdUnitId;
      else return androidBannerTestAdUnitId;
    } else if (Platform.isIOS) {
      if(production) return iOsBannerAdUnitId;
      else return iOsBannerTestAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      if(production) return androidInterstitialAdUnitId;
      else return androidInterstitialTestAdUnitId;
    } else if (Platform.isIOS) {
      if(production) return iOsInterstitialAdUnitId;
      else return iOsInterstitialTestAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      if(production) return androidInterstitialAdUnitId;
      else return androidRewardTestAdUnitId;
    } else if (Platform.isIOS) {
      if(production) return iOsInterstitialAdUnitId;
      else return iOsInterstitialTestAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
