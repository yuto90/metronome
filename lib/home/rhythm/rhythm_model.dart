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
  // 1拍にかかるの時間のマイクロ秒
  int tempoDuration = 0;
  //メトロノームの動作on/off
  bool run = false;
  // todo 4拍以外も作る
  int nowBeat = -1;
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
      // メトロノームの初期化
      initMetronome();
      runMetronome(context);
    }
    context.read<FooterModel>().notify();
  }

  // 無限ループするメトロノーム
  Future<void> runMetronome(BuildContext context) async {
    BpmModel bpmModel;
    // テンポの計算
    tempoDuration = 60000 ~/ context.read<BpmModel>().sliderTempo;
    while (run) {
      nowBeat++;
      bpmModel = context.read<BpmModel>();
      if (nowBeat == bpmModel.selectedBeatType + 1) {
        nowBeat = 0;
      }

      // ミュートボタンが押されている場合は音を出さない
      if (!context.read<FooterModel>().isMute) {
        // 4拍目でfinishを鳴らす
        if (nowBeat == bpmModel.selectedBeatType && bpmModel.isAccent) {
          finishPool.play(finish); // 4拍目の音
        } else {
          beatPool.play(beat); // 1拍の音`
        }
      }

      this.alignment = this.alignment == Alignment.bottomRight
          ? this.alignment = Alignment.bottomLeft
          : this.alignment = Alignment.bottomRight;

      notifyListeners();
      await Future.delayed(Duration(milliseconds: tempoDuration));
    }
  }

  // 画面更新用
  void notify() {
    notifyListeners();
  }
}
