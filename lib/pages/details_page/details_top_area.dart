import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  const DetailsTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImages(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('数据正在加载中.........');
        }
      },
    );
  }

  /*
   * 商品图片 
   * params [url] 商品图片链接
   */
  Widget _goodsImages(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }
  
  /*
   * 商品标题
   * params [name] 商品标题参数
   */
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only( left: 15.0 ),
      margin: EdgeInsets.only( top: 8.0 ),
      child: Text(
        '${name}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        )
      ),
    );
  }

  /**
   * 商品编号
   * params [num] 商品编号
   */
  Widget _goodsNum(num) {
     return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only( left: 15.0 ),
      margin: EdgeInsets.only( top: 8.0 ),
      child: Text(
        '编号: ${num}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black26
        )
      ),
    );
  }
  
  /**
   * 商品价格
   * params [presentPrice] 销售价格
   * params [oriPrice] 市场价格
   */
  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only( left: 15.0, bottom: 20.0 ),
      margin: EdgeInsets.only( top: 8.0 ),
      child: Row(
        children: <Widget>[
          Text(
            '¥ ${presentPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(40),
              color: Colors.pinkAccent
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '市场价:',
            ),
          ),
          Text(
            '市场价 ¥${oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
              fontSize: ScreenUtil().setSp(30)
            ),
          )
        ],
      ),
    );
  }
}