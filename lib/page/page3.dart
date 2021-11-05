import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3 createState() => _Page3();
}

class _Page3 extends State<Page3> {
  @override
  Widget build(BuildContext context) =>  Scaffold(
      body:Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('_Page3'),

      )

  );
}