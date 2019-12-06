import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  const DetailsExplain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only( top: 10.0 ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Color.fromRGBO(255,111,0 ,1)
        ),
      ),
    );
  }
}