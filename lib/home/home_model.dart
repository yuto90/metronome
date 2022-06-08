import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'Dart:async';

class HomeModel extends ChangeNotifier {
  // 変数 ------------------------------------------------------
  int defaultTempo = 60; // デフォルトで設定するBPM
  int sliderTempo = 60; // 画面スライダーで設定したBPM
  bool run = false; //メトロノームの動作on/off

  // 振り子の表示フラグ
  bool isPendulum = true;
  // 拍子の表示フラグ
  bool isClick = true;

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

  double pendulumWidth = 20;

  // ジャストタイミングとして許容する幅
  double safeWidth = 5.0;

  // タップの判定フラグ
  bool isJustBeat = false;

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
    } else {
      run = true; // メトロノームを起動
      // メトロノームの初期化
      initMetronome();
      runMetronome();
    }
  }

  // 無限ループするメトロノーム
  void runMetronome() {
    // テンポの計算
    tempoDuration = 60000 ~/ sliderTempo;
    Duration duration = Duration(milliseconds: tempoDuration);
    Timer.periodic(duration, (Timer t) => beatLoop(t));
  }

  // Timerで繰り返し処理する用
  void beatLoop(Timer t) {
    if (!run) {
      t.cancel();
    }

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
    isJustBeat = false;
  }

  // シークバーでテンポを変える
  void changeTempo(double value) {
    sliderTempo = value.toInt();
    notifyListeners();
  }

  // メトロノームをリセットする
  void metronomeReset() {
    run = false;
    sliderTempo = defaultTempo;
    nowBeat = 0;
    alignment = Alignment.bottomRight;
    notifyListeners();
  }

  // ボタンをタップした時
  void tap() {
    if (run) {
      // widgetKeyを付けたWidgetのグローバル座標を取得する
      final RenderBox pendulumBox =
          pendulumGlobalKey.currentContext!.findRenderObject() as RenderBox;
      final pendulumWidget = pendulumBox.localToGlobal(Offset.zero);

      if (pendulumWidget.dx <= limitLeft.dx + safeWidth ||
          pendulumWidget.dx >= limitRight.dx - safeWidth) {
        isJustBeat = true;
      } else {
        isJustBeat = false;
      }
      notifyListeners();
    }
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
}
