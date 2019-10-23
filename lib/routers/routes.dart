import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/'; //根目录
  static String detailsPage = '/detail'; //详情页面

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('error: route was not found!!');
      }
    );

    //配置详情页面
    router.define(detailsPage, handler: detailsHandler);
  }
}