import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500.0,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('添加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('清空'),
          )
        ],
      ),
    );
  }

  //添加存储
  void _add() async {
    //初始化持久化存储
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = 'hello world';
    testList.add(temp); //添加
    prefs.setStringList('testInfo', testList);
    _show();
  }

  //查询显示
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getStringList('testInfo') != null) {
        testList = prefs.getStringList('testInfo');
      }
    });
  }

  //清空删除
  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear(); //清除全部
    prefs.remove('testInfo'); //删除关键key
    setState(() {
      testList = [];
    });
  }
}