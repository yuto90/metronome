import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal! * 7,
                  height: SizeConfig.blockSizeVertical! * 3,
                ),
                Spacer(),
                Text('Settings'),
                Spacer(),
                // 設定ボタン
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => model.toggleSettings(),
                      onTapCancel: () => null,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal! * 7,
                        height: SizeConfig.blockSizeVertical! * 3,
                        color: Colors.white,
                        child: Icon(Icons.keyboard_return),
                      ),
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
                  onChanged: (value) => model.togglePendulum(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
