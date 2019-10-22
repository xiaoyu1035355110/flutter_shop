import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  
  List<BxMallSubDto> childCategoryList = []; //声明一个带有泛型的子类列表
  int childIndex = 0; //子类高亮索引
  String categoryId = "4"; //默认大类id

  //点击大类逻辑
  getChildCategoryList(List<BxMallSubDto> list, categoryId) {
    childIndex = 0;//点击大类初始化默认下标
    categoryId = categoryId; //点击大类传入大类id
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list); //当列表改变时赋值给全局管理
    notifyListeners(); //数据改变通知
  }

  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}