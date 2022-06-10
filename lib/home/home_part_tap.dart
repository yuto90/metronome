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
            // todo もっと直感的に分かりやすくしたい
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 20,
              height: SizeConfig.blockSizeVertical! * 6,
              child: ElevatedButton(
                child: Icon(Icons.settings_ethernet_rounded),
                //child: Icon(Icons.sync_alt),
                style: ElevatedButton.styleFrom(
                  primary: model.isPendulum ? Colors.white : Colors.grey,
                  onPrimary: Colors.black,
                ),
                onPressed: () => model.togglePendulum(),
              ),
            ),
            Spacer(flex: 1),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 20,
              height: SizeConfig.blockSizeVertical! * 6,
              child: ElevatedButton(
                child: Icon(Icons.hdr_strong),
                //child: Icon(Icons.keyboard_control_outlined),
                style: ElevatedButton.styleFrom(
                  primary: model.isClick ? Colors.white : Colors.grey,
                  onPrimary: Colors.black,
                ),
                onPressed: () => model.toggleClick(),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
