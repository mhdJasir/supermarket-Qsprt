import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:supermarket/Repository/HomeRepo.dart'as repo;
class HomeController extends ControllerMVC{
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> FormKey;
  List bannerList =[];
  List categories=[];
  List allProducts=[];
  var termm="";
  var abouttt="";

  void getBannerList()async{
    repo.getBannerList().then((value) {
      if(value["status"]=="1"){
        setState(() {
          bannerList = value["data"];
        });
      }
    });
  }
  void topSix()async{
    repo.getCategory().then((value) {
      if(value["status"]=="1"){
        setState(() {
          categories=value["data"];
        });
      }
      else Fluttertoast.showToast(msg: 'service not available for this location');
    });
    print(categories);
  }
  void allproductlist()async{
    repo.allprod().then((value) {
      if(value["status"]=="1"){
        setState(() {
          allProducts=value["data"];
        });
      }
    });
  }
  void termconditn()async{
    repo.trmconditn().then((value) {
      if(value["status"]=="1"){
       setState(() {
         termm=value["data"]["description"];
       });
      }
    });
  }
  void aboutus()async{

    print("Abouts");
    repo.aboutus().then((value) {
      print("sss"+value["status"].toString());
      if(value["status"]=="1"){
        setState(() {
          abouttt=value["data"]["description"];
        });
        print("qwqeqwqeqew  "+abouttt.toString());

      }

    });

  }


}


