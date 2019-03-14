import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import 'dart:convert';
import '../model/category.dart';
class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String text = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request('category').then((result){
      var data = (json.decode(result))['data'];
      CategoryListModel list = CategoryListModel.fromJson(data);
      for (var item in list.data){
        print(item.mallCategoryName);
      }
      setState(() {
        text = result;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
//    return FutureBuilder(
//      future: (),
//      builder: (context,snapshot){
//        return Container();
//      },
//    );
    return Center(
      child: Text(text),
    );

  }
}