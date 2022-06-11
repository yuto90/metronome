import 'package:flutter/material.dart';
import '../size_config.dart';
import 'home_model.dart';

class Tap extends StatelessWidget {
  const Tap({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(),
        GestureDetector(
          // Widgetを押した時
          onTapDown: (_) => model.tapDown(),
          // Widgetを離した時
          onTapUp: (_) => model.tapUp(),
          // Widgetを押している最中に指が範囲外に出た時
          onTapCancel: () => model.tapUp(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            GestureDetector(
              onTap: () => model.togglePendulum(),
              onTapCancel: () => null,
              child: model.homeProperty.smoothButton(
                model.isPendulum,
                Icons.settings_ethernet_rounded,
              ),
              //child: Icon(Icons.sync_alt),
            ),
            Spacer(flex: 1),
            GestureDetector(
              onTap: () => model.toggleClick(),
              onTapCancel: () => null,
              child: model.homeProperty
                  .smoothButton(model.isClick, Icons.hdr_strong),
              //child: Icon(Icons.keyboard_control_outlined),
            ),
            Spacer(flex: 3),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
