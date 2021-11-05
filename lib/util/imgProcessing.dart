import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
class ImgProcessing {
  static svgPictureAsset({required String url, Color? svgColor, width , height}) {
    return new SvgPicture.asset(
      url,
      color: svgColor??svgColor,
      width: width ?? width,
      height: height ?? height,
    );
  }
  static svgbannerBg(String svgUrl, Color color) {
    return SvgPicture.asset(
      svgUrl,
      color: color,
    );
  }
}
