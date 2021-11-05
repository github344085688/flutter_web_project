import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_web_project/provider/provider_date.dart';
import 'package:flutter_web_project/util/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_project/util/screenApdar.dart';
class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1 createState() => _Page1();
}

class _Page1 extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    final providerCounter = Provider.of<ProviderDate>(context, listen: false).isWeb;
    return Scaffold(
        body: Container(
      height: double.infinity,
      alignment: Alignment.center,
      child:  Container(
        // padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        width: ScreenApdar.percentW(context) * 50,
        height: 100.w,
        color: Colors.green,
        child:  Column(
          children: [
            Builder(
                builder:(BuildContext context)=>  Container(
                  padding: EdgeInsets.all(ScreenApdar.setWidth(10)),
                  // width: ScreenApdar.percentW(context) * 50,
                  width: ScreenApdar.setWidth(100),
                  height: 100.r,
                  color: Colors.deepOrange,
                  child:  Text(
                     '${ScreenApdar.getScreenWidth().toString()}--${ScreenApdar.getScreenHeight().toString()}'
                    // ScreenApdar.percentHs(context).toString(),
                   /* style: TextStyle(
                      color: Colors.white,
                      fontSize:16.sp,
                    ),*/
                  ),
                )
            )
          ],
        ),


     /*   Text(
          'I am a square with a side length of 100',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(12),
          ),
        ),
      ),*/
    )
    )
    );
  }
}
