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
            //Spacer(),
            //GestureDetector(
            //onTap: () => model.togglePendulum(context),
            //onTapCancel: () => null,
            //child: model.homeProperty.smoothButton(
            //model.isPendulum,
            //Icons.settings_ethernet_rounded,
            //),
            ////child: Icon(Icons.sync_alt),
            //),
            //Spacer(),
            //GestureDetector(
            //onTap: () => model.toggleClick(context),
            //onTapCancel: () => null,
            //child: model.homeProperty
            //.smoothButton(model.isClick, Icons.hdr_strong),
            ////child: Icon(Icons.keyboard_control_outlined),
            //),
            Spacer(),
          ],
        );
      },
    );
  }
}
