

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../Bottomtabs.dart';
import '../Widgets/validate_Fields.dart';
class Otppage extends StatefulWidget {
  var phon;
  Otppage({this.phon});
  @override
  _OtppageState createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  final GlobalKey<ScaffoldState>_scaffoldkey=GlobalKey<ScaffoldState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  String _verifictaionCode;
  Validations validations = new Validations();
  TextEditingController otpcontroller = TextEditingController();
  // Widget _otpfield(){
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 2,left: 2),
  //     child: TextFormField(
  //       keyboardType: TextInputType.number,
  //       validator: validations.validateOtp,
  //       controller: otpcontroller,
  //       style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.w500,fontSize: 15),
  //       decoration: InputDecoration(
  //
  //         enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //                 color: Colors.grey[400]
  //             ),borderRadius: BorderRadius.circular(15)
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //                 color: Colors.grey[400]
  //             ),borderRadius: BorderRadius.circular(15)
  //         ),filled: true,
  //         fillColor: Colors.white,
  //         focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //                 color: Colors.grey[400]
  //             ),borderRadius: BorderRadius.circular(15)
  //         ),
  //         errorBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //                 color: Colors.grey[400]
  //             ),borderRadius: BorderRadius.circular(15)
  //         ),
  //
  //         contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 8),
  //         hintText: "Enter OTP",
  //         hintStyle: TextStyle(fontSize: 16,
  //             color: Colors.grey[500]
  //         ),
  //         border: InputBorder.none,
  //         disabledBorder: InputBorder.none,
  //
  //       ),
  //     ),
  //   );
  // }
  Widget _verifybutton(){
    return GestureDetector(
    // onTap: (val)async{
    //   await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verifictaionCode, smsCode: val))
    //
    // },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(15),
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
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  _verifyphone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phon}',
        verificationCompleted: (PhoneAuthCredential credential)async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
            if(value.user!=null){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottomtabs()),  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseException e){
          print(e.message);
        },
        codeSent: (String verificationID,int resendToken){
          setState(() {
            _verifictaionCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID){
          _verifictaionCode = verificationID;
        },
    timeout: Duration(seconds: 60));
  }
  @override
  void initState() {
    _verifyphone();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
          Text(widget.phon,style: TextStyle(
              color: Colors.black,fontSize: 21,fontWeight: FontWeight.w600
          ),),
          SizedBox(height: MediaQuery.of(context).size.height*0.042,),
          Padding(
            padding: const EdgeInsets.only(right: 20,left: 20),
            child: PinPut(
              fieldsCount: 6,
              withCursor: true,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
               onSubmit: (pin)async{
               try{
                 await FirebaseAuth.instance.signInWithCredential(
                     PhoneAuthProvider.credential(verificationId: _verifictaionCode, smsCode: pin)
                 ).then((value) async{
                   if(value.user!=null){
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottomtabs()),  (route) => false);
                   }
                 });
               }catch(e){
                 FocusScope.of(context).unfocus();
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
               }
               },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.022,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50,top: 20),
            child: _verifybutton(),
          )
        ],
      ) ,
    );
  }
}
