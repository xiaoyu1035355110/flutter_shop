import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  int currentIndex = 0;
  var currentPage;

  //定义变量接收引入的页面
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  //定义底部导航选项组
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    )
  ];

  //初始化方法
  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = tabBodies[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);//初始化设计图配置
    return Scaffold(
      body: currentPage, //当前显示页面
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0), //底部栏背景色
      bottomNavigationBar: BottomNavigationBar( //底部导航栏
        type: BottomNavigationBarType.fixed, //导航栏类型PS: 必须在3个以上才有效果
        currentIndex: currentIndex,//当前显示的索引
        items: bottomTabs, //显示的选项组
        onTap: (index) { //点击切换传入索引
          //点击后设置当前显示的索引以及显示的页面
          setState(() {
           currentIndex = index; 
           currentPage = tabBodies[currentIndex];
          });
        },
      ),
    );
  }
}