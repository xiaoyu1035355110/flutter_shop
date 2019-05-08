import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  
  List<BxMallSubDto> childCategoryList = []; //声明一个带有泛型的子类列表

  getChildCategoryList(List<BxMallSubDto> list) {
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list); //当列表改变时赋值给全局管理
    notifyListeners(); //数据改变通知
  }
}