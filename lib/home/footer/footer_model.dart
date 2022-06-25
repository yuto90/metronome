import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';
import '../home_model.dart';

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
