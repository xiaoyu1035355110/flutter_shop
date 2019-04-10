import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = tabBodies[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活'),
        elevation: 0.0,
      ),
      body: currentPage,
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar( //底部导航栏
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
           currentIndex = index; 
           currentPage = tabBodies[currentIndex];
          });
        },
      ),
    );
  }
}