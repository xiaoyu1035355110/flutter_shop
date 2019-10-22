import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}


class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int listIndex = 0;

  @override

  void initState() {
    _getCategory();
    super.initState();
  }

  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());

      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategoryList(list[0].bxMallSubDto); 
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }
  
  //左侧分类单独项
  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (listIndex == index) ? true : false; 

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;//获取当前一级分类下的二级列表
        Provide.value<ChildCategory>(context).getChildCategoryList(childList); //修改二级分类的管理状态列表
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 15, left: 10),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
      ),
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  //List list = ['名酒', '宝丰', '北京二锅头', '散白', '五粮液', '茅台', '一品峰'];
  
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(90),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12
              )
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal, //设置滚动方向
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(childCategory.childCategoryList[index].mallSubName); //调用子类
            },
          ),
        );
      },
    ); 
  }

  //子类单独项
  Widget _rightInkWell(String item) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Text(
          item,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28)
          )
        ),
      ),
    );
  }
}

//分类列表下商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List list = []; //商品列表

  @override
  void initState() { 
    super.initState();
    _getGoodList();
  }

  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(930),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _ListWidget(index);
        },
      ),
    );
  }

  void _getGoodList() async {
    var data = {
      'categoryId': '4',
      'categorySubId':"",
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      setState(() {
        list = goodslist.data;
      });
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        )
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '价格: ¥${list[index].presentPrice} ',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: Colors.pink
            ),
          ),
          Text(
            ' ¥${list[index].oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }

  Widget _ListWidget(int index) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      )
    );
  }
}