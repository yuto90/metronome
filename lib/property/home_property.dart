import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metronome/home/home_model.dart';

import '../size_config.dart';

class HomeProperty {
  /// 白ベースのWidgetに影をつける\
  /// ※こっちでcolorプロパティ済み\
  /// @return BoxDecorationプロパティ
  BoxDecoration smooth() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(6, 6),
          blurRadius: 15,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-6, -6),
          blurRadius: 15,
          spreadRadius: 1,
        )
      ],
    );
  }

  /// smoothスタイルのボタン用のスタイル\
  /// ※こっちでcolorプロパティ済み\
  /// @param bool isButtonTap ボタンがタップされているかフラグ
  /// @param IconData icon ボタンに表示するアイコン
  /// @return AnimatedContainer
  AnimatedContainer smoothButton(bool isButtonTap, IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: SizeConfig.blockSizeHorizontal! * 20,
      height: SizeConfig.blockSizeVertical! * 6,
      child: Icon(
        icon,
        color: isButtonTap ? Colors.black : Colors.blue,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isButtonTap ? Colors.grey.shade200 : Colors.grey.shade300,
        ),
        boxShadow: isButtonTap
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(6, 6),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-6, -6),
                  blurRadius: 15,
                  spreadRadius: 1,
                )
              ],
      ),
    );
  }
}
