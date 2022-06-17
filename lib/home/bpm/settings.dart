import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:metronome/home/rhythm/rhythm_model.dart';
import 'package:provider/src/provider.dart';
import '../../size_config.dart';
import '../home_model.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.model}) : super(key: key);

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 10,
                    height: SizeConfig.blockSizeVertical! * 3,
                  ),
                ),
                Text('Settings'),
                // 設定ボタン
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => model.toggleSettings(),
                    onTapCancel: () => null,
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 10,
                      height: SizeConfig.blockSizeVertical! * 3,
                      child: Icon(Icons.keyboard_return),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical! * 38,
            child: ListView(
              children: [
                // todo 別ファイルに切り分け
                CheckboxListTile(
                  title: Text('バックグラウンドで再生する'),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: true,
                  onChanged: (value) =>
                      context.read<RhythmModel>().togglePendulum(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
