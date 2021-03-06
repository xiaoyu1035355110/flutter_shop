import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    _getGoodList();
    super.initState();
  }

  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());

      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategoryList(list[0].bxMallSubDto,list[0].mallCategoryId); 
    });
  }

  void _getGoodList({String categoryId}) async {
    var data = {
      'categoryId': categoryId != null ? categoryId : '4',
      'categorySubId':"",
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodslist.data);
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
        var categoryId = list[index].mallCategoryId; //获取当前一级分类id
        Provide.value<ChildCategory>(context).getChildCategoryList(childList, categoryId); //修改二级分类的管理状态列表
        _getGoodList(categoryId: categoryId);
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
              return _rightInkWell(index, childCategory.childCategoryList[index]); //调用子类
            },
          ),
        );
      },
    ); 
  }

  //子类单独项
  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false; //判断是否点击
    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodList(context, item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black
          )
        ),
      ),
    );
  }

  //得到商品列表数据
  void _getGoodList(context, String categorySubId) {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page': 1
    };
    request('getMallGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      if (goodslist.data != null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodslist.data);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }
    });
  }
}

//商品列表 上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>(); //声明上拉加载key

  var scorllController = new ScrollController();

  @override
  void initState() { 
    super.initState();
  }

  //上拉加载更多的方法
  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).categorySubId,
      'page': Provide.value<ChildCategory>(context).page
    };
    request('getMallGoods', formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      if (goodslist.data == null) {
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodslist.data);
      }
    });
  }

  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if(Provide.value<ChildCategory>(context).page == 1) {
            scorllController.jumpTo(0.0);
          }
        } catch (e) {
          // print('第一次初始化页面${e}');
        }

        //判断列表是否有数据
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载',
                ),
                child: ListView.builder(
                  controller: scorllController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index) {
                    return _listWidget(data.goodsList, index);
                  },
                ),
                loadMore: () async {
                 if(Provide.value<ChildCategory>(context).noMoreText=='没有更多了'){
                    Fluttertoast.showToast(
                      msg: "已经到底了",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.pink,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  }else{
                    _getMoreList();
                  }
                },
              )
            ),
          );
        } else {
          return Text(
            '当前暂无数据'
          );
        }
      },
    );
  }

  Widget _goodsImage(newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        )
      ),
    );
  }

  Widget _goodsPrice(newList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '价格: ¥${newList[index].presentPrice} ',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: Colors.pink
            ),
          ),
          Text(
            ' ¥${newList[index].oriPrice}',
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

  Widget _listWidget(List newList, int index) {
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
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      )
    );
  }
}