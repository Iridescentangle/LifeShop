import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:life_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImg = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List recommendList = data['data']['recommend'];
            return SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperData,),
                  GridNavigator(navigatorList: navigatorList,),
                  ADBanner(adPicture: adPicture,),
                  LeaderPhone(picUrl: leaderImg,phone: leaderPhone,),
                  Recommend(recommendList: recommendList,),
                ],
              ),
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
class ADBanner extends StatelessWidget {
  final String adPicture;

  ADBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}
class LeaderPhone extends StatelessWidget {
  final String picUrl;
  final String phone;

  LeaderPhone({Key key, this.picUrl,this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:_launchUrl,
        child: Image.network(picUrl),
      ),
    );
  }
  void _launchUrl() async{
    String url = 'tel:'+phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.instance.setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
  //标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12),
        ),
      ),
      child: Text('商品推荐',style:TextStyle(color:Colors.pink)),
    );
  }
  //横向列表
  Widget _recommendList(){
    return Container(
      height: ScreenUtil.instance.setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: _item,
      ),
    );
  }
  //图片单独项方法
  Widget _item(BuildContext context,int index){
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: ScreenUtil.instance.setHeight(330),
        width: ScreenUtil.instance.setWidth(250),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 0.5,color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text(
              '￥${recommendList[index]['mallPrice']}',
              ),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
              ),
          ],
        ),
      ),
    );
  }
}