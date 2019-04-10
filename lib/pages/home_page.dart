import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController(); //文本控制器
  String showText = '请选择您喜欢的水果进行购买';

  void _buy() {
    print('正在挑选你喜欢的水果...........');

    //判断文本框输入是否为空
    if (textController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('水果名称不能为空'),
        )
      );
    } else {
      //不为空则请求getHttp方法并且传入本文信息,通过.then的方法接收返回的Future数据
      getHttp(textController.text.toString()).then((value) {
        setState(() {
          //把返回的信息动态的赋值给showText
         showText = value['data']['name']; 
        });
      });
    }
  }

  Future getHttp(String fruitName) async {
    try {
      //声明请求变量类型
      Response response;

      //创建一个请求对象
      var data = {
        'name': fruitName
      };

      //执行get请求并传入参数
      response = await Dio().post(
        'https://www.easy-mock.com/mock/5c7504f63e792633f82eb74a/thankgod/fruit_post',
        queryParameters: data
      );

      //最后返回Future类型的数据
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
          title: Text('水果店'),
          elevation: 0.0,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textController, //添加文本控制器
                  decoration: InputDecoration( //对本文进行修饰
                    labelText: '水果名称', //文本框内提示
                    helperText: '请选择你喜欢吃的水果' //文本框外侧提醒
                  ),
                  autofocus: false, //是否自动得到焦点
                ),
                RaisedButton(
                  child: Text('立即购买'),
                  onPressed: _buy,//点击请求getHttp();
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis, //超出替换...
                  maxLines: 1, //最多显示一行
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}