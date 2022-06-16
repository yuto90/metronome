import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metronome/home/home_model.dart';
import '../size_config.dart';

class BPM extends StatelessWidget {
  const BPM({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: model.homeProperty.smooth(),
      child: Column(
        children: [
          Spacer(flex: 5),
          Text('now BPM'),
          Row(
            children: [
              Spacer(),
              Container(
                width: SizeConfig.blockSizeHorizontal! * 20,
                height: SizeConfig.blockSizeVertical! * 10,
                //color: Colors.red,
                child: CupertinoPicker(
                  itemExtent: 50,
                  //scrollController: FixedExtentScrollController(initialItem: 0),
                  onSelectedItemChanged: (index) => model.pickNote(index),
                  children: model.note
                      .map((e) => Center(
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 15,
                              height: SizeConfig.blockSizeVertical! * 4,
                              child: Image.asset(e),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Spacer(),
              Text(
                model.sliderTempo.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical! * 6,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Container(
                width: SizeConfig.blockSizeHorizontal! * 20,
                height: SizeConfig.blockSizeVertical! * 10,
                //color: Colors.red,
                child: CupertinoPicker(
                  itemExtent: 50,
                  onSelectedItemChanged: (index) => model.pickBeatType(index),
                  children: model.beatType
                      .map((e) => Center(
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 15,
                              height: SizeConfig.blockSizeVertical! * 4,
                              child: Center(child: Text(e)),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(flex: 2),
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
          Spacer(flex: 1),
        ],
      ),
    );
  }
}