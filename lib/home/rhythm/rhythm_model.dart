import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/home/footer/footer_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';
import 'package:soundpool/soundpool.dart';

class RhythmModel extends ChangeNotifier {
  RhythmModel(BuildContext context) {
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

  // 座標を追跡するWidgetに渡すkey
  final rightGlobalKey = GlobalKey();
  final leftGlobalKey = GlobalKey();
  final pendulumGlobalKey = GlobalKey();

  // スタイルのプロパティ
  HomeProperty homeProperty = HomeProperty();

  double pendulumWidth = 1;
  // ジャストタイミングとして許容する幅
  double safeWidth = 30.0;
  // 振り子の初期位置
  Alignment alignment = Alignment.bottomRight;
  // 振り子のテンポ
  int pendulumTempoDuration = 0;
  // メトロノームの内部ループのテンポ
  int tempoDuration = 0;
  //メトロノームの動作on/off
  bool run = false;
  // 現在の拍
  // todo 4拍以外も作る
  int nowBeat = -1;
  // 現在のクリック
  int nowClick = -1;
  // late:初期化を遅らせるだけ。使う前には初期化が必要
  late Offset limitRight;
  late Offset limitLeft;

  Soundpool finishPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int finish;

  Soundpool beatPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int beat;

  Soundpool clickPool = Soundpool.fromOptions(
    options: SoundpoolOptions(streamType: StreamType.music),
  );
  late int click;

  // メトロノームの初回init処理
  void initMetronome() {
    // 右側限界値の座標を取得
    RenderBox rightRenderBox =
        rightGlobalKey.currentContext!.findRenderObject() as RenderBox;
    limitRight = rightRenderBox.localToGlobal(Offset.zero);

    //左側限界値の座標を取得
    RenderBox leftRenderBox =
        leftGlobalKey.currentContext!.findRenderObject() as RenderBox;
    limitLeft = leftRenderBox.localToGlobal(Offset.zero);
  }

  // メトロノームの起動処理
  Future<void> toggleMetronome(BuildContext context) async {
    // メトロノームの起動チェック
    if (run) {
      run = false;
      notifyListeners();
    } else {
      run = true; // メトロノームを起動
      // 一旦beat数を初期化
      nowBeat = -1;
      nowClick = -1;
      // メトロノームの初期化
      initMetronome();
      runMetronome(context);
    }
    context.read<FooterModel>().notify();
  }

  // 無限ループするメトロノーム
  Future<void> runMetronome(BuildContext context) async {
    BpmModel bpmModel = context.read<BpmModel>();
    FooterModel footerModel = context.read<FooterModel>();
    // テンポの計算
    pendulumTempoDuration = 60000 ~/ context.read<BpmModel>().sliderTempo;

    // todo もっと効率よく書けそう
    if (bpmModel.selectedNoteIndex == 0) {
      // 4分
      tempoDuration = pendulumTempoDuration;
    } else if (bpmModel.selectedNoteIndex == 1) {
      // 8分2連
      //? 「~/:除算、整数の結果を返す」
      tempoDuration = pendulumTempoDuration ~/ 2;
    } else if (bpmModel.selectedNoteIndex == 2) {
      // 8分3連
      tempoDuration = pendulumTempoDuration ~/ 3;
    } else if (bpmModel.selectedNoteIndex == 3) {
      // 16分4連
      tempoDuration = pendulumTempoDuration ~/ 4;
    }

    while (run) {
      nowClick++;

      if (nowClick % (bpmModel.selectedNoteIndex + 1) == 0) {
        nowBeat++;
        nowClick = 0;

        this.alignment = this.alignment == Alignment.bottomRight
            ? this.alignment = Alignment.bottomLeft
            : this.alignment = Alignment.bottomRight;
      }

      if (nowBeat == bpmModel.selectedBeatType + 1) {
        nowBeat = 0;
        //nowClick = 0;
      }

      // ミュートボタンが押されている場合は音を出さない
      if (!footerModel.isMute) {
        // 最後の拍 かつ アクセントフラグがtrue
        if (nowBeat == bpmModel.selectedBeatType && bpmModel.isAccent) {
          finishPool.play(finish);
          //print(nowBeat);
          //print(nowClick);
        } else {
          beatPool.play(beat);
        }
      }
      //print('-------------\n$nowBeat\n$nowClick');

      notifyListeners();
      await Future.delayed(Duration(milliseconds: tempoDuration));
    }
  }

  // 画面更新用
  void notify() {
    notifyListeners();
  }
}
