import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/bpm_model.dart';
import 'package:metronome/home/footer/footer_model.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/src/provider.dart';
import '../../size_config.dart';

class Beat extends StatelessWidget {
  const Beat({Key? key, required this.model}) : super(key: key);

  final RhythmModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // todo context.watch...はmodelで変数化する
        for (int i = 0;
            i <= context.watch<BpmModel>().selectedBeatType;
            i++) ...[
          Spacer(),
          Container(
            width: SizeConfig.blockSizeHorizontal! * 5,
            height: SizeConfig.blockSizeVertical! * 3,
            decoration: BoxDecoration(
              color: context.read<FooterModel>().isClick
                  ? Colors.white
                  : model.nowBeat == i
                      ? Colors.blue
                      : Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          Spacer(),
          // todo 選択音符によって画面に表示するclickを可変
          for (int i = 0;
              i < context.watch<BpmModel>().selectedNoteIndex;
              i++) ...[
            Spacer(),
            Container(
              width: SizeConfig.blockSizeHorizontal! * 5,
              height: SizeConfig.blockSizeVertical! * 1,
              decoration: BoxDecoration(
                color: context.read<FooterModel>().isClick
                    ? Colors.white
                    : model.nowBeat == i
                        ? Colors.blue
                        : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ],
          Spacer(),
        ],
      ],
    );
  }
}
