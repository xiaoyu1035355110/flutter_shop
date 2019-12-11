import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //总数量

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
        cartList[iVal].count++;
        isHave = true;
      }

      iVal++;
    });

    //如果没有进行添加
    if(!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      //将商品转换为CartInfoModel类型
      cartList.add(new CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作
    cartString = json.encode(tempList).toString();
    // print('字符串>>>>>>>>>>>>>>>>> ${cartString}');
    // print('model类型>>>>>>>>>>>>>>>>> ${cartList}');
    prefs.setString('cartInfo', cartString); //进行持久化
    notifyListeners();
  }

  //清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成-----------------------');
    notifyListeners();
  }

  //获取购物车列表
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车商品 这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //把cartList进行初始化防止数据混乱
    cartList = [];
    //判断得到的字符串是否有值,如果不判断会报错
    if(cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      tempList.forEach((item) {
        if (item['isCheck']) {
          //总价格 = 商品总数 * 商品单价
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }
        cartList.add(new CartInfoModel.fromJson(item));
      });
    }
    //改变后通知
    notifyListeners();
  }

  //删除单个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获取本地存储
    cartString = prefs.getString('cartInfo');
    //将本地存储格式转换为List<Map>类型
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    //定义数组下标和删除选项下标
    int itemIndex = 0;
    int delIndex = 0;
    //循环列表
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        //如果id相同当前删除下标等于当前商品下标
        delIndex = itemIndex;
      }
      itemIndex++;
    });
    //当前列表删除当前点击商品
    tempList.removeAt(delIndex);
    //重新将当前列表转化为字符串
    cartString = json.encode(tempList).toString();
    //重新持久化存储
    prefs.setString('cartInfo', cartString);
    //删除完成后重新拉取购物车信息
    await getCartInfo();
  }
}