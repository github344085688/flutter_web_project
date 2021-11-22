import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_web_project/util/screenApdar.dart';
import 'package:flutter_web_project/servers/js_bridge_util.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  late WebViewController _controller;
  String _title = "webview";
  late double _height = 0;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: _height,
        width: double.infinity,
        child: WebView(
          initialUrl: 'http://192.168.1.115:3000',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            print("高度 ssssssssssssssss");
            _controller.evaluateJavascript("document.body.clientHeight").then((result) {
              setState(() {
                _title = result;
                _height = double.parse(result);
                print("高度${double.parse(result)}");
              });
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>[
            // _alertJavascriptChannel(context),
            _JsBridge(context),
          ].toSet(),
        )
    );
  }

  NavigationRequest _navigationDelegate(
      BuildContext context, NavigationRequest request, NavigationDecision) {
    if (request.url.startsWith('js://webview')) {
      // showToast('JS调用了Flutter By navigationDelegate');
      print('blocking navigation to $request}');
      // Navigator.push(context, new MaterialPageRoute(builder: (context) => new testNav()));
      return NavigationDecision.prevent;
    }
    print('allowing navigation to $request');
    return NavigationDecision.navigate; //必须有
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: "appobject",
        onMessageReceived: (JavascriptMessage message) {
          print("参数： ${message.message}");
          String callbackname = message.message; //实际应用中要通过map通过key获取
          String data = "收到消息调用了";
          String script = "$callbackname($data)";
          _controller
              .evaluateJavascript('flutterCallJsMethod("msg from flutter")');
          /*  _controller.evaluateJavascript(script).then((result){
                      _controller.evaluateJavascript('flutterCallJsMethod("msg from flutter")');
                    });*/
          // _controller.evaluateJavascript(script);
        });
  }

  JavascriptChannel _JsBridge(BuildContext context) => JavascriptChannel(
      name: 'appobject', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage msg) async {
        String jsonStr = msg.message;
        print(
            'JsBridgeUtil.parseJson(jsonStr)${JsBridgeUtil.parseJson(jsonStr)}');
        JsBridgeUtil.executeMethod(context, JsBridgeUtil.parseJson(jsonStr));
        _controller.evaluateJavascript(
            'flutterCallJsMethod(${JsBridgeUtil.parseJson(jsonStr)})');
      });
}
