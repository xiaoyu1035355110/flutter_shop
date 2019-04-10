import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp(); //执行getHttp()
    return Scaffold(
      body: Center(
        child: Text('首页'),
      ),
    );
  }

  void getHttp() async {
    try {
      Response response; //声明一个服务器返回的变量为Response类型
      response = await Dio().post('https://www.easy-mock.com/mock/5c7504f63e792633f82eb74a/thankgod/post_flutter?name=张三');
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}
