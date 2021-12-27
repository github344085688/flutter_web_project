 // part 'js_bridge.dart';
import 'package:flutter_web_project/servers/js_bridge.dart';
import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_web_project/servers/js_bridge.dart' ;
// json
import 'dart:convert';
// 异步 Future
import 'dart:async';
class JsBridgeUtil {
  /// 将json字符串转化成对象
  static JsBridge parseJson(String jsonStr) {
    JsBridge jsBridgeModel = JsBridge.fromMap(jsonDecode(jsonStr));
    return jsBridgeModel;
  }

  /// 向H5开发接口调用
  static executeMethod(context, JsBridge jsBridge) async{

    if (jsBridge.method == 'openWeChatApp') {
      fluwx.openWeChatApp;
      /// 先检测是否已安装微信
      // bool _isWechatInstalled = await fluwx.isWeChatInstalled;
     /* var result = await fluwx.isWeChatInstalled;
      if (result) {

      print('该手机上安装了微信');

      } else {

      print('该手机上未安装微信');

      }*/
      // print("先检测是否已安装微信${_isWechatInstalled}");
  /*    print("先检测是否已安装微信${_isWechatInstalled}");
      if (!_isWechatInstalled) {
        // toast.show(context, '您没有安装微信');
        jsBridge.error.call();
        return;
      }*/
      // fluwx.openWeChatApp;
      // jsBridge.success.call();
    }
  }
}