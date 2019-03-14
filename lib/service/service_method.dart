import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:life_shop/config/service_url.dart';
//获取首页主体内容
Future request(String url,{formData}) async{
  Response response;
  Dio dio = Dio();
  dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  // var formData = {'lon':'115.02932','lat':'35.76189'};
  try{
    if(formData == null){
        response =await dio.post(servicePath[url],);
    }else{
        response =await dio.post(servicePath[url],data: formData,);
    }
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('接口出现异常--状态码${response.statusCode}');
    }
  } catch (e) {
    print('ERROR:========>$e');
  }
 
}
//获取首页主体内容
Future getHomePageContent() async{
  print('开始获取首页数据');
  Response response;
  Dio dio = Dio();
  dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  var formData = {'lon':'115.02932','lat':'35.76189'};
  try {
    response =await dio.post(servicePath['homePageContent'],data: formData,);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('接口出现异常--状态码${response.statusCode}');
    }
  } catch (e) {
    print('ERROR:========>$e');
  }
 
}
//获取首页火爆专区商品数据
Future getHomePageBelowContent() async{
  print('开始获取火爆专区数据');
  Response response;
  Dio dio = Dio();
  dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
  int page = 1;
  try {
    response =await dio.post(servicePath['homePageBelowContent'],data: page,);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('接口出现异常--状态码${response.statusCode}');
    }
  } catch (e) {
    print('ERROR:========>$e');
  }
 
}