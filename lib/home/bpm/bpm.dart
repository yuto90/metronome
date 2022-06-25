import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metronome/home/bpm/settings.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import '../home_model.dart';
import 'bpm_model.dart';

class BPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BpmModel>(
      builder: (context, model, child) {
        return Container(
          decoration: model.homeProperty.smooth(),
          child: context.read<HomeModel>().isSettings
              ? Settings(model: model)
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => context.read<BpmModel>().toggleMute(),
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 10,
                              height: SizeConfig.blockSizeVertical! * 3,
                              child: model.isMute
                                  ? Icon(
                                      Icons.volume_up,
                                      color: Colors.blue,
                                    )
                                  : Icon(Icons.volume_off),
                            ),
                          ),
                        ),
                        Text('now BPM'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () =>
                                context.read<HomeModel>().toggleSettings(),
                            onTapCancel: () => null,
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 10,
                              height: SizeConfig.blockSizeVertical! * 3,
                              child: Icon(Icons.settings),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: SizeConfig.blockSizeHorizontal! * 20,
                          height: SizeConfig.blockSizeVertical! * 10,
                          //color: Colors.red,
                          // AbsorbPointer:任意のウィジェットのタッチイベントを有効/無効にできる
                          child: AbsorbPointer(
                            absorbing: context.read<RhythmModel>().run,
                            child: CupertinoPicker(
                              itemExtent: 50,
                              scrollController: FixedExtentScrollController(
                                  initialItem: model.selectedNoteIndex),
                              onSelectedItemChanged: (index) =>
                                  model.pickNote(index),
                              children: model.note
                                  .map((e) => Center(
                                        child: SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal! *
                                                  15,
                                          height:
                                              SizeConfig.blockSizeVertical! * 4,
                                          child: Image.asset(e),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          context.read<BpmModel>().sliderTempo.toString(),
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
                          child: AbsorbPointer(
                            absorbing: context.read<RhythmModel>().run,
                            child: CupertinoPicker(
                              itemExtent: 50,
                              scrollController: FixedExtentScrollController(
                                  initialItem: model.selectedBeatType),
                              onSelectedItemChanged: (index) =>
                                  model.pickBeatType(index),
                              children: model.beatType
                                  .map((e) => Center(
                                        child: SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal! *
                                                  15,
                                          height:
                                              SizeConfig.blockSizeVertical! * 4,
                                          child: Center(child: Text(e)),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(flex: 2),
                    AbsorbPointer(
                      absorbing: context.read<RhythmModel>().run,
                      child: Slider(
                        value: context.read<BpmModel>().sliderTempo.toDouble(),
                        min: 40,
                        max: 200,
                        divisions: 200,
                        label: context.read<BpmModel>().sliderTempo.toString(),
                        onChanged: (double value) {
                          context.read<BpmModel>().changeTempo(value);
                        },
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
        );
      },
    );
  }
}
