import 'package:flutter/material.dart';
import '../../provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
class CartBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil.instance.setWidth(750),
      child: Row(
          children: <Widget>[
            _checkAllButton(),
            
          ],
        ),
    );
  }
  Widget _checkAllButton(){
    return Container(
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.blueAccent,
            onChanged: (value){
              //TODO 全选中或取消全选
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }
  Widget _totalPrice(){
    return Container(
      width: ScreenUtil.instance.setWidth(450),
      child: Row(
        children: <Widget>[
          Container(
            // width: ,
          ),
        ],
      ),
    );
  }
}