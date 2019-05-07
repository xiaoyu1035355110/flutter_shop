import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            LeftCategoryNav()
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
    return InkWell(
      onTap: (){},
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
          color: Colors.white,
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