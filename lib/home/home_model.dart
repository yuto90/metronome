import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'Dart:async';

class HomeModel extends ChangeNotifier {
  int defaultTempo = 60;
  int tempo = 60;
  int oneBeat = 0;
  bool run = false;

  int tempoDuration = 0;
  Alignment alignment = Alignment.bottomRight;

  Soundpool beatPool = Soundpool(streamType: StreamType.alarm);
  late int beat;
  Soundpool finishPool = Soundpool(streamType: StreamType.alarm);
  late int finish;
  Soundpool clickPool = Soundpool(streamType: StreamType.alarm);
  late int click;
  DateTime check = DateTime.now();

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
    if (run) {
      run = false;
      notifyListeners();
    } else {
      run = true;
      runMetronome();
    }
  }

  // 無限ループするメトロノーム
  void runMetronome() {
    // テンポの計算
    tempoDuration = 60000000 ~/ tempo;
    var duration = Duration(microseconds: tempoDuration);
    Timer.periodic(duration, (Timer t) => beatLoop(t));
  }

  // Timerで繰り返し処理する用
  void beatLoop(Timer t) {
    if (!run) {
      t.cancel();
    }
    clickPool.play(click); // 一拍の音`

    if (this.alignment == Alignment.bottomRight) {
      this.alignment = Alignment.bottomLeft;
    } else {
      this.alignment = Alignment.bottomRight;
    }
    notifyListeners();
  }

  // シークバーでテンポを変える
  void changeTempo(double value) {
    tempo = value.toInt();
    notifyListeners();
  }

  // メトロノームをリセットする
  void metronomeReset() {
    run = false;
    tempo = defaultTempo;
    notifyListeners();
  }

  // ボタンをタップした時
  void tap() {}
}
