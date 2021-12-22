import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_web_project/page/home_page/two_level_widget.dart';
import 'package:flutter_web_project/page/home_page/app_bar_widget/app_bar_widge.dart';
import 'package:flutter_web_project/routers/router.dart';
import 'package:flutter_web_project/bus_events/bus_events.dart' show RefreshWeb,eventBus,RefreshWebFinished;
import 'package:event_bus/event_bus.dart';
import 'package:flutter_web_project/style/style.dart';
import 'package:flutter_web_project/util/screenApdar.dart';

class InitHomePage extends StatefulWidget {
  late double _appBarHeight;

  InitHomePage({
    Key? key,
    double appBarHeight: 90,
  })  : _appBarHeight = appBarHeight,
        super(key: key);

  @override
  _InitHomePage createState() => _InitHomePage();
}

class _InitHomePage extends State<InitHomePage> with TickerProviderStateMixin {
 late double _initBarHeight = 85;
 late  double _searchRight = 0;
 late  double _searchButtom = -12.0;
 late  double _setBarHeight = 57.9;
 late  double _opacity = 1.0;
 late  double _toolbarHeight = 85;
 late  double _appBarOpacity = 1;
 late  double _expandedHeight = widget._appBarHeight;
 late  int currentIndex = 0;
 late  int _swiperChangedIndex = 0;
 late  bool _isPhysics = false;
 late  bool _isScroll = false;
 late  SystemUiOverlayStyle _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
 late  List _expandStateList = [];
 late  var homeComponents;
 late  ScrollController _scrollController = new ScrollController();
 late  RefreshController _refreshController = RefreshController();
 late  GlobalKey _contentKey = GlobalKey();


 late  int _recordwiperSIndex = 0;
 late  AnimationController animationController;
 late  Animation<Color> color;

 late  bool _refreshWebFinished = false;



  void init() async {
    eventBus.on<RefreshWebFinished>().listen((event) {
      final _isFinished = event.isFinished;
      setState(() {
        _refreshWebFinished= _isFinished;
      });
    });
    // var setData = await asset.get('assets/json/creads.json');
    setState(() {
      // _expandStateList = json.decode(setData);
    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 2000));
    // var getData = await asset.get('assets/json/potos.json');
    if (mounted)
      setState(() {
        // _expandStateList.addAll(json.decode(getData));
      });
    _refreshController.loadComplete();
  }

  void _fuRefreshController() {
    _refreshController.headerMode!.addListener(() {
      if (_refreshController.headerMode!.value == RefreshStatus.idle) {
        setState(() {});
        Future.delayed(const Duration(milliseconds: 20)).then((value) {
          setState(() {});
        });
      }
    });
  }

  void _onRefresh() async {

    setState(() {
      _isPhysics = true;
    });
     eventBus.fire(RefreshWeb(true));
     // Timer t = Timer(Duration(milliseconds: 4000));
     if (_refreshWebFinished) {
       print('----------------------_onRefresh');
       _isPhysics = false;
       _refreshController.refreshCompleted();
     }else{
       await Future.delayed(Duration(milliseconds: 4000));
       print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
       _isPhysics = false;
       _refreshController.refreshCompleted();
     }
  }

  void _onTwoLevel() {
    print('-------on');
    setState(() {
      _appBarOpacity = 0;
    });
  }

  void _onOffsetChange(isBool, distance) {
    if (isBool && distance >= 0) {
      var appBarOpacity = 1 - (distance * 2.8).round() / 100;
      setState(() {
        _appBarOpacity = appBarOpacity as double > 0 ? appBarOpacity as double  : 0;
        if (_isScroll && distance < 50) _scrollController.jumpTo(0.0 - 0.0);
      });
    }
    if (distance > 130) _isScroll = false;
  }

  void _funScrollController() {
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      if (_scrollController.offset >= 0 && _scrollController.offset < 19) {
        setState(() {
          _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        });
      }
      if (_scrollController.offset >= 0 && _scrollController.offset > 19) {
        _systemUiOverlayStyle = SystemUiOverlayStyle.light;
      }
      if (_scrollController.offset > 34) {
        setState(() {
          _toolbarHeight = _setBarHeight;
        });
      }
      if (_scrollController.offset >= 0 && _scrollController.offset < 34) {
        setState(() {
          // _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          _toolbarHeight = _initBarHeight - _scrollController.offset * 0.8;
          // print(_toolbarHeight);
          _opacity = (100 - _scrollController.offset * 2.5).round() / 100;
        });
      } else if (_scrollController.offset > 30) {
        setState(() {
          // _systemUiOverlayStyle = SystemUiOverlayStyle.light;
          _opacity = 0.0;
        });
      }
      if (_toolbarHeight < 85) _isScroll = true;
      if (_toolbarHeight == 85) _isScroll = false;

      // if (_scrollController.offset == 0 && _isRefresh) _appBarOpacity = 1;
    });
  }

 // late MySearchDelegate _delegate;


  @override
  void initState() {
    init();

    // _delegate = MySearchDelegate();
    // homeComponents = HomeComponents(context:context);
    _fuRefreshController();
    _funScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _refreshController.position!.jumpTo(0);
      setState(() {});
    });

    super.initState();
  }

  Widget _getScrollWidget() {
    return Builder(
        builder: (BuildContext context) => RefreshConfiguration.copyAncestor(
          context: context,
          enableScrollWhenTwoLevel: true,
          maxOverScrollExtent: 120,
          enableLoadingWhenFailed: false,
          maxUnderScrollExtent: 0,
          footerTriggerDistance: 0,
          child: LayoutBuilder(
            builder: (_, c) {
              return SmartRefresher(
                key: _contentKey,
                controller: _refreshController,
                enableTwoLevel: true,
                enablePullDown: true,
                enablePullUp: false,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                onTwoLevel: _onTwoLevel,
                onOffsetChange: _onOffsetChange,
                child: _customScrollView(),
              );
            },
          ),
        ));
  }

  Widget _customScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      physics: _isPhysics
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return NavigatorKey.homeRoutes('/webViewPage');
              },
              childCount: 1,
            )),
      ],
    );
  }
  void _onSearchButtom() async{
    /*final String selected = await showSearch<String>(
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _systemUiOverlayStyle,
        child: RefreshConfiguration(
            dragSpeedRatio: 0.91,
            enableScrollWhenTwoLevel: true,
            maxOverScrollExtent: 120,
            footerTriggerDistance: -80,
            maxUnderScrollExtent: 60,
            enableLoadingWhenNoData: false,
            enableRefreshVibrate: false,
            enableLoadMoreVibrate: false,
            shouldFooterFollowWhenNotFull: (state) {
              print('111111111');
              return false;
            },
            footerBuilder: () => ClassicFooter(),
            headerBuilder: () => TwoLevelHeader(
              textStyle: TextStyle(color: Colors.white),
              displayAlignment: TwoLevelDisplayAlignment.fromTop,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/secondfloor.jpg"),
                    fit: BoxFit.fitWidth,
                    // 很重要的属性,这会影响你打开二楼和关闭二楼的动画效果
                    alignment: Alignment.topCenter),
              ),
              twoLevelWidget: TwoLevelWidget(setActivity: () {
                 print('wwwwwwwwwwww');
              }),
            ),
            /*    headerBuilder:(BuildContext context)=>,*/

            child: Stack(
              children: [
                Scaffold(
                  // backgroundColor: Color(0x00000000),
                  body: _getScrollWidget(),
                ),
                AppBarWidge(
                    setBarHeight: _setBarHeight,
                    toolbarHeight: _toolbarHeight,
                    searchRight: _searchRight,
                    searchButtom: _searchButtom,
                    opacity: _opacity,
                    expandedHeight: _expandedHeight,
                    appBarOpacity: _appBarOpacity,
                    onSearchButtom:() =>
                        _onSearchButtom()
                )
              ],
            )));
  }
  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
