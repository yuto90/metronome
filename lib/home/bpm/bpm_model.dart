import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';

class BpmModel extends ChangeNotifier {
  BpmModel(BuildContext context) {
    rhythmModel = RhythmModel(context);
  }
  late RhythmModel rhythmModel;
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
  int selectedBeatType = 4;
  // 画面スライダーで設定したBPM
  int sliderTempo = 60;

  // アクセント可否フラグ
  bool isAccent = false;
  // ジャスト反映の可視化フラグ
  bool isJustZone = false;
  // ボリュームのミュートフラグ
  bool isMute = false;
  // 振り子の表示フラグ
  bool isPendulum = false;
  // 拍子の表示フラグ
  bool isClick = false;

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

  /// ボリュームのミュートフラグを切り替える関数
  void toggleMute() {
    isMute = !isMute;
    notifyListeners();
  }

  /// 振り子の画面表示フラグを切り替える関数
  void togglePendulum(BuildContext context) {
    isPendulum = !isPendulum;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  /// クリックの画面表示フラグを切り替える関数
  void toggleClick(BuildContext context) {
    isClick = !isClick;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  // シークバーでテンポを変える
  void changeTempo(double value) {
    sliderTempo = value.toInt();
    notifyListeners();
  }

  // アクセントを付けるか
  void checkAccent() {
    isAccent = !isAccent;
    notifyListeners();
  }

  // アクセントを付けるか
  void checkJustZone(BuildContext context) {
    isJustZone = !isJustZone;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  // 画面を更新
  void notify() {
    notifyListeners();
  }
}
