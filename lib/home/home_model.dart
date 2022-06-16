import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:metronome/property/home_property.dart';
import 'package:soundpool/soundpool.dart';
import 'Dart:async';

class HomeModel extends ChangeNotifier {
  // 変数 ------------------------------------------------------
  /// 音符のパスを格納
  List note = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
  ];

  /// 拍子の種類を格納
  List beatType = [
    '1/4',
    '2/4',
    '3/4',
    '4/4',
  ];

  /// 今どの音符がpickされているかを格納
  int selectedNoteIndex = 0;

  /// 今どの拍子がpickされているかを格納
  int selectedBeatType = 0;

  late BannerAd myBanner;

  int defaultTempo = 60; // デフォルトで設定するBPM
  int sliderTempo = 60; // 画面スライダーで設定したBPM
  bool run = false; //メトロノームの動作on/off

  // 振り子の表示フラグ
  bool isPendulum = false;
  // 拍子の表示フラグ
  bool isClick = false;
  // ボリュームのミュートフラグ
  bool isMute = false;
  // リセットボタン押下フラグ
  bool isReset = false;

  // 振り子座標の上限
  double leftXPosition = 10.0;
  double rightXPosition = 301.4;

  int tempoDuration = 0; // 1拍にかかるの時間のマイクロ秒
  Alignment alignment = Alignment.bottomRight;

  // todo 4拍以外も作る
  int nowBeat = 0;

  // 座標を追跡するWidgetに渡すkey
  final rightGlobalKey = GlobalKey();
  final leftGlobalKey = GlobalKey();
  final pendulumGlobalKey = GlobalKey();

  // late:初期化を遅らせるだけ。使う前には初期化が必要
  late Offset limitRight;
  late Offset limitLeft;

  late HomeProperty homeProperty;

  double pendulumWidth = 20;

  // ジャストタイミングとして許容する幅
  double safeWidth = 30.0;

  // タップの判定フラグ
  bool isJustBeat = false;
  // ボタンタップ判定フラグ
  bool isMainButtonTap = false;

  Soundpool beatPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int beat;

  Soundpool finishPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int finish;

  Soundpool clickPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int click;
  // 変数 ------------------------------------------------------

  // 画面読み込み時のinit処理
  HomeModel() {
    // プロパティ用のclassをインスタンス化
    homeProperty = HomeProperty();

    Future(() async {
      beat = await rootBundle
          .load('assets/sound/hammer.wav')
          .then((ByteData soundData) {
        return beatPool.load(soundData);
      });
      finish = await rootBundle
          .load('assets/sound/finish.wav')
          .then((ByteData soundData) {
        return finishPool.load(soundData);
      });
      click = await rootBundle
          .load('assets/sound/click.wav')
          .then((ByteData soundData) {
        return clickPool.load(soundData);
      });
    });

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

  // メトロノームの初回init処理
  void initMetronome() {
    // 右側限界値の座標を取得
    RenderBox rightRenderBox =
        rightGlobalKey.currentContext!.findRenderObject() as RenderBox;
    limitRight = rightRenderBox.localToGlobal(Offset.zero);

    //左側限界値の座標を取得
    RenderBox leftRenderBox =
        leftGlobalKey.currentContext!.findRenderObject() as RenderBox;
    limitLeft = leftRenderBox.localToGlobal(Offset.zero);
  }

  // メトロノームの起動処理
  Future<void> toggleMetronome() async {
    // メトロノームの起動チェック
    if (run) {
      run = false;
      notifyListeners();
    } else {
      run = true; // メトロノームを起動
      nowBeat = 0;
      // メトロノームの初期化
      initMetronome();
      runMetronome();
    }
  }

  // 無限ループするメトロノーム
  Future<void> runMetronome() async {
    // テンポの計算
    tempoDuration = 60000 ~/ sliderTempo;
    while (run) {
      nowBeat++;
      if (nowBeat == 5) {
        nowBeat = 1;
      }

      // todo 設定で鳴らすか選択させる
      // 4拍目でfinishを鳴らす
      if (nowBeat == 4) {
        finishPool.play(finish); // 4拍目の音
      } else {
        beatPool.play(beat); // 1拍の音`
      }

      this.alignment = this.alignment == Alignment.bottomRight
          ? this.alignment = Alignment.bottomLeft
          : this.alignment = Alignment.bottomRight;

      notifyListeners();
      await Future.delayed(Duration(milliseconds: tempoDuration));
    }
  }

  // シークバーでテンポを変える
  void changeTempo(double value) {
    sliderTempo = value.toInt();
    notifyListeners();
  }

  // ボタンをタップした時
  void tapDown() {
    isMainButtonTap = true;

    if (run) {
      // widgetKeyを付けたWidgetのグローバル座標を取得する
      final RenderBox pendulumBox =
          pendulumGlobalKey.currentContext!.findRenderObject() as RenderBox;
      final pendulumWidget = pendulumBox.localToGlobal(Offset.zero);

      print(pendulumWidget);
      if (pendulumWidget.dx <= limitLeft.dx + safeWidth ||
          pendulumWidget.dx >= limitRight.dx - safeWidth) {
        isJustBeat = true;
        print(isJustBeat);
      } else {
        isJustBeat = false;
      }
    }
    notifyListeners();
  }

  /// ボタンを離した時
  void tapUp() {
    isMainButtonTap = false;
    notifyListeners();
  }

  // 振り子の画面表示フラグを切り替える関数
  void togglePendulum() {
    isPendulum = !isPendulum;
    notifyListeners();
  }

  // クリックの画面表示フラグを切り替える関数
  void toggleClick() {
    isClick = !isClick;
    notifyListeners();
  }

  /// ボリュームのミュートフラグを切り替える関数
  void toggleMute() {
    isMute = !isMute;
    notifyListeners();
  }

  /// リセットボタンを押した時
  void tapUpReset() {
    isReset = false;
    notifyListeners();
  }

  /// 音符をタップした時
  void pickNote(int index) {
    selectedNoteIndex = index;
    notifyListeners();
  }

  /// 音符をタップした時
  void pickBeatType(int index) {
    selectedBeatType = index;
    notifyListeners();
  }

  /// 画面をリセットする
  void displayReset() {
    isReset = !isReset;
    run = false;
    sliderTempo = defaultTempo;
    nowBeat = 0;
    alignment = Alignment.bottomRight;
    isJustBeat = false;
    isMainButtonTap = false;
    isPendulum = false;
    isClick = false;
    isMute = false;
    //selectedNoteIndex = 0;
    //selectedBeatType = 0;
    notifyListeners();
  }
}
