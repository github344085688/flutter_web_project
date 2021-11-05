import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_project/main_config/keys.dart';
import 'package:flutter_web_project/util/size_config.dart';
import 'package:flutter_web_project/util/screenApdar.dart';
// import 'package:flutter_web_project/util/screen_utils.dart';
import 'package:flutter_web_project/routers/router.dart';
import 'package:flutter_web_project/util/no_animation_transition_delegate.dart';
import 'package:flutter_web_project/page/home_page/bottom_navigation/bottom_navigation_view.dart';
import 'package:flutter_web_project/util/widget_responsive.dart';
import 'package:flutter_web_project/style/style.dart';
import 'package:flutter_web_project/page/home_page/app_bar_widget/app_bar_widge.dart';
import 'package:flutter_web_project/page/home_page/app_bar_widget/web_app_bar_widget.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late int _privatecurrentIndex = 0;
  late int _currentIndex = 0;
  final List<MyPage> _pages = <MyPage>[
    MyPage(
        name: 'MainPage000',
        widget: NavigatorKey.homeRoutes('/index'),
        key: UniqueKey()),
  ];

  void updatePages() {
    _debugCheckDuplicatedPageKeys();
    setState(() {});
  }

  void _debugCheckDuplicatedPageKeys() {
    assert(() {
      final Set<LocalKey> keyReservation = <LocalKey>{};
      for (final Page<dynamic> page in _pages) {
        if (page.key != null) {
          assert(!keyReservation.contains(page.key));
          keyReservation.add(page.key!);
        }
      }
      return true;
    }());
  }

  _conterollercurrentIndex(BuildContext context, int changedIndex) {
    // print(changedIndex);
    // if (_privatecurrentIndex == changedIndex) return;
    switch (changedIndex) {
      case 0:
        {
          if (_pages.length > 1) {
            _pages.removeLast();
            updatePages();
          }
        }
        break;
      case 1:
        {}
        break;
      case 2:
        {
          _pages.removeRange(1, _pages.length);
          /*   _pages.add(
         MyPage(
             name: 'MainPage3',
             widget: InformationPage(),
             key: UniqueKey()),
       );*/

        }
        break;
      case 3:
        {
          /*_pages.add(
         MyPage(
             name: 'MainPage3',
             widget: const TestPage('MainPage3'),
             key: UniqueKey()),
       );*/

        }
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }

    setState(() {
      if (changedIndex == 4 && _privatecurrentIndex != 4) {
        _currentIndex = 1;
      }
      if (changedIndex == 0 && _privatecurrentIndex != 0) _currentIndex = 0;
      _privatecurrentIndex = changedIndex;
      if (_privatecurrentIndex == 3) {
        _privatecurrentIndex = 0;
      }
    });
  }

  int cupertinoTabBarIValue = 0;



  // _buildLargeScreenActions(BuildContext context) {
  //   return
  //
  // }

  double _initBarHeight = 85;
  double _searchRight = 0;
  double _searchButtom = -12.0;
  double _setBarHeight = 57.9;
  double _opacity = 1.0;
  double _toolbarHeight = 85;
  double _appBarOpacity = 1;
  double _expandedHeight = 90;

  void _onSearchButtom() async {
    /*  final String selected = await showSearch<String>(
      context: context,
      delegate: _delegate,
    );
    if (selected != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('You have selected the aaa: $selected'),
        ),
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // ScreenApdar.init(context);
    final _indexNavigatorKey = new NominalKeys();
    bool isWillPop = false;
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await NominalKeys.HomePageKey.currentState!.maybePop();
        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%$isFirstRouteInCurrentTab');
        if (isWillPop) return true;
        if (isFirstRouteInCurrentTab) {
          // Fluttertoast.showToast(msg: '再按一次退出');
          isWillPop = isFirstRouteInCurrentTab;
          return false;
        }
        return false;
      },
      child: Stack(children: [
        Scaffold(
          /*   appBar: WidgetResponsive.isSmallScreen(context)
                    ? null
                    : AppBar(
                  backgroundColor: ComponentStyle.MALL_FOCUS_BG,
                  elevation: 0,
                  title: SelectableText(
                      MediaQuery.of(context).size.width.toString()),
                  actions: _buildLargeScreenActions(context),
                ),*/
          body: Navigator(
            key: NominalKeys.HomePageKey,
            pages: _pages.toList(),
            transitionDelegate: NoAnimationTransitionDelegate(),
            onPopPage: (Route<dynamic> route, dynamic result) {
              print('_pages.length-----**${_pages.length}');
              if (_pages.length > 1) {
                _pages.removeLast();
                updatePages();
                print('_pages._pages-----**${_pages}');
                return route.didPop(result);
              }
              return false;
            },
          ),
          bottomNavigationBar: WidgetResponsive.isSmallScreen(context)
              ? BottomNavigationView(
                  currentIndex: _privatecurrentIndex,
                  setActivity: (currentIndex) =>
                      _conterollercurrentIndex(context, currentIndex))
              : null,
        ),
        WidgetResponsive.isSmallScreen(context)
            ? AppBarWidge(
                setBarHeight: _setBarHeight,
                toolbarHeight: _toolbarHeight,
                searchRight: _searchRight,
                searchButtom: _searchButtom,
                opacity: _opacity,
                expandedHeight: _expandedHeight,
                appBarOpacity: _appBarOpacity,
                onSearchButtom: () => _onSearchButtom())
            : WebPageWidget.WebAppBarWidget(context),
      ]),
    );
  }
}

class MyPage extends Page<void> {
  const MyPage({
    LocalKey? key,
    final String? name,
    required this.widget,
  }) : super(
          name: name,
        );

  final Widget widget;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: this,
      builder: (BuildContext context) => widget,
    );
  }
}
