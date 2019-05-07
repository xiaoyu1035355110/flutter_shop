import 'package:flutter/material.dart';

class Counter with ChangeNotifier {

  int value = 0;

  increment() {
    value++;
    notifyListeners(); //通知监听器数据发生变化
  }

}