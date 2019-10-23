import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/details_page.dart';
import './router_handle.dart';

class Routes {
  static String root = '/'; //根目录
  static String detialsPage = '/detial'; //详情页面

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('error: route was not found!!');
      }
    );

    //配置详情页面
    router.define(detialsPage, handler: detailsHandler);
  }
}