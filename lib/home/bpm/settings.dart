import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../size_config.dart';
import '../home_model.dart';
import 'bpm_model.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.model}) : super(key: key);

  final BpmModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                  child: Text('Option'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical! * 35,
            child: ListView(
              children: [
                // todo 別ファイルに切り分け
                CheckboxListTile(
                  title: Text('拍数を非表示にする'),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isPendulum,
                  onChanged: (value) => model.togglePendulum(context),
                ),
                CheckboxListTile(
                  title: Text('振り子を非表示にする'),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isClick,
                  onChanged: (value) => model.toggleClick(context),
                ),
                CheckboxListTile(
                  title: Text('最後の拍で音を変える'),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isAccent,
                  onChanged: (value) => model.checkAccent(),
                ),
                CheckboxListTile(
                  title: Text('ジャストタイミングでタップした時にバイブを鳴らす'),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isVibration,
                  onChanged: (value) => model.checkVibration(),
                ),
                ////* ジャスト判定可視化(デバッグオプション)
                //CheckboxListTile(
                //title: Text('ジャストタイミングの範囲を可視化する'),
                //controlAffinity: ListTileControlAffinity.leading,
                //value: model.isJustZone,
                //onChanged: (value) => model.checkJustZone(context),
                //),
              ],
            ),
          ),
          Text('Version 1.0'),
        ],
      ),
    );
  }
}
