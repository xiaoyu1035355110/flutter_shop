import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  
  List<BxMallSubDto> childCategoryList = []; //声明一个带有泛型的子类列表
  int childIndex = 0; //子类高亮索引
  String categoryId = "4"; //默认大类id
  String categorySubId = ""; //子类id
  int page = 1; //列表页面, 当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的标识

  //点击大类逻辑
  getChildCategoryList(List<BxMallSubDto> list, String cId) {
    childIndex = 0;//点击大类初始化默认下标
    categoryId = cId; //点击大类传入大类id
    page = 1; //初始化分页
    noMoreText = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list); //当列表改变时赋值给全局管理
    notifyListeners(); //数据改变通知
  }

  changeChildIndex(int index, String subId) {
    page = 1; //初始化分页
    noMoreText = ''; //显示更多的代码
    childIndex = index;
    categorySubId = subId;
    notifyListeners();
  }

  //增加page方法
  addPage() {
    page++;
  }

  //改变noMoreText数据
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}