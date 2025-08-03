import 'package:flutter/material.dart';
import 'package:metronome/property/hex.dart';
import 'package:metronome/property/color_settings.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'tap_model.dart';

class Tap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TapModel, ColorSettings>(
      builder: (context, model, colorSettings, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            GestureDetector(
              // Widgetを押した時
              onTapDown: (_) => model.tapDown(context),
              // Widgetを離した時
              onTapUp: (_) => model.tapUp(context),
              // Widgetを押している最中に指が範囲外に出た時
              onTapCancel: () => model.tapUp(context),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: SizeConfig.blockSizeHorizontal! * 50,
                height: SizeConfig.blockSizeVertical! * 20,
                child: Icon(
                  Icons.touch_app,
                  color: model.isJustBeat ? Colors.green : colorSettings.primaryColor,
                  size: SizeConfig.blockSizeVertical! * 10,
                ),
                decoration: BoxDecoration(
                  color: HexColor('#f0f0f0'),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: model.isMainButtonTap
                      ? [
                          // ボタン押下時は影を無くす
                        ]
                      : [
                          BoxShadow(
                            color: model.isJustBeat
                                ? Colors.green
                                : HexColor('#b6b6b6'),
                            offset: Offset(6, 6),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: model.isJustBeat
                                ? Colors.green
                                : HexColor('#ffffff'),
                            offset: Offset(-6, -6),
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ],
                ),
              ),
            ),
            Spacer(),
          ],
        );
      },
    );
  }
}
