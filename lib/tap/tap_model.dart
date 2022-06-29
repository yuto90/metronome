import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/src/provider.dart';
import 'package:vibration/vibration.dart';

class TapModel extends ChangeNotifier {
  TapModel(BuildContext context) {
    rhythmModel = context.read<RhythmModel>();
    bpmModel = context.read<BpmModel>();
  }

  late RhythmModel rhythmModel;
  late BpmModel bpmModel;
  // タップの判定フラグ
  bool isJustBeat = false;
  // ボタンタップ判定フラグ
  bool isMainButtonTap = false;

  /// ボタンをタップした時
  Future<void> tapDown(BuildContext context) async {
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

        // 端末に振動機能がついているかチェック
        if (await Vibration.hasVibrator() != null && bpmModel.isVibration) {
          Vibration.vibrate(duration: 100);
        }
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
