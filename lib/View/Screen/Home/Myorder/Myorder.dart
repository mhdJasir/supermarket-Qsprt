

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'PastOrder.dart';
import 'PendingOrder.dart';
class Myorder extends StatefulWidget {
  Myorder({this.usrid});
  var usrid;

  @override
  _MyorderState createState() => _MyorderState();
}

class _MyorderState extends StateMVC<Myorder> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color:  Colors.white),
          backgroundColor:Color(0xfff01d3a),
          title: Text("My Order",style: TextStyle(color:  Colors.white),),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "PENDING ORDER",),
              Tab(text: "PAST ORDER",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingOrder(),
            PastOrder(),
          ],
        ),
      ),
    );
  }
}
