import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:supermarket/Repository/UserRegLogRepository.dart' as repo;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../View/Bottomtabs.dart';
import '../View/GlobalVar.dart';
import '../View/Loginpge/Otp.dart';
import '../View/Widgets/Style.dart';

class UserLogRegController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  var loginData = [];
  UserLogRegController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void setUserId(userIdPassed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userIdPassed);
  }

  void setUserName(userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
  }

  void setUserEmail(userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', userEmail);
  }

  void setUserPhone(userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userPhone', userPhone);
  }

  void signIn(phone, password, context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.all(0),
              content: StatefulBuilder(
                  builder: (BuildContext context,i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Loading...",
                          style: b18W5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }));
        });
        await getDeviceId();
    repo.signIn(phone, password, deviceId, context).then((value) async {
      if (value["status"] == "1") {
          loginData = value["data"];
        setUserId(loginData[0]["user_id"].toString());
        setUserName(loginData[0]["user_name"].toString());
        setUserEmail(loginData[0]["user_email"].toString());
        setUserPhone(loginData[0]["user_phone"].toString());
        USERID=loginData[0]["user_id"].toString();
          setState(() { });
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bottomtabs()));
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }

  void signup(uname, phone, email, password, context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(0),
          content: StatefulBuilder(
            builder: (context,state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Loading...",
                        style: b18W5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
    repo
        .signupp(uname, phone, email, password, deviceId, context)
        .then((value) async {
      print(value);
      print(value["status"]);
      if (value["status"] == "1") {
        setUserId(value["data"]["user_id"].toString());
        setUserName(value["data"]["user_name"].toString());
        setUserPhone(value["data"]["user_phone"].toString());
        setUserEmail(value["data"]["user_email"].toString());

        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Otppage(
                      phon: value["data"]["user_phone"].toString(),
                    )));
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }

  Future forgotPassword(phone, context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.all(0),
              content: StatefulBuilder(
                  builder: (context,state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Loading...",
                          style: b18W5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }));
        });
    repo.forgotPassword(phone, context).then((value) async {
      if (value["status"] == "2") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }
}
