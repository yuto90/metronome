import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';
import '../home_model.dart';

class FooterModel extends ChangeNotifier {
  FooterModel(BuildContext context) {
    rhythmModel = context.read<RhythmModel>();
  }
  // プロパティ用のclassをインスタンス化
  HomeProperty homeProperty = HomeProperty();
  HomeModel homeModel = HomeModel();

  late RhythmModel rhythmModel;

  // ボリュームのミュートフラグ
  bool isMute = false;
  // 振り子の表示フラグ
  bool isPendulum = false;
  // 拍子の表示フラグ
  bool isClick = false;

  // デフォルトで設定するBPM
  int defaultTempo = 60;

  /// ボリュームのミュートフラグを切り替える関数
  void toggleMute() {
    isMute = !isMute;
    notifyListeners();
  }

  // 振り子の画面表示フラグを切り替える関数
  void togglePendulum(BuildContext context) {
    isPendulum = !isPendulum;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  // クリックの画面表示フラグを切り替える関数
  void toggleClick(BuildContext context) {
    isClick = !isClick;
    context.read<RhythmModel>().notify();
    notifyListeners();
  }

  // 画面更新用
  void notify() {
    notifyListeners();
  }
}
