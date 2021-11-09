import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_web_project/main_config/main_config.dart';
import 'package:flutter/foundation.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) _configPlatform();
  runApp(MainConfig());
}

void _configPlatform() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemChrome.setSystemUIOverlayStyle(await SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark));
    }
  }
}

/*  bool isWeb;
   if ((defaultTargetPlatform == TargetPlatform.iOS) || (defaultTargetPlatform == TargetPlatform.android)) {
     await SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown
     ]);
     if (Platform.isAndroid) {
       // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
       SystemChrome.setSystemUIOverlayStyle(
           await SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark));
     }
     isWeb = false;
   }
   else if ((defaultTargetPlatform == TargetPlatform.linux) || (defaultTargetPlatform == TargetPlatform.macOS) || (defaultTargetPlatform == TargetPlatform.windows)) {
     // Some desktop specific code there
     isWeb = true;
   }
   else {
     // Some web specific code there
   }*/