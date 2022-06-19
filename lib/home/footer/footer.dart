import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'footer_model.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FooterModel>(
      builder: (context, model, child) {
        return Row(
          children: [
            Spacer(),
            // 音量ミュートボタン
            GestureDetector(
              onTap: () => context.read<FooterModel>().toggleMute(),
              onTapCancel: () => null,
              child: model.homeProperty.smoothButton(
                context.read<FooterModel>().isMute,
                Icons.volume_off,
              ),
            ),
            Spacer(),
            // 設定リセットボタン
            GestureDetector(
              // Widgetを押した時
              onTapDown: (_) => model.homeModel.displayReset(context),
              // Widgetを離した時
              onTapUp: (_) => model.tapUpReset(),
              // Widgetを押している最中に指が範囲外に出た時
              //onTapCancel: () => model.tapUp(),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: SizeConfig.blockSizeHorizontal! * 15,
                height: SizeConfig.blockSizeVertical! * 6,
                child: Icon(Icons.replay, color: Colors.blue),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: model.isReset
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  boxShadow: model.isReset
                      ? [
                          // ボタン押下時は影を無くす
                        ]
                      : [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
                        ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => context.read<RhythmModel>().toggleMetronome(context),
              onTapCancel: () => null,
              //child:
              //model.homeProperty.smoothButton(model.isMute, Icons.play_arrow),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: SizeConfig.blockSizeHorizontal! * 20,
                height: SizeConfig.blockSizeVertical! * 7,
                child: Icon(
                  context.read<RhythmModel>().run
                      ? Icons.stop
                      : Icons.play_arrow,
                  size: SizeConfig.blockSizeVertical! * 4,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.read<RhythmModel>().run
                        ? Colors.grey.shade200
                        : Colors.grey.shade300,
                  ),
                  boxShadow: context.read<RhythmModel>().run
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
                        ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => model.togglePendulum(context),
              onTapCancel: () => null,
              child: model.homeProperty.smoothButton(
                model.isPendulum,
                Icons.settings_ethernet_rounded,
              ),
              //child: Icon(Icons.sync_alt),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => model.toggleClick(context),
              onTapCancel: () => null,
              child: model.homeProperty
                  .smoothButton(model.isClick, Icons.hdr_strong),
              //child: Icon(Icons.keyboard_control_outlined),
            ),
            Spacer(),
          ],
        );
      },
    );
  }
}