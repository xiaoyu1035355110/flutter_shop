import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/current_index.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();//管理状态
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();

  //注册全局路由
  final router = Router();
  Routes.configureRoutes(router); //routes->configureRoutes
  Application.router = router; //router静态化

  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))//管理Counter泛型的状态
    ..provide(Provider<Counter>.value(counter))//管理Counter泛型的状态
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))//管理Counter泛型的状态
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))//管理Counter泛型的状态
    ..provide(Provider<CartProvide>.value(cartProvide))//管理Counter泛型的状态
    ..provide(Provider<ChildCategory>.value(childCategory));//管理Counter泛型的状态
  return runApp(
    ProviderNode( //根据监听通知改变状态值
      child: MyApp(),
      providers: providers, //状态管理
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator, //注入顶层router
        debugShowCheckedModeBanner: false, //是否开启debug角标
        theme: ThemeData(
          primaryColor: Colors.pink //设置app主题色
        ),
        home: IndexPage(), //主体内容
      ),
    );
  }
}