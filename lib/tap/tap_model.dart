import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/src/provider.dart';

class TapModel extends ChangeNotifier {
  TapModel(BuildContext context) {
    rhythmModel = context.read<RhythmModel>();
  }

  late RhythmModel rhythmModel;
  // タップの判定フラグ
  bool isJustBeat = false;
  // ボタンタップ判定フラグ
  bool isMainButtonTap = false;

  /// ボタンをタップした時
  void tapDown(BuildContext context) {
    isMainButtonTap = true;

    if (rhythmModel.run) {
      // widgetKeyを付けたWidgetのグローバル座標を取得する
      final RenderBox pendulumBox =
          rhythmModel.pendulumGlobalKey.currentContext!.findRenderObject()
              as RenderBox;
      final pendulumWidget = pendulumBox.localToGlobal(Offset.zero);

      print(pendulumWidget);
      if (pendulumWidget.dx <=
              rhythmModel.limitLeft.dx + rhythmModel.safeWidth ||
          pendulumWidget.dx >=
              rhythmModel.limitRight.dx - rhythmModel.safeWidth) {
        isJustBeat = true;
        print(isJustBeat);
      } else {
        isJustBeat = false;
      }
    }
    rhythmModel.notify();
    notifyListeners();
  }

  /// ボタンを離した時
  void tapUp(BuildContext context) {
    isMainButtonTap = false;
    rhythmModel.notify();
    notifyListeners();
  }
}
