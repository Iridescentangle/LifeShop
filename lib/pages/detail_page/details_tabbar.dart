import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_shop/provide/detail_info_provide.dart';
class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0,),
      child: Provide<GoodsDetailProvider>(
            builder: (context,child,provider){
              return Row(
                children: <Widget>[
                  _customTabBar(context, '详情', provider.leftSelected),
                  _customTabBar(context, '评论', !provider.leftSelected),
                ],
              );
            },
          ),
    );
  }
  Widget _customTabBar(context,text,selected){
    return InkWell(
      onTap: (){
        Provide.value<GoodsDetailProvider>(context).changeTab();
      },
      child:Container(
            width: ScreenUtil.instance.setWidth(375),
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: selected?Colors.blueAccent:Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              text,
              style:TextStyle(
                color: selected?Colors.blueAccent:Colors.black26,
                fontSize: ScreenUtil.instance.setSp(25),
                ),
              ),
        ),
    );
  }
}