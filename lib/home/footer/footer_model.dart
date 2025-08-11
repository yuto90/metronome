import 'package:flutter/material.dart';
import 'package:metronome/property/home_property.dart';

class FooterModel extends ChangeNotifier {
  // プロパティ用のclassをインスタンス化
  HomeProperty homeProperty = HomeProperty();

  // ボリュームのミュートフラグ
  bool isMute = false;

  /// ボリュームのミュートフラグを切り替える関数
  void toggleMute() {
    isMute = !isMute;
    notifyListeners();
  }

  // 画面更新用
  void notify() {
    notifyListeners();
  }
}
