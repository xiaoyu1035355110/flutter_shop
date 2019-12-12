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
        ],
      )
    );
  }

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
}