
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Controller/CartControllr.dart';
class Checkout extends StatefulWidget {
  var price;
  Checkout({this.price});
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends StateMVC <Checkout> {
  CartController _con;
  _CheckoutState() : super(CartController()) {
    _con = controller;
  }
  int cashondelivryradio = 0;
  var PaymntMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios_rounded)),
        iconTheme: IconThemeData(color: Color(0xfff10627)),
        backgroundColor: Colors.white,
        title: Text("Checkout",style: TextStyle(color:  Color(0xfff10627),),
      ),
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Center(child: Text("RESET",style: TextStyle(color: Colors.grey[700]),)),
          )],
    ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              color: Color(0xfff4f4f4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 12,bottom: 12),
                    child: Text("Payment Method",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 17),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,bottom: 12,right: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                      color: Color(0xffdcdcdc),
                        borderRadius: BorderRadius.circular(8)
                      ),

                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(right: 2,left: 2),
                          child: Container(

                            decoration: BoxDecoration(
                              color: Colors.white,

                            ),height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15,left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Cash on delivery",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                  Radio(  value: 1,
                                    groupValue:cashondelivryradio ,
                                    onChanged: (value){
                                      setState(() {
                                        cashondelivryradio = value;
                                      });
                                      print("nnnnn"+cashondelivryradio.toString());
                                      if(cashondelivryradio.toString()=="1"){
                                        setState(() {
                                          PaymntMode = "COD";
                                        });
                                        print(PaymntMode);
                                      }
                                    },
                                    activeColor: Colors.green,
                                  )
                                ],
                              ),
                            ),

                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(right: 2,left: 2,bottom: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )

                            ),height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15,left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Promo Code",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                  Container(
                                    width: 90,
                                    height: 34.0,
                                    decoration: BoxDecoration(
                                        color:Color(0xfff10627),
                                        borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Center(
                                      child: Text ("Apply",style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,fontWeight: FontWeight.w400
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        )

                      ],
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Container(
                      padding: EdgeInsets.only(right: 18,left: 18),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(33)
                      ),
                      child: Center(child: Text("You will get 10 reward points with succefull checkout of this order.",textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.grey[600],fontSize: 12,fontWeight: FontWeight.w500
                      ),)),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Container(
                      padding: EdgeInsets.only(right: 18,left: 18),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(33)
                      ),

                      child: Center(child: Text("Add items of \u20B9 700 more to get 50 reward points.",style: TextStyle(
                          color: Colors.grey[600],fontSize: 12,fontWeight: FontWeight.w500
                      ),)),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
        child: Container(
          height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount: \u20B9 "+widget.price.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                GestureDetector(
                  onTap: (){
                    print("s");
                    _con.checkout(PaymntMode,PaymntMode,widget.price,context);
                    print("qqq");
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderCompleted()));
                  },
                  child: Container(
                    width: 140,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color:Color(0xfff10627),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Center(
                      child: Text ("PAY NOW",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,fontWeight: FontWeight.w800
                      ),),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
