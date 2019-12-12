import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;

  //改变首页导航切换下标
  changIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}