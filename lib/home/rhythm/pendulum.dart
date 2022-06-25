import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:provider/src/provider.dart';
import '../../size_config.dart';
import 'rhythm_model.dart';

class Pendulum extends StatelessWidget {
  const Pendulum({Key? key, required this.model}) : super(key: key);

  final RhythmModel model;

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
              Container(
                width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                    model.safeWidth,
                height: SizeConfig.blockSizeVertical! * 1,
                // ! ジャストのエリア可視化
                color: context.read<BpmModel>().isJustZone &&
                        !context.read<BpmModel>().isPendulum
                    ? Colors.green
                    : Colors.white,
                key: model.leftGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth,
                height: SizeConfig.blockSizeVertical! * 1,
                color: context.read<BpmModel>().isPendulum
                    ? Colors.white
                    : Colors.grey[300],
              ),
              // 右側のジャストタイミングとして許容する範囲
              Container(
                width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth +
                    model.safeWidth,
                height: SizeConfig.blockSizeVertical! * 1,
                // ! ジャストのエリア可視化
                color: context.read<BpmModel>().isJustZone &&
                        !context.read<BpmModel>().isPendulum
                    ? Colors.green
                    : Colors.white,
                key: model.rightGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
              ),
            ],
          ),
        ),
        // 振り子
        Container(
          width: SizeConfig.blockSizeHorizontal! * 90,
          height: SizeConfig.blockSizeVertical! * 3,
          color: context.read<BpmModel>().isPendulum
              ? Colors.white
              : Colors.grey[300],
          child: AnimatedAlign(
            alignment: model.alignment,
            duration: Duration(milliseconds: model.pendulumTempoDuration),
            child: Container(
              // 振り子本体
              width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth,
              height: SizeConfig.blockSizeVertical! * 4,
              color: context.read<BpmModel>().isPendulum
                  ? Colors.white
                  : Colors.blue,
              key: model.pendulumGlobalKey, // 座標を取得したいWidgetにkeyを付けると、後から参照できる
            ),
            curve: Curves.linear,
          ),
        ),

        Container(
          width: SizeConfig.blockSizeHorizontal! * 90,
          height: SizeConfig.blockSizeVertical! * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal! * model.pendulumWidth,
                height: SizeConfig.blockSizeVertical! * 1,
                color: context.read<BpmModel>().isPendulum
                    ? Colors.white
                    : Colors.grey[300],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
