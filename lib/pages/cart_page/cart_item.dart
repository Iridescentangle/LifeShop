import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_info.dart';
import '../cart_page/cart_goods_count_manager.dart';
import '../../provide/cart_provide.dart';
class CartItemView extends StatelessWidget {
  final CartInfo cartInfoItem;
  CartItemView(this.cartInfoItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0,color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          _checkBox(context),
          _goodsImage(),
          _goodsNameAndCount(),
          _goodsPrice(context),
        ],
      ),
    );
  }
  //多选的选择按钮
  Widget _checkBox(BuildContext context){
    return Container(
      child: Checkbox(
        activeColor: Colors.blueAccent,
        value: this.cartInfoItem.isCheck,
        onChanged: (bool checked){
          this.cartInfoItem.isCheck = checked;
          Provide.value<CartProvider>(context).changeSelectState(cartInfoItem);
        },
      ),
    );
  }
  //商品配图
  Widget _goodsImage(){
    return Container(
      width: ScreenUtil.instance.setWidth(150),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5,color: Colors.grey),
      ),
      child: Image.network(this.cartInfoItem.images),
    );
  }
  //商品名称
  Widget _goodsNameAndCount(){
    return Container(
      margin:EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      width: ScreenUtil.instance.setWidth(300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            Text(
              this.cartInfoItem.goodsName,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.instance.setSp(25),
              ),
            ),
            CartGoodsCountManager(this.cartInfoItem),
          ],
        ),
    );
  }
  //商品价格
  Widget _goodsPrice(BuildContext context){
    return Container(
      width: ScreenUtil.instance.setWidth(150),
      child: Column(
        children: <Widget>[
          Text(
            '￥ ${this.cartInfoItem.price}',
            style:TextStyle(color: Colors.black)
            ),
          IconButton(
            icon: Icon(CupertinoIcons.delete,size: ScreenUtil.instance.setWidth(50),),
            onPressed: (){
              //TODO 删除商品按钮
              Provide.value<CartProvider>(context).deleteGoods(cartInfoItem.goodsId);
            },
          ),
        ],
      ),
    );
  }
}