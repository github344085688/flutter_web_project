import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_project/util/screenApdar.dart';
class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2 createState() => _Page2();
}

class _Page2 extends State<Page2> {
  @override
  Widget build(BuildContext context){
    // ScreenApdar.init(context);
    return Scaffold(
        body:Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(ScreenApdar.getScreenWidth().toString()),

        )
    );
  }
}