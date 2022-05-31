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
                'Just Beat',
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
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.white,
                              child: AnimatedAlign(
                                alignment: model.alignment,
                                duration:
                                    Duration(microseconds: model.tempoDuration),
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  color: Colors.black,
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
                                decoration: BoxDecoration(
                                  color: model.nowBeat == 1
                                      ? Colors.blue
                                      : Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: model.nowBeat == 2
                                      ? Colors.blue
                                      : Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: model.nowBeat == 3
                                      ? Colors.blue
                                      : Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: model.nowBeat == 4
                                      ? Colors.blue
                                      : Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Spacer(),
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
                          Spacer(),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: ElevatedButton(
                              child: const Text(
                                'Tap',
                                style: TextStyle(fontSize: 24),
                              ),
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
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white, // Expandedの色
                      child: Row(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              backgroundColor: Colors.blueGrey[100],
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.metronomeReset,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: Icon(Icons.replay, color: Colors.pink),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.toggleMetronome,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: model.run
                                  ? Icon(Icons.stop, color: Colors.white)
                                  : Icon(Icons.play_arrow, color: Colors.white),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              backgroundColor: Colors.blueGrey[100],
                              mini: true, // trueにするととで小さくなる
                              onPressed: model.metronomeReset,
                              elevation: 0, // 通常時のエレベーション
                              hoverElevation: 0, // マウスホバー時のエレベーション
                              highlightElevation: 0, // ボタン押下時のエレベーション
                              child: Icon(Icons.replay, color: Colors.pink),
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
