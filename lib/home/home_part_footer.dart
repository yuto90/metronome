import 'package:flutter/material.dart';
import '../size_config.dart';
import 'home_model.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // todo  音量ミュートボタンを追加する
        Spacer(),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 10,
          height: SizeConfig.blockSizeVertical! * 6,
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
            onPressed: model.displayReset,
            elevation: 0, // 通常時のエレベーション
            hoverElevation: 0, // マウスホバー時のエレベーション
            highlightElevation: 0, // ボタン押下時のエレベーション
            child: Icon(Icons.replay, color: Colors.pink),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
