import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:life_shop/service/service_method.dart';
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homePageContent = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePageContent().then((data){
      setState(() {
        homePageContent = data.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Text(homePageContent),
      ),
    );
  }
}