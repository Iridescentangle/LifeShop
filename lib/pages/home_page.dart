import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:life_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homePageContent = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),centerTitle: true,),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data);
            List<Map> swiperData = (data['data']['slides'] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiperData,),
              ],
            );
          }else{
            return Text('加载中',style: TextStyle(fontSize: ScreenUtil().setSp(28)),);
          }
        },
      ),
    );
  }
}
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
       child: Swiper(itemBuilder: (context,index){
         return Image.network(swiperDataList[index]['image'].toString(),fit: BoxFit.cover,);
        },
        itemCount: swiperDataList.length,
      ),
    );
  }
}