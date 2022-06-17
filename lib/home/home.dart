import 'package:flutter/material.dart';
import 'package:metronome/home/rhythm/rhythm.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'footer.dart';
import 'tap.dart';
import 'bpm.dart';
import 'adsense.dart';
import '../size_config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Consumer<HomeModel>(builder: (context, model, child) {
        return Container(
          color: Colors.grey[300],
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
                  child: BPM(model: model),
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
                        child: Tap(model: model),
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
                    )),
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
        );
      }),
    );
  }
}
