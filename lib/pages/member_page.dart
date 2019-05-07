import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 200),
          child: Provide<Counter>( //使用Provide指定泛型利用builder输出数据
            builder: (context, child, counter) {
              return Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.display1,
              );
            },
          )
        ),
      ),
    );
  }
}