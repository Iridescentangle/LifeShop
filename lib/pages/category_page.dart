import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String text = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNavigator(),
          ],
        ),
      ),
    );

  }
}
class LeftCategoryNavigator extends StatefulWidget {
  @override
  _LeftCategoryNavigatorState createState() => _LeftCategoryNavigatorState();
}

class _LeftCategoryNavigatorState extends State<LeftCategoryNavigator> {
   List list = [];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.instance.setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }
  void _getCategory() async{
    await request('category').then((result){
      var data = json.decode(result.toString());
      CategoryModel model =CategoryModel.fromJson(data);
      model.data.forEach((item)=>print(item.mallCategoryName));
      setState(() {
        list = model.data;
      });
    });
  }
  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: ScreenUtil.instance.setHeight(100),
        padding: EdgeInsets.only(left: 10.0,top: 20.0,),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom:BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: 26),),
      ),
    );
  }
}