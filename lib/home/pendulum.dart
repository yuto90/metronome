import 'package:flutter/material.dart';
import 'package:metronome/home/home_model.dart';

import '../size_config.dart';

class Pendulum extends StatelessWidget {
  const Pendulum({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.blockSizeHorizontal! * 90,
          height: SizeConfig.blockSizeVertical! * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 左側のジャストタイミングとして許容する範囲
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                      model.safeWidth,
                  height: SizeConfig.blockSizeVertical! * 1,
                  // ! ジャストのエリア可視化
                  color: Colors.white,
                  key: model.leftGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                ),
              ),
              // 右側のジャストタイミングとして許容する範囲
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                      model.safeWidth,
                  height: SizeConfig.blockSizeVertical! * 1,
                  // ! ジャストのエリア可視化
                  color: Colors.white,
                  key: model.rightGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
                ),
              ),
            ],
          ),
        ),
        // 振り子本体
        Container(
          width: SizeConfig.blockSizeHorizontal! * 90,
          height: SizeConfig.blockSizeVertical! * 3,
          color: model.isPendulum ? Colors.white : Colors.grey[300],
          child: AnimatedAlign(
            alignment: model.alignment,
            duration: Duration(milliseconds: model.tempoDuration),
            child: Container(
              width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth,
              height: SizeConfig.blockSizeVertical! * 4,
              color: model.isPendulum ? Colors.white : Colors.blue,
              key: model.pendulumGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
            ),
            curve: Curves.linear,
          ),
        ),
      ],
    );
  }
}
