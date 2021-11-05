import 'package:flutter/cupertino.dart';

class ProviderDate with ChangeNotifier {
  final int? count;
  final bool? isWeb;
  ProviderDate({this.count,this.isWeb});

  // void add() {
  //   _count++;
// 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
  //   notifyListeners(); //2
  // }

   // get count => count;
   // get isWeb => isWeb;
}
