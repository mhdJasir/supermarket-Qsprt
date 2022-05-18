import 'dart:convert';



import 'package:http/http.dart'as http;

import '../Utils/NetworkUtils.dart';

Future pndingodr(uid)async{
  final String url = NetworkUtils.pendingordr;
  final response = await http.post(url, body: {
  "user_id" : uid.toString(),
  });
  var ordrpnding = json.decode(response.body);
  return ordrpnding;
}
Future pstorder(uid)async{
  final String url = NetworkUtils.postordr;
  final response = await http.post(url, body: {
    "user_id" : uid.toString(),
  });
  var ordrpnding = json.decode(response.body);
  return ordrpnding;
}