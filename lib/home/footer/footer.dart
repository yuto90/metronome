import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import '../home_model.dart';
import 'footer_model.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FooterModel>(
      builder: (context, model, child) {
        return Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: () => model.toggleMute(),
              onTapCancel: () => null,
              child: model.homeProperty.smoothButton(
                model.isMute,
                Icons.volume_off,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => context.read<RhythmModel>().toggleMetronome(context),
              onTapCancel: () => null,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
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
                        ? Colors.grey.shade300
                        : Colors.grey.shade200,
                  ),
                  boxShadow: context.read<RhythmModel>().run
                      ? [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(-6, -6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
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
              onTap: () => context.read<HomeModel>().toggleSettings(),
              onTapCancel: () => null,
              child: model.homeProperty.smoothButton(
                context.read<HomeModel>().isSettings,
                Icons.settings,
              ),
            ),
            Spacer(),
          ],
        );
      },
    );
  }
}
