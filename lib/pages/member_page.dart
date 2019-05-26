import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import '../routers/application.dart';
class MemberPage extends StatelessWidget {
  List ordersList = [
    {"icon":Icons.payment,"title":"待付款","index":0},
    {"icon":Icons.timer,"title":"待发货","index":1},
    {"icon":Icons.transfer_within_a_station,"title":"待收货","index":2},
    {"icon":Icons.description,"title":"待评价","index":3},
  ];
  List myList =[
    {'icon':Icons.note,'title':'领取优惠券','index':0},
    {'icon':Icons.note,'title':'已领取优惠券','index':1},
    {'icon':Icons.location_city,'title':'地址管理','index':2},
    {'icon':Icons.phone,'title':'客服电话','index':3},
    {'icon':Icons.info,'title':'关于我们','index':4},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('会员中心'),),
      body: FutureBuilder(
        future: _getData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView(
              children: <Widget>[
                _topArea(context),
                _myOrdersArea(context),
                _myListArea(context),
              ],
            );
          }else{
            return Center(
              child: Text('暂无数据!'),
            );
          }
        },
      ),
    );
  }
  _getData() async{
    return '有数据了';
  }
  Widget _topArea(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      padding: EdgeInsets.all(20),
      width: ScreenUtil.instance.setWidth(750),
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.instance.setWidth(150),
            height: ScreenUtil.instance.setHeight(150),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.network('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1326698293,4024420195&fm=26&gp=0.jpg'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: Text(
              '会员10145',
              style:TextStyle(color:Colors.white,fontSize:ScreenUtil.instance.setSp(35)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _myOrdersArea(BuildContext context){
    return Container(
      child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(width: 1,color:Colors.black12)),
            ),
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('我的订单'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Container(
            color: Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ordersList.map(
                (var item){
                  return InkWell(
                    onTap: (){
                      //TODO 待付款 待发货 待收货 待评价
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment:Alignment.center,
                          padding: EdgeInsets.only(top: 20,bottom: 10),
                          child:Icon(item['icon']),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15),
                          child:Text(item['title'],style: TextStyle(color: Colors.black,fontSize: ScreenUtil.instance.setSp(25)),),
                        ),
                      ],
                    ),
                  );
                }
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _myListArea(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 25,bottom: 25),
      color: Colors.white,
      child: Column(
        children: myList.map(
          (var item){
            return Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(
                  width: 1,color: Colors.black12,
                ))
              ),
              child: ListTile(
                onTap:(){
                  //TODO 根据index判断
                  if(item['index'] == 0){
                    Application.router.navigateTo(context,'jpush');
                  }
                },
                leading: Icon(item['icon']),
                title: Text(item['title']),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          }
        ).toList(),
      ),
    );
  }

}