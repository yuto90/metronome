import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'bpm_model.dart';
import '../../l10n/app_localizations.dart';

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
                  title: Text(AppLocalizations.of(context)!.option_beat),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isPendulum,
                  onChanged: (value) => model.togglePendulum(context),
                ),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.option_pendulum),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isClick,
                  onChanged: (value) => model.toggleClick(context),
                ),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.option_change_beat),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: model.isAccent,
                  onChanged: (value) => model.checkAccent(),
                ),
                CheckboxListTile(
                  title:
                      Text(AppLocalizations.of(context)!.option_just_vibration),
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
