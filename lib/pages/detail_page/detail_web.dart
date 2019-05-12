import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/generated/i18n.dart';
import 'package:life_shop/provide/detail_info_provide.dart';
import 'package:provide/provide.dart';
import 'package:life_shop/model/goods_detail.dart';
class DetailWebPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvider>(
      builder: (context,child,provide){
        List<GoodComments> comments = provide.model.data.goodComments;
        return provide.leftSelected?
        Container(
          child: Html(
            data: provide.model.data.goodInfo.goodsDetail,
          ),
        ):
        Container(
          constraints: BoxConstraints(maxHeight: 100,maxWidth: ScreenUtil.instance.setWidth(750)),
          child: (comments != null && comments.length > 0)?
          ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context,index){
               GoodComments item = comments[index];
              return Container(
                padding: EdgeInsets.all(5),
                color:Colors.white,
                child:ListTile(
                  leading: Column(
                      children: <Widget>[
                        Text(item.userName,style: TextStyle(fontSize: ScreenUtil.instance.setSp(20),color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text(item.comments,style:TextStyle(color: Colors.grey,fontSize:ScreenUtil.instance.setSp(20))),
                        Text('${item.discussTime}',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil.instance.setSp(17),fontWeight: FontWeight.w100,)),
                      ],
                    ),
                ),
              );
            },
          )
          :Container(
            width: ScreenUtil.instance.setWidth(750),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('该商品暂无更多评论哦！',style:Theme.of(context).textTheme.subhead),
          )
        );
      },
    );
  }
}