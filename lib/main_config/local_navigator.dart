import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_project/main_config/keys.dart';
import 'package:flutter_web_project/util/size_config.dart';
import 'package:flutter_web_project/main_config/local_page_route.dart';
import 'package:flutter_web_project/routers/router.dart';
import 'package:flutter_web_project/util/no_animation_transition_delegate.dart';

class LocalNavigator extends StatefulWidget {
  const LocalNavigator({Key? key}) : super(key: key);

  @override
  _LocalNavigator createState() => _LocalNavigator();
}

class _LocalNavigator extends State<LocalNavigator> {

  final List<LocalPageRoute> _pages = <LocalPageRoute>[
    LocalPageRoute(
        name: 'LocalPageRoute',
        widget: NavigatorKey.homeRoutes('/index'),
        key: UniqueKey()),
  ];

  void _updatePages() {
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
      child:Scaffold(
        body: Navigator(
          key: NominalKeys.HomePageKey,
          pages: _pages.toList(),
          transitionDelegate: NoAnimationTransitionDelegate(),
          onPopPage: (Route<dynamic> route, dynamic result) {
            print('_pages.length-----**${_pages.length}');
            if (_pages.length > 1) {
              _pages.removeLast();
              _updatePages();
              print('_pages._pages-----**${_pages}');
              return route.didPop(result);
            }
            return false;
          },
        ),
      )
    );
  }
}