import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DetailIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0),
      width: ScreenUtil.instance.setWidth(750),
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明: > 极速送达 > 品质保证',
        style:TextStyle(
          color: Colors.blueAccent,
          fontSize: ScreenUtil.instance.setSp(30),
        ),
      ),
    );
  }
}