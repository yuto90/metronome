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
        SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 50,
          height: SizeConfig.blockSizeVertical! * 20,
          child: ElevatedButton(
            child: Text(
              'Tap',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical! * 3,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: model.isJustBeat ? Colors.green[200] : Colors.white,
              onPrimary: Colors.black,
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: () => model.tap(),
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
