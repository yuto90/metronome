import 'package:flutter/material.dart';
import 'package:metronome/property/home_property.dart';

class BpmModel extends ChangeNotifier {
  // スタイルのプロパティ
  HomeProperty homeProperty = HomeProperty();

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
  // 画面スライダーで設定したBPM
  int sliderTempo = 60;

  /// 音符を切り替えた時
  void pickNote(int index) {
    selectedNoteIndex = index;
    notifyListeners();
  }

  /// 拍を切り替えた時
  void pickBeatType(int index) {
    selectedBeatType = index;
    notifyListeners();
  }

  // シークバーでテンポを変える
  void changeTempo(double value) {
    sliderTempo = value.toInt();
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}