import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_web_project/provider/provider_date.dart';
import 'package:flutter_web_project/main_config/keys.dart';
import 'package:flutter_web_project/style/style.dart';
import 'package:flutter_web_project/routers/router.dart';
import 'package:flutter_web_project/util/no_splash_factory.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final List<Permission> needPermissionList = [
  Permission.location,
  Permission.storage,
  Permission.phone,
  Permission.camera,
];

class MainConfig extends StatelessWidget {
  final bool? isWeb;
  const MainConfig({Key? key,  this.isWeb}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [ChangeNotifierProvider.value(value: ProviderDate(isWeb:isWeb))],
    child: _InitMainWiget(isWeb:isWeb),
  );
}


class _InitMainWiget extends StatefulWidget {
  final bool? isWeb;
  _InitMainWiget({Key? key,this.isWeb}) : super(key: key);

  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<_InitMainWiget>{

  /*final providerCounter =  Provider.of<ProviderDate>;*/
  @override
  void initState() {
    super.initState();
    if(widget.isWeb == false) _checkPermissions();
  }

  @override
  void reassemble() {
    super.reassemble();
    if(widget.isWeb == false) _checkPermissions();
  }

  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses =
    await needPermissionList.request();
    statuses.forEach((key, value) {
      print('$key ============--------------------- is $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    var  _navigatorKey = NavigatorKey();
    return ScreenUtilInit(
        designSize: Size(1440, 960),
        builder: () => MaterialApp(
          navigatorKey: NominalKeys.MaterialAppKey,
          title: 'My Main App Flutter',
          theme: ThemeData(
            iconTheme: IconThemeData(color: ComponentStyle.PRIMARY_COLOR),
            primaryColor: ComponentStyle.MAIN_COLOR,
            accentColor: ComponentStyle.DIVIDER_COLOR,
            indicatorColor: ComponentStyle.PRIMARY_COLOR,
            dividerColor: ComponentStyle.ACCENT_COLOR,
            splashFactory: const NoSplashFactory(),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: ComponentStyle.INDICATOR_COLOR,fontSize: 16.sp),
                headline6: TextStyle(  color: Colors.green),
                bodyText2: TextStyle(  color: Colors.black54, fontSize: 16.sp),
                overline: TextStyle(  color: Colors.green),
                button: TextStyle(fontSize: 16.sp)
            ),
          ),
          // home: Page1(),
          // routes: _navigatorKey.routes(), //routes优先执行，所以必须注释掉，否则onGenerateRoute方法不会调用
          onGenerateRoute: _navigatorKey.onGenerateRoute,
        )
    );

  }
}
