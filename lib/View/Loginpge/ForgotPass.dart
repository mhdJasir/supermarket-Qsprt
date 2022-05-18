

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Controller/UserLogRegController.dart';
import 'UpdatePass.dart';

class Forgotpasswrd extends StatefulWidget {
  @override
  _ForgotpasswrdState createState() => _ForgotpasswrdState();
}

class _ForgotpasswrdState extends StateMVC<Forgotpasswrd> {
  UserLogRegController _con;


  _ForgotpasswrdState():super(UserLogRegController()){
    _con=controller;
  }
  TextEditingController phone = TextEditingController();

  Widget _mobilefield(){
    return Container(
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                offset: Offset(
                    0.0,
                    2.0
                ),
                blurRadius: 4.0,
                color: Colors.grey
            )
          ]
      ),
      child: TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.start,
        cursorColor: Color(0xfff10627),
        decoration: InputDecoration(
            counterText: "",
            prefixIcon: Icon(Icons.phone_android_outlined,color: Color(0xfff10627),size: 28,),
            hintText: "Enter Phone",
            hintStyle: TextStyle(fontSize: 17,
                color: Colors.grey[600]
            ),

            border: InputBorder.none
        ),
      ),
    );
  }
  Widget _verifybutton(){
    return GestureDetector(
      onTap: ()  {
        _con.forgotPassword(phone.text, context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Updatepasswrd())
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: Offset(
                      0.0,
                      2.0
                  ),
                  blurRadius: 4.0,
                  color: Colors.grey
              ),
            ]
        ),

        child: Center(
          child: Text ("Verify",style: TextStyle(
              color: Colors.white,
              fontSize: 16,fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1,  color:Color(0xfff10627)),
              ),
              child: Center(
                child: Text("Logo",style: TextStyle(
                    color: Colors.black,
                    fontSize: 22

                ),),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.042,),
          Text("Forgot Password",style: TextStyle(
              color: Colors.black,fontSize: 21,fontWeight: FontWeight.w600
          ),),
          SizedBox(height: MediaQuery.of(context).size.height*0.042,),
          Padding(
            padding:  EdgeInsets.only(left: 50,right: 50),
            child: _mobilefield(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.082,),
          Padding(
            padding:  EdgeInsets.only(left: 50,right: 50,top: 20),
            child: _verifybutton(),
          )
        ],
      ) ,
    );
  }
}
