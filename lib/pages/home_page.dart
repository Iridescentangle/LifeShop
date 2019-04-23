import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  var homePageContent = '';
  int page = 0;
  List hotGoodsList = [];
  GlobalKey<RefreshFooterState> key = GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    super.initState();
    _getHotGoods();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),centerTitle: true,),
      body: FutureBuilder(
        future: request('homePageContent',formData:{'lon':'115.02932','lat':'35.76189'}),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data);
            List<Map> swiperData = (data['data']['slides'] as List).cast();
            List navigatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImg = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List recommendList = data['data']['recommend'];
            String floorTitle = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            List floor1 = (data['data']['floor1'] as List).cast();
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: key,
                bgColor: Colors.white,
                textColor: Colors.lightBlue,
                moreInfoColor: Colors.lightBlue,
                showMore: true,
                noMoreText: '...',
                moreInfo: '加载中...',
                loadedText: '上拉加载',
                loadReadyText:'上拉加载....',
              ),
              onRefresh: () async{
                page = 0;
                _getHotGoods();
              },
              loadMore: () async{
                _getHotGoods();
              },
              child:ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperData,),
                  GridNavigator(navigatorList: navigatorList,),
                  ADBanner(adPicture: adPicture,),
                  LeaderPhone(picUrl: leaderImg,phone: leaderPhone,),
                  Recommend(recommendList: recommendList,),
                  FloorTitle(pic_url: floorTitle,),
                  FloorContent(floorGoodsList: floor1,),
                  _hotGoods(),
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
  void _getHotGoods() async{
    var formData = {'page':page};
    request('homePageBelowContent',formData: formData).then((result){
      List<Map> data = (json.decode(result)['data'] as List).cast();
      setState(() {
        if(page == 0){
          hotGoodsList.clear();
        }
        hotGoodsList.addAll(data);
        page++;
      });
    });
  }
  Widget hotTitle =Container(
    margin: EdgeInsets.only(top:10.0,bottom: 30.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );
  Widget _wrapList(){
    return hotGoodsList.length == 0?Container():
    Wrap(
      spacing: 2,
      children:
      hotGoodsList.map(
        (item){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, '/detail?goodsId=${item['goodsId']}');
            },
            child: Container(
              width: ScreenUtil.instance.setWidth(370),
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  Image.network(item['image'],width: ScreenUtil.instance.setWidth(368),),
                  Text(
                    item['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.lightBlue,fontSize: ScreenUtil.instance.setSp(25)),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Text('￥${item['mallPrice']}',),
                    Text('￥${item['price']}',style:TextStyle(color:Colors.black26,decoration:TextDecoration.lineThrough),),
                  ],)
                ],
              ),
            ),
          );
        }).toList());
  }
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}
//首页轮播组件
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
          physics: NeverScrollableScrollPhysics(),
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
      // height: ScreenUtil().setHeight(430),
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
      // height: ScreenUtil.instance.setHeight(330),
      height: ScreenUtil.instance.setHeight(390),
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
        // height: ScreenUtil.instance.setHeight(400),
        width: ScreenUtil.instance.setWidth(280),
        padding: EdgeInsets.all(7.0),
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
class FloorTitle extends StatelessWidget {
  final String pic_url;

  FloorTitle({Key key, this.pic_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Image.network(pic_url),
    );
  }
}
//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }
  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }
  Widget _otherGoods(){
    return Row(
      children: <Widget>[
         _goodsItem(floorGoodsList[3]),
         _goodsItem(floorGoodsList[4]),
      ],
    );
  }
  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil.instance.setWidth(375),
      child: InkWell(
        onTap: (){

        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
