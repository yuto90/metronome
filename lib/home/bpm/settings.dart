import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../../property/color_settings.dart';
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
            child: Consumer<ColorSettings>(
              builder: (context, colorSettings, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.grey,
                    checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return null;
                        }
                        if (states.contains(MaterialState.selected)) {
                          return colorSettings.primaryColor;
                        }
                        return null;
                      }),
                      checkColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  child: ListView(
                    children: [
                      // Color picker section
                      ListTile(
                        title: Text('Color Theme'),
                        subtitle: Text('Tap to change app color'),
                        leading: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: colorSettings.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        onTap: () => _showColorPicker(context, colorSettings),
                      ),
                      Divider(),
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
                        title:
                            Text(AppLocalizations.of(context)!.option_change_beat),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: model.isAccent,
                        onChanged: (value) => model.checkAccent(),
                      ),
                      CheckboxListTile(
                        title: Text(
                            AppLocalizations.of(context)!.option_just_vibration),
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
                );
              },
            ),
          ),
          Text('Version 1.0'),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context, ColorSettings colorSettings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: colorSettings.primaryColor,
              onColorChanged: (Color color) {
                colorSettings.setPrimaryColor(color);
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
