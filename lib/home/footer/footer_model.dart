import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';
import '../home_model.dart';

class FooterModel extends ChangeNotifier {
  FooterModel(BuildContext context) {
    rhythmModel = context.read<RhythmModel>();
    homeModel = context.read<HomeModel>();
  }
  // プロパティ用のclassをインスタンス化
  HomeProperty homeProperty = HomeProperty();

  late HomeModel homeModel;
  late RhythmModel rhythmModel;

  // デフォルトで設定するBPM
  int defaultTempo = 60;

  // 画面更新用
  void notify() {
    notifyListeners();
  }
}
