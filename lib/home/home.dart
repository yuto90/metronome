import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'home_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          // SizeConfigを初期化
          SizeConfig().init(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Just Beat',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          // 左側の最大振り子位置の取得用のWidget
                          Container(
                            width: SizeConfig.blockSizeHorizontal! * 90,
                            height: SizeConfig.blockSizeVertical! * 1,
                            // todo カラーを白にする
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal! *
                                        model.pendulumWidth +
                                    model.safeWidth,
                                height: SizeConfig.blockSizeVertical! * 1,
                                color: Colors.white,
                                key: model
                                    .leftGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                              ),
                            ),
                          ),
                          // 右側の最大振り子位置の取得用のWidget
                          Container(
                            width: SizeConfig.blockSizeHorizontal! * 90,
                            height: SizeConfig.blockSizeVertical! * 1,
                            // todo カラーを白にする
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal! *
                                        model.pendulumWidth +
                                    model.safeWidth,
                                height: SizeConfig.blockSizeVertical! * 1,
                                color: Colors.white,
                                key: model
                                    .rightGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                              ),
                            ),
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal! * 90,
                            height: SizeConfig.blockSizeVertical! * 4,
                            color: model.isPendulum
                                ? Colors.blueGrey[100]
                                : Colors.white,
                            child: AnimatedAlign(
                              alignment: model.alignment,
                              duration:
                                  Duration(milliseconds: model.tempoDuration),
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal! *
                                    model.pendulumWidth,
                                height: SizeConfig.blockSizeVertical! * 4,
                                color: model.isPendulum
                                    ? Colors.black
                                    : Colors.white,
                                key: model
                                    .pendulumGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                              ),
                              curve: Curves.linear,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                width: SizeConfig.blockSizeHorizontal! * 10,
                                height: SizeConfig.blockSizeVertical! * 4,
                                // todo ↓ 三項内に三項ってどうなの？
                                decoration: BoxDecoration(
                                  color: model.isClick
                                      ? model.nowBeat == 1
                                          ? Colors.blue
                                          : Colors.grey[700]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: SizeConfig.blockSizeHorizontal! * 10,
                                height: SizeConfig.blockSizeVertical! * 4,
                                // todo ↓ 三項内に三項ってどうなの？
                                decoration: BoxDecoration(
                                  color: model.isClick
                                      ? model.nowBeat == 2
                                          ? Colors.blue
                                          : Colors.grey[700]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: SizeConfig.blockSizeHorizontal! * 10,
                                height: SizeConfig.blockSizeVertical! * 4,
                                // todo ↓ 三項内に三項ってどうなの？
                                decoration: BoxDecoration(
                                  color: model.isClick
                                      ? model.nowBeat == 3
                                          ? Colors.blue
                                          : Colors.grey[700]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: SizeConfig.blockSizeHorizontal! * 10,
                                height: SizeConfig.blockSizeVertical! * 4,
                                // todo ↓ 三項内に三項ってどうなの？
                                decoration: BoxDecoration(
                                  color: model.isClick
                                      ? model.nowBeat == 4
                                          ? Colors.blue
                                          : Colors.grey[700]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            'now BPM',
                          ),
                          Center(
                            child: Text(
                              model.sliderTempo.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical! * 6,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Slider(
                            value: model.sliderTempo.toDouble(),
                            min: 1,
                            max: 200,
                            divisions: 200,
                            label: model.sliderTempo.toString(),
                            onChanged: (double value) {
                              model.changeTempo(value);
                            },
                          ),
                          Spacer(),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 50,
                            height: SizeConfig.blockSizeVertical! * 20,
                            child: ElevatedButton(
                              child: Text(
                                'Tap',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 3,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: model.isJustBeat
                                    ? Colors.green[200]
                                    : Colors.white,
                                onPrimary: Colors.black,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 3,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              onPressed: () => model.tap(),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // todo もっと直感的に分かりやすくしたい
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 20,
                                height: SizeConfig.blockSizeVertical! * 6,
                                child: ElevatedButton(
                                  child: Icon(Icons.settings_ethernet_rounded),
                                  //child: Icon(Icons.sync_alt),
                                  style: ElevatedButton.styleFrom(
                                    primary: model.isPendulum
                                        ? Colors.white
                                        : Colors.grey,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () => model.togglePendulum(),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 20,
                                height: SizeConfig.blockSizeVertical! * 6,
                                child: ElevatedButton(
                                  child: Icon(Icons.hdr_strong),
                                  //child: Icon(Icons.keyboard_control_outlined),
                                  style: ElevatedButton.styleFrom(
                                    primary: model.isClick
                                        ? Colors.white
                                        : Colors.grey,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () => model.toggleClick(),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Row(
                        children: [
                          Spacer(),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 10,
                            height: SizeConfig.blockSizeVertical! * 6,
                            child: FloatingActionButton(
                              backgroundColor: Colors.blueGrey[100],
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.metronomeReset,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: Icon(Icons.replay, color: Colors.pink),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 20,
                            height: SizeConfig.blockSizeVertical! * 6,
                            child: FloatingActionButton(
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.toggleMetronome,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: model.run
                                  ? Icon(Icons.stop, color: Colors.white)
                                  : Icon(Icons.play_arrow, color: Colors.white),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 10,
                            height: SizeConfig.blockSizeVertical! * 6,
                            child: FloatingActionButton(
                              backgroundColor: Colors.blueGrey[100],
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.metronomeReset,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: Icon(Icons.replay, color: Colors.pink),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
