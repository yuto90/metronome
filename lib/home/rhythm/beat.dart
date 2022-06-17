import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';

import '../../size_config.dart';
import '../home_model.dart';

class Beat extends StatelessWidget {
  const Beat({Key? key, required this.model}) : super(key: key);

  final RhythmModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          width: SizeConfig.blockSizeHorizontal! * 10,
          height: SizeConfig.blockSizeVertical! * 4,
          // todo ↓ 三項内に三項ってどうなの？
          decoration: BoxDecoration(
            color: model.isClick
                ? Colors.white
                : model.nowBeat == 1
                    ? Colors.blue
                    : Colors.grey[300],
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
                ? Colors.white
                : model.nowBeat == 2
                    ? Colors.blue
                    : Colors.grey[300],
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
                ? Colors.white
                : model.nowBeat == 3
                    ? Colors.blue
                    : Colors.grey[300],
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
                ? Colors.white
                : model.nowBeat == 4
                    ? Colors.blue
                    : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
