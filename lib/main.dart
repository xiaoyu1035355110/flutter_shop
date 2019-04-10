import 'package:flutter/material.dart';
import 'pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false, //是否开启debug角标
        theme: ThemeData(
          primaryColor: Colors.pink //设置app主题色
        ),
        home: IndexPage(), //主体内容
      ),
    );
  }
}