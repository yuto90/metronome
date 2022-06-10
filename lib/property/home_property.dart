import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeProperty {
  /// 白ベースのWidgetに影をつける\
  /// ※こっちでcolorプロパティ済み
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
}
