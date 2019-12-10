import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartProvide>(context).cartList;
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartList[index].goodsName),
                );
              },
            );
          } else {
            return Text('正在加载...');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}