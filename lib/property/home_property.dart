import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metronome/home/home_model.dart';
import 'package:metronome/property/color_settings.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import 'hex.dart';

class HomeProperty {
  /// 白ベースのWidgetに影をつける\
  /// ※こっちでcolorプロパティ済み\
  /// @return BoxDecorationプロパティ
  BoxDecoration smooth() {
    return BoxDecoration(
      color: HexColor('#f0f0f0'),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: HexColor('#b6b6b6'),
          offset: Offset(6, 6),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: HexColor('#ffffff'),
          offset: Offset(-6, -6),
          blurRadius: 10,
          spreadRadius: 1,
        )
      ],
    );
  }

  /// smoothスタイルのボタン用のスタイル\
  /// ※こっちでcolorプロパティ済み\
  /// @param bool isButtonTap ボタンがタップされているかフラグ
  /// @param IconData icon ボタンに表示するアイコン
  /// @param BuildContext context コンテキスト（カラー設定取得用）
  /// @return AnimatedContainer
  AnimatedContainer smoothButton(bool isButtonTap, IconData icon, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: SizeConfig.blockSizeHorizontal! * 15,
      height: SizeConfig.blockSizeVertical! * 6,
      child: Icon(
        icon,
        color: isButtonTap ? Colors.black : context.read<ColorSettings>().primaryColor,
      ),
      decoration: BoxDecoration(
        color: HexColor('#f0f0f0'),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isButtonTap
            // ボタンが押されている時
            ? [
                BoxShadow(
                  color: HexColor('#ffffff'),
                  offset: Offset(-6, -6),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: HexColor('#b6b6b6'),
                  offset: Offset(6, 6),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            // ボタンが押されていない時
            : [
                BoxShadow(
                  color: HexColor('#b6b6b6'),
                  offset: Offset(6, 6),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: HexColor('#ffffff'),
                  offset: Offset(-6, -6),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
      ),
    );
  }
}
