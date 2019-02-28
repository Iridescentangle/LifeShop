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
          print(snapshot.data.toString());
          if(snapshot.hasData){
            var data = json.decode(snapshot.data);
            List<Map> swiperData = (data['data']['slides'] as List).cast();
            List navigatorList = (data['data']['category'] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiperData,),
                GridNavigator(navigatorList: navigatorList,),
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
class GridNavigator extends StatelessWidget {
  final List navigatorList;
  GridNavigator({Key key,this.navigatorList}) : super(key: key);
  Widget _gridViewItem(context,item){
    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'],style:TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(navigatorList.length > 10){
      navigatorList.removeRange(10,navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child:GridView.count(
            crossAxisCount: 5,
            padding: EdgeInsets.all(5.0),
            children: navigatorList.map((item)=>_gridViewItem(context, item)).toList(),
      )
    );
  }
}