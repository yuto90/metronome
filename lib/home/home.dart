import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('metronome'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'ステップ: ',
                      ),
                      Container(
                        height: 70,
                        width: 50,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          children: List.generate(
                              10,
                              (i) => model
                                  .cupertinoPickerChild((i + 1).toString())),
                          scrollController: FixedExtentScrollController(
                              initialItem: model.stepSize - 1),
                          onSelectedItemChanged: (int value) {
                            model.hoge(value);
                          },
                        ),
                      ),
                      Text(
                        'BPM',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(),
                      Text(
                        '長さ: ',
                      ),
                      Container(
                        height: 70,
                        width: 50,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          children: List.generate(
                              20,
                              (i) => model
                                  .cupertinoPickerChild((i + 1).toString())),
                          scrollController: FixedExtentScrollController(
                              initialItem: model.bar - 1),
                          onSelectedItemChanged: (int value) {
                            model.hoge2(value);
                          },
                        ),
                      ),
                      Text(
                        '小節',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(),
                    ],
                  ),
                  Container(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'スタート: ',
                      ),
                      Container(
                        height: 70,
                        width: 50,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          children: List.generate(
                              200,
                              (i) => model
                                  .cupertinoPickerChild((i + 1).toString())),
                          scrollController: FixedExtentScrollController(
                              initialItem: model.startTempo - 1),
                          onSelectedItemChanged: (int value) {
                            model.hoge3(value);
                          },
                        ),
                      ),
                      Text(
                        'BPM',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(),
                      Text(
                        'エンド: ',
                      ),
                      Container(
                        height: 70,
                        width: 50,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          children: List.generate(
                              200,
                              (i) => model
                                  .cupertinoPickerChild((i + 1).toString())),
                          scrollController: FixedExtentScrollController(
                              initialItem: model.maxTempo - 1),
                          onSelectedItemChanged: (int value) {
                            model.hoge4(value);
                          },
                        ),
                      ),
                      Text(
                        'BPM',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(),
                    ],
                  ),
                  Container(height: 90),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        '残り' + model.remainBeat.toString() + '拍',
                        style: TextStyle(fontSize: 30),
                      ),
                      Spacer(),
                    ],
                  ),
                  Container(height: 10),
                  Text(
                    'now BPM',
                  ),
                  Text(
                    model.tempo.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Slider(
                    value: model.tempo.toDouble(),
                    min: 1,
                    max: 200,
                    divisions: 200,
                    label: model.tempo.toString(),
                    onChanged: (double value) {
                      model.hoge5(value);
                    },
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: model.hoge6,
                        child: Text(
                          'RESET',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, //ボタンの背景色
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: model.toggleMetronome,
                        child: Text(
                          model.run ? 'STOP' : 'GO',
                          style: TextStyle(
                            color: model.run ? Colors.blue : Colors.orange,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, //ボタンの背景色
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
