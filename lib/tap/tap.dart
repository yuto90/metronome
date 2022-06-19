import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'tap_model.dart';

class Tap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TapModel>(
      builder: (context, model, child) {
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
                  color: model.isJustBeat ? Colors.red : Colors.blue,
                  size: SizeConfig.blockSizeVertical! * 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: model.isMainButtonTap
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  boxShadow: model.isMainButtonTap
                      ? [
                          // ボタン押下時は影を無くす
                        ]
                      : [
                          BoxShadow(
                            color: model.isJustBeat
                                ? Colors.red
                                : Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: model.isJustBeat ? Colors.red : Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
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
