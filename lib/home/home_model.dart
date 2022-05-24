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

  // todo 4拍以外も作る
  int nowBeat = 0;

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
    print(tempoDuration);
    var duration = Duration(microseconds: tempoDuration);
    print(duration);
    Timer.periodic(duration, (Timer t) => beatLoop(t));
  }

  // Timerで繰り返し処理する用
  void beatLoop(Timer t) {
    if (!run) {
      t.cancel();
    }
    clickPool.play(click); // 一拍の音`
    stepBeat();

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
    nowBeat = 0;
    notifyListeners();
  }

  // 何拍目かを更新
  void stepBeat() {
    if (nowBeat == 4) nowBeat = 0;
    nowBeat++;
  }

  // ボタンをタップした時
  void tap() {
    //if(tempoDuration)
  }
}
