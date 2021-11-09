import 'package:flutter/material.dart';
import 'package:flutter_web_project/page/page1.dart';
import 'package:flutter_web_project/page/home_page/small_home_init/index.dart';
import 'package:flutter_web_project/page/home_page/home_page.dart';
import 'package:flutter_web_project/util/widget_responsive.dart';

class NavigatorKey {
  NavigatorKey();
  static routes() => {
        // '/': (context) => NewPage(),
        '/': (context) => WidgetResponsive.isSmallScreen(context)
            ? SplashPage()
            : HomePage(),
      '/index': (context) => HomePage(),
       /*
        '/detail': (context, {arguments}) => DetailPage(arguments: arguments),
        '/myMine': (context) => MyMinePage(),
        // '/myMine': (context) => MyMinePage(),
        '/report': (context) => InformationPage(),
        // '/search': (context) => CheckOutPage(),
        '/search': (context) => SearchPage(),
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),*/
        // '/search': (context) => MySearchDelegate(),
        // '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
        // '/classification': (context) => Faxian(),
        // '/new': (context) => NewPage(),
      };
  static homeRoutes(String routerName, {Map? arguments}) {
    switch (routerName) {
      case '/index':
        {
          return WebViewExample();
        }
    }

  }

Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final routes = NavigatorKey.routes();
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments),
            fullscreenDialog: false);
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context),
            maintainState: false);
        return route;
      }
    } else  return routes;
  }
/*

  Route<dynamic> indexNavigatorRouters(RouteSettings settings) {
    final routes = NavigatorKey.homeRoutes();
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments),
            fullscreenDialog: false //是否全屏打开新的路由
            );
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context),
            fullscreenDialog: false //是否全屏打开新的路由
            );
        return route;
      }
    }
  }
}
*/

}
/*

///导航栈的变化监听
class MyNavigator extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    var previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    print('YM----->NavObserverDidPop--Current:' +
        route.settings.name +
        '  Previous:' +
        previousName);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);

    var previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    print('YM-------NavObserverDidPush-Current:' +
        route.settings.name +
        '  Previous:' +
        previousName);
    print(route.settings.name);
    print(route.settings.arguments);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
  }*/
