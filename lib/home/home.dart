import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'home_model.dart';
import 'package:metronome/home/home_part_beat.dart';
import 'package:metronome/home/home_part_footer.dart';
import 'package:metronome/home/home_part_pendulum.dart';
import 'package:metronome/home/home_part_tap.dart';

import 'home_part_bpm.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          // SizeConfigを初期化
          SizeConfig().init(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Just Beat',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.grey[300],
              elevation: 0,
              //backgroundColor: Colors.white,
              //elevation: 6,
              //shadowColor: Colors.grey.shade500,
            ),
            body: Container(
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //! ---------------------------------------------------------------
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  Expanded(
                    flex: 3,
                    child: Padding(
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
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                      ),
                      child: BPM(model: model),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockSizeHorizontal! * 2,
                        SizeConfig.blockSizeVertical! * 1,
                        SizeConfig.blockSizeHorizontal! * 2,
                        SizeConfig.blockSizeVertical! * 1,
                      ),
                      child: Tap(model: model),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                      ),
                      child: Footer(model: model),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
