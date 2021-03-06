import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_project/page/home_page/app_bar_widget/marquee.dart';
import 'package:flutter_web_project/util//screenApdar.dart';
import 'package:flutter_web_project/servers/json_servers.dart' show asset;
import 'package:flutter_web_project/style/style.dart';
// import 'package:flutter_web_project/components/home_search_page.dart';
import 'dart:convert';
import 'package:flutter_web_project/main_config/keys.dart';
class AppBarWidge extends StatefulWidget {
 late double _toolbarHeight;
 late double _searchRight;
 late double _opacity;
 late double _appBarOpacity;
 late final onSearchButtom;

  AppBarWidge({
    Key? key,
    double initBarHeight: 85,
    double setBarHeight: 41,
    double? toolbarHeight,
    double initSsearchRight: 85,
    double searchRight: 0,
    double searchButtom: 4.0,
    double opacity: 1,
    double expandedHeight: 78,
    double appBarOpacity: 1,
    this.onSearchButtom,
  })  : _toolbarHeight = ScreenApdar.setHeight(toolbarHeight!),
        _searchRight = ScreenApdar.setWidth(
            (initBarHeight - toolbarHeight) * 5 < 100
                ? (initBarHeight - toolbarHeight) * 5
                : 100),
        _opacity = opacity,
        _appBarOpacity = appBarOpacity,
        super(key: key);

  @override
  _AppBarWidge createState() => _AppBarWidge();
}

class _AppBarWidge extends State<AppBarWidge>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation _animation;
  List _expandStateList = [];
  // MySearchDelegate _delegate;
  void init() async {
    var setData = await asset.get('assets/json/creads.json');
    setState(() {
      _expandStateList = json.decode(setData);
    });
  }

  @override
  void initState() {
    init();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Color _searchBg = ComponentStyle.TITLE_TEXT_COLOR;
 /*   Color _appBarBg = Color.fromRGBO(
        44,
        52,
        65,
        1); */
    Color _appBarBg = ComponentStyle.MALL_FOCUS_BG;
    // - widget._opacity
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: widget._toolbarHeight,
        // width: double.maxFinite,
        child: Opacity(
          opacity: widget._appBarOpacity,
          child: Container(
            width: double.infinity,
            // color: _appBarBg,
            padding: EdgeInsets.only(
                left: ScreenApdar.setWidth(15),
                right: ScreenApdar.setWidth(15)),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned(
                  // top: -(widget._statusBarHeight),
                  left: ScreenApdar.setWidth(-15),
                  right: ScreenApdar.setWidth(-15),
                  bottom: 0,
                  child: Opacity(
                    opacity: widget._appBarOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: ScreenApdar.setHeight(27),
                  height: ScreenApdar.setHeight(30),
                  child: Opacity(
                    opacity: widget._opacity,
                    child: Image.asset(
                      'assets/images/logo-index2.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: widget._searchRight,
                  bottom: ScreenApdar.setHeight(4),
                  child: Container(
                      height: ScreenApdar.setHeight(27),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: _searchBg,
                          border: Border.all(
                              color: ComponentStyle.AVERAGE_COLOR,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child:FlatButton(
                        child:Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              child: Icon(Icons.search,
                                  size: ScreenApdar.setFontSize(20),
                                  color: ComponentStyle.AVERAGE_COLOR),
                            ),
                          /*  Expanded(
                              flex: 12,
                              child:Container(
                                padding:EdgeInsets.only(top:ScreenApdar.setHeight(3),left:ScreenApdar.setWidth(10) ),
                                child: Marquee(_expandStateList.length-1,
                                        (BuildContext context, int index) {
                                      return Text(_expandStateList[index]['username'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color:  ComponentStyle.LINE_COLOR,
                                              decoration: TextDecoration.none,
                                              fontSize:ScreenApdar.setFontSize(16.0) ));
                                    }),
                              ), */
                              Expanded(
                              flex: 12,
                              child:Container(
                                padding:EdgeInsets.only(top:ScreenApdar.setHeight(3),left:ScreenApdar.setWidth(10) ),
                                child: Text('${widget._searchRight}'),
                              ),


                              /*child: Text('${widget._appBarOpacity}',
                                style: TextStyle(
                                    color:  _iconBgColor,
                                    decoration: TextDecoration.none,
                                    fontSize: 18.0)),*/
                            ),
                            Expanded(
                              child: Icon(Icons.camera_alt,
                                  size: ScreenApdar.setFontSize(20),
                                  color: ComponentStyle.AVERAGE_COLOR),
                            ),
                          ],
                        ),
                        onPressed: () {
                          // widget.onSearchButtom();
                        /*  NoomiKeys.navKey.currentState.pushNamed('/search');*/
                       /*   final String selected = await showSearch<String>(
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
                        },
                      )),
                ),
                Positioned(
                  top: ScreenApdar.setHeight(26),
                  right: ScreenApdar.setWidth(65),
                  height: ScreenApdar.setHeight(30),
                  width: ScreenApdar.setWidth(30),
                  child: Icon(Icons.biotech_rounded,
                      color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)),
                ),
                Positioned(
                  top: ScreenApdar.setHeight(26),
                  right: ScreenApdar.setWidth(40),
                  height: ScreenApdar.setHeight(30),
                  width: ScreenApdar.setWidth(30),
                  child: Icon(Icons.crop_free,
                      color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)),
                ),
                Positioned(
                    top: ScreenApdar.setHeight(26),
                    right: ScreenApdar.setWidth(10),
                    height: ScreenApdar.setHeight(30),
                    width: ScreenApdar.setWidth(30),
                    child: Icon(Icons.message,
                        color: ComponentStyle.AVERAGE_COLOR, size: ScreenApdar.setFontSize(20)))
              ],
            ),
          ),
        )
    );
  }
}
