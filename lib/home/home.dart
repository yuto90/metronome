import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:metronome/home/rhythm/rhythm.dart';
import 'package:metronome/property/hex.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'footer/footer.dart';
import '../tap/tap.dart';
import 'bpm/bpm.dart';
import 'adsense.dart';
import '../size_config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SizeConfigを初期化
    SizeConfig().init(context);

    // Androidキーボードの閉じるボタンを押した時にフォーカスが外れた判定にする
    var keyboard = KeyboardVisibilityController();
    keyboard.onChange.listen((visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // キーボードを同じレイヤーではなく上端のレイヤーに乗せる設定
        appBar: AppBar(
          title: Text(
            'JustBeat',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: HexColor('#f0f0f0'),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
            return Container(
              color: HexColor('#f0f0f0'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //! ---------------------------------------------------------------
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  Expanded(
                    flex: 3,
                    child: Rhythm(),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: model.isSettings ? 8 : 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                        SizeConfig.blockSizeHorizontal! * 6,
                        SizeConfig.blockSizeVertical! * 1,
                      ),
                      child: BPM(),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  model.isSettings
                      ? Container()
                      : Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              SizeConfig.blockSizeHorizontal! * 2,
                              SizeConfig.blockSizeVertical! * 1,
                              SizeConfig.blockSizeHorizontal! * 2,
                              SizeConfig.blockSizeVertical! * 1,
                            ),
                            child: Tap(),
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
                      child: Footer(),
                    ),
                  ),
                  //! ---------------------------------------------------------------
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockSizeHorizontal! * 2,
                        SizeConfig.blockSizeVertical! * 1,
                        SizeConfig.blockSizeHorizontal! * 2,
                        SizeConfig.blockSizeVertical! * 1,
                      ),
                      child: Adsense(
                        model: model,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
