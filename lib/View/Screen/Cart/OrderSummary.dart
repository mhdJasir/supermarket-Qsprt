import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Controller/CartControllr.dart';
import '../../../Model/CartModel.dart';
import '../../../Utils/NetworkUtils.dart';
import '../../GlobalVar.dart';
import 'Checkout.dart';
import 'Selctaddress.dart';

DateTime selecteddate;
const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class OrderSummary extends StatefulWidget {
  int price;
  List<CartModel> product;
  OrderSummary({this.price, this.product});
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends StateMVC<OrderSummary> {
  CartController _con;
  _OrderSummaryState() : super(CartController()) {
    _con = controller;
  }

  bool tapped;
  DateTime selecteddate;
  int bottomRadioValue = 0;
  DateTime firstDate;
  DateTime lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  List<String> order = [labelMonth, labelDate, labelWeekDay];
  bool forceRender = false;

  Color defaultDecorationColor = Colors.transparent;
  BoxShape defaultDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusDefault = true;

  Color selectedDecorationColor = Colors.green;
  BoxShape selectedDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusSelected = true;

  Color disabledDecorationColor = Colors.grey;
  BoxShape disabledDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusDisabled = true;

  int minSelectedDateCount = 1;
  int maxSelectedDateCount = 1;
  RangeValues selectedDateCount;

  List<DateTime> initialSelectedDates;

  @override
  void initState() {
    super.initState();
    setState(() {
      selecteddate = DateTime.now();
    });
    _con.timeSlot(selecteddate);
    tapped = false;
    const int days = 10;
    firstDate = DateTime.now();
    lastDate = firstDate.add(Duration(days: days - 1));
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = [];
    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }
    return selectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded)),
          iconTheme: IconThemeData(color: Colors.grey[700]),
          backgroundColor: Color(0xfffafafa),
          title: Text(
            "Order Summary",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    height: 230,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.grey),
                    ]),
                    child: Column(children: [
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 5),
                          child:
                              userAddress!=null && userAddress.length!=0?
                               Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userAddress[0].name,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${userAddress[0].city}" +
                                                ",  " +
                                                "${userAddress[0].state}" +
                                                ", " "${userAddress[0].pinCode}",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("${userAddress[0].number}",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      "Add delivery address here..",
                                      style: TextStyle(color: Colors.grey),
                                    )),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(_con.viewaddress[index]["receiver_name"],style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.w500,fontSize: 16)),
                      //     SizedBox(height: 10,),
                      //     Text("$add_address,$add_place,$add_pin",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w500,fontSize: 14),),
                      //     SizedBox(height: 9,),
                      //     Text("$add_number",style: TextStyle(color: Colors.grey[600])),
                      //     SizedBox(height: 16,),
                      //   ],
                      // ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, right: 4),
                        child: Container(
                          padding: EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                              color: Color(0xfffdf6e3),
                              border: Border.all(
                                  color: Color(0xffede0bd), width: 3)),
                          child: Text(
                              "Please make sure this address is suitable to collect your grocery order"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.042,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectAddress()));
                        },
                        child: Container(
                          width: 300,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Color(0xfff10627),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0.0, 0.3),
                                    blurRadius: 2.0,
                                    color: Colors.grey),
                              ]),
                          child: Center(
                            child: Text(
                              "Change or Add Address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Basket items (" + widget.product.length.toString() + ")",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                Container(
                      height: 90,
                      child: new ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.product.map((element) {
                          return new Padding(
                            padding: const EdgeInsets.only(top: 1, left: 10),
                            child: Transform.scale(
                              scale: 0.8,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl +
                                    element.varient_image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "\u20B9 " + widget.price.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    "Choose a Delivery Slot",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: HorizontalCalendar(
                //     lastDate: DateTime.now().add(Duration(days: 10)),
                //     firstDate: DateTime.now(),
                //   ),
                // ),
                SizedBox(
                  height: 8,
                ),
                Stack(
                  children: [
                    _con.timeslotlist != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 190,
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 1),
                              child: Container(
                                height: 52,
                                child: ListView.builder(
                                  itemCount: _con.timeslotlist.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      value: index,
                                      groupValue: bottomRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          bottomRadioValue = value;
                                        });
                                      },
                                      title: Text(_con.timeslotlist[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: bottomRadioValue == index
                                                  ? Color(0xfffa8003)
                                                  : Colors.grey[500])),
                                      secondary: Text("available",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: bottomRadioValue == index
                                                  ? Color(0xfffa8003)
                                                  : Colors.grey[500])),
                                      activeColor: Colors.green,
                                    );
                                  },
                                ),
                              ),
                            ))
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, right: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "\u20B9 0",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Price Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        "\u20B9 " + widget.price.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7, top: 6, bottom: 3),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Checkout(
                                  price: widget.price.toString(),
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    color: Color(0xfff10627),
                    child: Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
