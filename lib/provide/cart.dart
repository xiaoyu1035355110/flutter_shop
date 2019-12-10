import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";

  save(goodsId, goodsName, count, price, images) async {
    //初始化持久化配置
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获取持久化存储值
    cartString = prefs.getString('cartInfo');
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList = (temp as List).cast();

    bool isHave = false; //判断商品是否已经添加
    int iVal = 0; //用于进行循环的数组索引

    tempList.forEach((item) {
      //循环商品列表判断商品是否存在
      if (item['goodsId'] == goodsId) {
        //如果存在，数量进行+1操作
        tempList[iVal]['count'] = item['count'] + 1;
        isHave = true;
      }

      iVal++;
    });

    //如果没有进行添加
    if(!isHave) {
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'iamges': images
      });
    }

    //把字符串进行encode操作
    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString); //进行持久化
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成-----------------------');
    notifyListeners();
  }
}