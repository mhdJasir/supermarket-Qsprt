

import 'dart:convert';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../Functions/location.dart';
import '../Utils/NetworkUtils.dart';


Future getBannerList()async{
  final String url = NetworkUtils.bannerlist;
  final response = await http.get(Uri.encodeFull(url));
  var data = json.decode(response.body);
  return data;
}
Future getCategory()async{
  var loc=await locateUser();
  var placeMark=await getLocation();
  var city=placeMark.subAdministrativeArea;
  print(city);
  var body={
      "lat":loc.latitude.toString(),
      "lng":loc.longitude.toString(),
      "city":"calicut"
  };
  final String url = NetworkUtils.topsix;
  final response = await http.post(Uri.parse(url),body: body);
  if(response.statusCode==200) {
    var data = json.decode(response.body);
    return data;
  }
  else Fluttertoast.showToast(msg: 'something went wrong');
}
Future allprod()async{
  final String url = NetworkUtils.allproduct;
  final response = await http.get(Uri.encodeFull(url));
  var allpr = json.decode(response.body);
  return allpr;
}
Future trmconditn()async{
  final String url = NetworkUtils.termcondtn;
  final response = await http.get(Uri.encodeFull(url));
  var temss = json.decode(response.body);
  return temss;
}
Future aboutus()async{
  final String url = NetworkUtils.aboutus;
  final response = await http.get(Uri.encodeFull(url));
  var about = json.decode(response.body);
  print("Abouttt"+about.toString());
  return about;
}



