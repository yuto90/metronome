import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'home_model.dart';
import 'package:metronome/home/home_part_beat.dart';
import 'package:metronome/home/home_part_footer.dart';
import 'package:metronome/home/home_part_pendulum.dart';
import 'package:metronome/home/home_part_tap.dart';

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
              backgroundColor: Colors.grey[200],
              elevation: 0,
            ),
            body: Container(
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, // Expandedの色
                        ),
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
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, // Expandedの色
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              'now BPM',
                            ),
                            Center(
                              child: Text(
                                model.sliderTempo.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical! * 6,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Slider(
                              value: model.sliderTempo.toDouble(),
                              min: 40,
                              max: 200,
                              divisions: 200,
                              label: model.sliderTempo.toString(),
                              onChanged: (double value) {
                                model.changeTempo(value);
                              },
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, // Expandedの色
                        ),
                        child: Tap(model: model),
                      ),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, // Expandedの色
                        ),
                        child: Footer(model: model),
                      ),
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
