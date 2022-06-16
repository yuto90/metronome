import 'package:flutter/material.dart';
import 'package:metronome/home/home_model.dart';
import '../../size_config.dart';
import 'beat.dart';
import 'pendulum.dart';

class Rhythm extends StatelessWidget {
  const Rhythm({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
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
            Spacer(),
            Pendulum(model: model),
            Spacer(),
            Beat(model: model),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
