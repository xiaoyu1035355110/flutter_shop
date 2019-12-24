import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType()
        ],
      )
    );
  }

  //头部banner
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 30.0
            ),
            child: ClipOval(
              child: Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0
            ),
            child: Text(
              '技术胖',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(36)
              )
            ),
          )
        ],
      ),
    );
  }

  //订单标题
  Widget _orderTitle() {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only( top: 10 ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide( width: 1, color: Colors.white12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //订单类型
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30
                ),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30
                ),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }
}