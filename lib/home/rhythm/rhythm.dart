import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'beat.dart';
import 'pendulum.dart';
import 'rhythm_model.dart';

class Rhythm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RhythmModel>(
      builder: (context, model, child) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.blockSizeHorizontal! * 2,
            SizeConfig.blockSizeVertical! * 1,
            SizeConfig.blockSizeHorizontal! * 2,
            SizeConfig.blockSizeVertical! * 1,
          ),
          child: Container(
            decoration: model.homeProperty.smooth(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // todo オプションで表示オフの時は画面を再描画しない
                Spacer(),
                Pendulum(model: model),
                Spacer(),
                Beat(model: model),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
