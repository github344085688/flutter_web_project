import 'package:flutter/material.dart';
import 'package:flutter_web_project/style/style.dart';
import 'package:flutter_web_project/util/imgProcessing.dart';
import 'package:flutter_web_project/util/ScreenApdar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebPageWidget {
  static List<String?> navList = ['Quotes', 'Shipments', 'Bill of lading'];

  static Widget _buildNav(BuildContext context,String title) =>Container(
    // margin: EdgeInsets.only(right:0.sp),
    padding: EdgeInsets.only(left: 10.sp,right: 20.sp),
    child:  MaterialButton(
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      height: 50.0,
      child: Text(
        title,
      ),
      onPressed: () {
        // homeBloc.changeSelectedDrawerIndex(0);
      },
    )

  );

  static WebAppBarWidget(BuildContext context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: 60.sp,
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient( //背景径向渐变
              colors: [Color.fromRGBO(248, 249, 249, 1),Color.fromRGBO(241, 242, 243, 1)],
              center: Alignment.topLeft,
              radius: .98,
            ),
            // color: ComponentStyle.MAIN_COLOR,
            border: Border(
                top: BorderSide(
                    color: ComponentStyle.ACCENT_COLOR,
                    width: 3.sp,
                    style: BorderStyle.solid)),
            boxShadow: [ComponentStyle.under_shadow()],
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                ),
              ),
              Container(
                // width: ScreenApdar.conversionPercentage(context,0.08),
                child: ImgProcessing.svgPictureAsset(
                    url: 'assets/images/unis-logo-color.svg',
                    width:110.sp
                ),
              ),
              Container(
                child: Container(
                  height: double.infinity,
                  // color: Colors.blue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        navList.map<Widget>((e) => _buildNav(context,e!)).toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                ),
              )
            ],
          ),
        ),
      );
}
