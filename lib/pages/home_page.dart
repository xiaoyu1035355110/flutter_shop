import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder( //异步渲染组件
          future: getHomePageContent(), //渲染执行对应方法
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast();
              List<Map> navigatorList = (data['data']['category'] as List).cast();
              String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone,)
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('请求数据中'),
              );
            }
          },
        )
      ),
    );
  }
}

//轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({
    this.swiperDataList
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(swiperDataList[index]['image'], fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: (){
        print('你点击了顶部导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  TopNavigator({
    this.navigatorList
  });

  @override
  Widget build(BuildContext context) {

    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList()
      ),
    );
  }
}

//顶部广告
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({
    this.adPicture
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({
    this.leaderImage,
    this.leaderPhone
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:$leaderPhone';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问,异常';
    }
  }
}
