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
              title: Text(
                'Metronome',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.red,
                              child: AnimatedAlign(
                                alignment: model.alignment,
                                duration:
                                    Duration(microseconds: model.tempoDuration),
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                color: model.nowBeat == 1
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                color: model.nowBeat == 2
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                color: model.nowBeat == 3
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                color: model.nowBeat == 4
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.yellow, // Expandedの色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'now BPM',
                          ),
                          Center(
                            child: Text(
                              model.tempo.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Slider(
                            value: model.tempo.toDouble(),
                            min: 1,
                            max: 200,
                            divisions: 200,
                            label: model.tempo.toString(),
                            onChanged: (double value) {
                              model.changeTempo(value);
                            },
                          ),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton(
                                onPressed: model.metronomeReset,
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
                                  model.run ? 'STOP' : 'START',
                                  style: TextStyle(
                                    color:
                                        model.run ? Colors.blue : Colors.orange,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white, //ボタンの背景色
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ElevatedButton(
                              child: const Text('Tap'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: const CircleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              onPressed: () => model.tap(),
                            ),
                          ),
                          Spacer(),
                        ],
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
