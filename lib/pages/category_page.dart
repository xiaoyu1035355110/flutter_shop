import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
  _getCategory();
    return  Container(
      child: Center(
        child: Text('分类商品'),
      ),
    );
  }

  void _getCategory(){
    request('getCategory').then((val){
      var data = json.decode(val.toString());
      print(data);
    });
  }
}