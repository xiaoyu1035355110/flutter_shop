import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还有没请求数据';

  //请求数据事件
  void _jike() {
    print('正在请求数据中..............');

    //执行getHttp请求设置数据
    getHttp().then((val) {
      setState(() {
        showText = val['data'].toString(); 
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio(); //声明一个Dio类型的变量
      dio.options.headers = httpHeaders; //设置请求头信息
      response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('请求远程数据'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child: Text('请求数据'),
              ),
              Text(
                showText
              )
            ],
          ),
        ),
      ),
    );
  }
}