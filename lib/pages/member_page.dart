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
          _orderType(),
          _actionList()
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

  //通用listTile
  Widget _myListTile(String title) {
    return Container(
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.white12)
        ),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}