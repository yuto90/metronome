import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'Dart:async';

class HomeModel extends ChangeNotifier {
  int defaultTempo = 60; // デフォルトで設定するBPM
  int sliderTempo = 60; // 画面スライダーで設定したBPM
  bool run = false; //メトロノームの動作on/off

  // 振り子座標の上限
  double leftXPosition = 10.0;
  double rightXPosition = 301.4;

  int tempoDuration = 0; // 1拍にかかるの時間のマイクロ秒
  Alignment alignment = Alignment.bottomRight;
  // Right: Offset(301.4, 124.4)
  // Left: Offset(10.0, 124.4)

  // todo 4拍以外も作る
  int nowBeat = 0;

  // 座標を追跡するWidgetに渡すkey
  final widgetKey = GlobalKey();
  // タップの判定フラグ
  bool isJustBeat = false;

  Soundpool beatPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.alarm),
  );
  late int beat;

  Soundpool finishPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.alarm),
  );
  late int finish;

  Soundpool clickPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.alarm),
  );
  late int click;

  // init処理
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

  // メトロノームの起動処理
  void toggleMetronome() {
    // メトロノームの起動チェック
    if (run) {
      run = false;
    } else {
      run = true; // メトロノームを起動
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

    clickPool.play(click); // 一拍の音`
    // メトロノームスタート直後の1拍目は音を鳴らさない
    //if (nowBeat != -1) clickPool.play(click); // 一拍の音`

    // 今何拍子目かを更新
    if (nowBeat == 4) nowBeat = 0;
    nowBeat++;

    if (this.alignment == Alignment.bottomRight) {
      this.alignment = Alignment.bottomLeft;
    } else {
      this.alignment = Alignment.bottomRight;
    }

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
      final RenderBox box =
          widgetKey.currentContext!.findRenderObject() as RenderBox;
      final globalOffset = box.localToGlobal(Offset.zero);

      if ((rightXPosition - globalOffset.dx <= 3.0) ||
          (globalOffset.dx - leftXPosition <= 3.0)) {
        print('just!!!___$nowBeat');
        isJustBeat = true;
        notifyListeners();
      }
      print('---------------------------------');
    }
  }
}
