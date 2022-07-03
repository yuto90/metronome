import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';

class BpmModel extends ChangeNotifier {
  BpmModel() {
    // デフォルトのBPM
    controller.text = '60';
  }
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

  // テキストフィールドのコントローラー
  TextEditingController controller = TextEditingController();

  /// 今どの音符がpickされているかを格納
  int selectedNoteIndex = 0;

  /// 今どの拍子がpickされているかを格納
  int selectedBeatType = 4;

  // アクセント可否フラグ
  bool isAccent = false;
  // ジャスト反映の可視化フラグ
  bool isJustZone = false;
  // 振り子の表示フラグ
  bool isPendulum = false;
  // 拍子の表示フラグ
  bool isClick = false;
  // バイブレーション
  bool isVibration = false;

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

  // テキストフィールドでテンポを変える
  void changeTempoKeyboard(bool hasFocus) {
    // フォーカスが外れていれば
    if (!hasFocus) {
      // 想定範囲愛の値を入力された時のハンドリング
      if (controller.text == '') {
        controller.text = '40';
      } else if (int.parse(controller.text) >= 200) {
        controller.text = '200';
      } else if (int.parse(controller.text) <= 40) {
        controller.text = '40';
      }
    }

    notifyListeners();
  }

  // シークバーでテンポを変える
  void changeTempoSlider(double value) {
    controller.text = value.toInt().toString();
    notifyListeners();
  }

  // アクセントを付けるか
  void checkAccent() {
    isAccent = !isAccent;
    notifyListeners();
  }

  // ジャスト判定か
  void checkJustZone(BuildContext context) {
    isJustZone = !isJustZone;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  // バイブレーションを鳴らすか
  void checkVibration() {
    isVibration = !isVibration;
    notifyListeners();
  }

  // 画面を更新
  void notify() {
    notifyListeners();
  }
}
