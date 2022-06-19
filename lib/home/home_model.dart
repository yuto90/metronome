import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:metronome/property/home_property.dart';
import 'package:metronome/tap/tap_model.dart';
import 'package:provider/src/provider.dart';
import 'bpm/bpm_model.dart';
import 'footer/footer_model.dart';
import 'rhythm/rhythm_model.dart';

class HomeModel extends ChangeNotifier {
  RhythmModel rhythmModel = RhythmModel();

  late BannerAd myBanner;

  // 設定ボタン押下フラグ
  bool isSettings = false;

  // 振り子座標の上限
  double leftXPosition = 10.0;
  double rightXPosition = 301.4;

  // プロパティ用のclassをインスタンス化
  HomeProperty homeProperty = HomeProperty();

  // 画面読み込み時のinit処理
  HomeModel() {
    // バナー広告をインスタンス化
    myBanner = BannerAd(
      adUnitId: getTestAdBannerUnitId(),
      //adUnitId: 'ca-app-pub-8474156868822041/2299618878',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    // バナー広告の読み込み
    myBanner.load();
  }

  // プラットフォーム（iOS / Android）に合わせてデモ用広告IDを返す
  String getTestAdBannerUnitId() {
    String testBannerUnitId = "";
    if (Platform.isAndroid) {
      // Android のとき
      testBannerUnitId =
          "ca-app-pub-3940256099942544/6300978111"; // Androidのデモ用バナー広告ID
    } else if (Platform.isIOS) {
      // iOSのとき
      testBannerUnitId =
          "ca-app-pub-3940256099942544/2934735716"; // iOSのデモ用バナー広告ID
    }
    return testBannerUnitId;
  }

  /// 設定ボタンフラグを切り替える関数
  void toggleSettings() {
    isSettings = !isSettings;
    notifyListeners();
  }
}
