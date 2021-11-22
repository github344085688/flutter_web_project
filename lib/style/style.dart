import 'package:flutter/material.dart';

class ComponentStyle {
  static const LINE_COLOR  = const Color(0xFFffffff);
  static const MAIN_COLOR = const Color(0xFFF8F9F9);
  static const AVERAGE_COLOR  = const Color(0xFFe8f5e9);
  static const TITLE_TEXT_COLOR = const Color(0xFF28553f);
  static const DIVIDER_COLOR = const Color(0xFFA4AFB7);
  static const MALL_FOCUS_BG = const Color(0xFF0f4229);
  static const ACCENT_COLOR = const Color(0xFFF48225);
  static const PRIMARY_COLOR = const Color(0xFFAD877A);
  static const INDICATOR_COLOR = const Color(0xFF0f4229);

  /*static const FOOT_TEXT_COLOR = const Color(0xFF07100b);
  static const UNDER_LINE_COLOR = const Color(0xFF07100b);
  static const DIVIVIDING_LINE_COLOR = const Color(0xFF07100b);
  static const APP_MAIN_COLOR = const Color(0xFF00BCBC);
  static const MALL_FOCUS_BG = const Color(0xFF07100b);*/
  static BoxShadow under_shadow()=>BoxShadow(
      color: INDICATOR_COLOR,
      offset: Offset(0.0, 1.0), //阴影xy轴偏移量
      blurRadius: 10.0, //阴影模糊程度
      spreadRadius: -10.0 //阴
  );
}
