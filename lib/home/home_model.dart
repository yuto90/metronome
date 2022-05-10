import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';
import 'Dart:async';

class HomeModel extends ChangeNotifier {
  int stepSize = 5; // 何BPM加速するか
  int bar = 4; // 何小節で1ループとするか
  int remainBeat = 16; // あと何拍で次のテンポに移るか
  int startTempo = 120; // どこから始めるか
  int maxTempo = 180; // どこまで加速するか
  int tempo = 120;
  int preCount = 0;
  bool run = false;
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

  void toggleMetronome() {
    if (run) {
      run = false;
      notifyListeners();
    } else {
      run = true;
      runMetronome();
    }
  }

  /// TODO: 4分の4拍子以外の対応
  int calcBeatPerLoop() {
    return bar * 4;
  }

  /// Timerで繰り返し処理する用の音源再生くん
  void beatLoop(Timer t) {
    if (!run) {
      t.cancel();
    }

    if (remainBeat == 0 && tempo < maxTempo) {
      t.cancel();
      finishPool.play(finish);

      // 値の更新
      tempo = tempo + stepSize;
      remainBeat = calcBeatPerLoop();
      notifyListeners();

      var duration = Duration(microseconds: (60000000 ~/ tempo));
      Timer.periodic(duration, (Timer t) => preBeat(t, duration));
    } else {
      beatPool.play(beat);
      remainBeat = max(remainBeat - 1, 0);
      notifyListeners();
    }
  }

  /// Timerで繰り返し処理する用の4カウント再生くん
  void preBeat(Timer t, duration) {
    if (!run) {
      t.cancel();
    }
    preCount++;
    clickPool.play(click);
    if (preCount == 4) {
      t.cancel();

      preCount = 0;
      notifyListeners();
      Timer.periodic(duration, (Timer t) => beatLoop(t));
    }
  }

  /// 無限ループするメトロノーム
  void runMetronome() {
    var duration = Duration(microseconds: (60000000 ~/ tempo)); // tempo = 120;
    Timer.periodic(duration, (Timer t) => beatLoop(t));
  }

  /// cupertinoPickerの子供として設定すると自然に見えるウィジェットを作る
  Widget cupertinoPickerChild(String text) {
    return Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
    ));
  }

  void hoge(int value) {
    stepSize = value + 1;
    notifyListeners();
  }

  void hoge2(int value) {
    bar = value + 1;
    remainBeat = calcBeatPerLoop();
    notifyListeners();
  }

  void hoge3(int value) {
    startTempo = value + 1;
    tempo = startTempo;
    notifyListeners();
  }

  void hoge4(int value) {
    maxTempo = value + 1;
    notifyListeners();
  }

  void hoge5(double value) {
    tempo = value.toInt();
    notifyListeners();
  }

  void hoge6() {
    run = false;
    tempo = startTempo;
    remainBeat = calcBeatPerLoop();
    notifyListeners();
  }
}
