import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/property/home_property.dart';
import 'package:provider/src/provider.dart';
import 'package:soundpool/soundpool.dart';

class RhythmModel extends ChangeNotifier {
  RhythmModel() {
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

  double pendulumWidth = 20;
  // ジャストタイミングとして許容する幅
  double safeWidth = 30.0;
  // 振り子の初期位置
  Alignment alignment = Alignment.bottomRight;
  // 1拍にかかるの時間のマイクロ秒
  int tempoDuration = 0;
  //メトロノームの動作on/off
  bool run = false;
  // todo 4拍以外も作る
  int nowBeat = 0;
  // late:初期化を遅らせるだけ。使う前には初期化が必要
  late Offset limitRight;
  late Offset limitLeft;

  // 振り子の表示フラグ
  bool isPendulum = false;
  // 拍子の表示フラグ
  bool isClick = false;
  // ボリュームのミュートフラグ
  bool isMute = false;
  // タップの判定フラグ
  bool isJustBeat = false;
  // ボタンタップ判定フラグ
  bool isMainButtonTap = false;

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
      nowBeat = 0;
      // メトロノームの初期化
      initMetronome();
      runMetronome(context);
    }
  }

  // 無限ループするメトロノーム
  Future<void> runMetronome(BuildContext context) async {
    // テンポの計算
    tempoDuration = 60000 ~/ context.read<BpmModel>().sliderTempo;
    while (run) {
      nowBeat++;
      if (nowBeat == 5) {
        nowBeat = 1;
      }

      // ミュートボタンが押されている場合は音を出さない
      if (!isMute) {
        // 4拍目でfinishを鳴らす
        if (nowBeat == 4) {
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

  // ボタンをタップした時
  void tapDown() {
    isMainButtonTap = true;

    if (run) {
      // widgetKeyを付けたWidgetのグローバル座標を取得する
      final RenderBox pendulumBox =
          pendulumGlobalKey.currentContext!.findRenderObject() as RenderBox;
      final pendulumWidget = pendulumBox.localToGlobal(Offset.zero);

      print(pendulumWidget);
      if (pendulumWidget.dx <= limitLeft.dx + safeWidth ||
          pendulumWidget.dx >= limitRight.dx - safeWidth) {
        isJustBeat = true;
        print(isJustBeat);
      } else {
        isJustBeat = false;
      }
    }
    notifyListeners();
  }

  /// ボタンを離した時
  void tapUp() {
    isMainButtonTap = false;
    notifyListeners();
  }

  // 振り子の画面表示フラグを切り替える関数
  void togglePendulum() {
    isPendulum = !isPendulum;
    notifyListeners();
  }

  // クリックの画面表示フラグを切り替える関数
  void toggleClick() {
    isClick = !isClick;
    notifyListeners();
  }

  /// ボリュームのミュートフラグを切り替える関数
  void toggleMute() {
    isMute = !isMute;
    notifyListeners();
  }
}
