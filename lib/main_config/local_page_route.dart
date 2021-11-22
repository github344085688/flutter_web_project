import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalPageRoute extends Page<void> {
  const LocalPageRoute({
    LocalKey? key,
    final String? name,
    required this.widget,
  }) : super(
    name: name,
  );

  final Widget widget;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute <void>(
      settings: this,
      builder: (BuildContext context) => widget,
    );
  }
}
