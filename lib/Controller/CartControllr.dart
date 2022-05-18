import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:supermarket/Repository/CartRepo.dart' as repo;
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Functions/Components.dart';
import '../Functions/location.dart';
import '../Model/Loaders.dart';
import '../View/Screen/Cart/Selctaddress.dart';
import '../View/Screen/Cart/ordercomplrted.dart';

class CartController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  var userLocation;
  var checkdata;
  List viewAddresses = [];
  List UserAddress = [];
  List timeslotlist = [];
  CartController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void timeSlot(dateFormat) {
    final displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final serverFormatter = DateFormat('yyyy-MM-dd');
    final displayDate = displayFormatter.parse(dateFormat.toString());
    final formatted = serverFormatter.format(displayDate);
    repo.timeslot(formatted).then((value) {
      if (value["status"].toString() == "1") {
        setState(() {
          timeslotlist = value["data"];
        });
        print(timeslotlist);
      } else {
        Fluttertoast.showToast(
            msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void addadress(pin, housno, socity, lndmrk, name, phon, contxt) async {
    showLoading(contxt);
    var first = await getLocation();
    var loc = await locateUser();
    var city = first.administrativeArea;
    var lat = loc.latitude.toString();
    var lng = loc.longitude.toString();
    repo.addAddress(
            pin, housno, socity, lndmrk, name, phon, lat, lng, city)
        .then((value) {
      Navigator.pop(contxt);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
            msg: value["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            contxt, MaterialPageRoute(builder: (context) => SelectAddress()));
      }
      else Fluttertoast.showToast(msg: "something went wrong");
      Navigator.pop(contxt);
    });
  }

  void checkout(pmod, pstts, wallet, context) async {
    print(pmod);
    print(pstts);
    await repo.checkoutdataas(pmod, pstts, wallet).then((value) {
      print(value.toString());
      print(value["message"]);
      if (value["status"] == "1") {
        setState(() {
          checkdata = value;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OrderCompleted(
                      checkdta: checkdata,
                    )));
      } else {
        Fluttertoast.showToast(
          msg: 'Please Select Payment Method',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });
  }

  Future editAddress(addressId,
      name, mobileNumber, city, society, house, landMark, pin, context) async {
    showLoading(context);
    var userLocation = await locateUser();
    var lat = userLocation.latitude;
    var lng = userLocation.longitude;
    await repo
        .editAddress(addressId,
            name, mobileNumber, city, society, house, landMark, pin, lat, lng)
        .then((value) {
      Navigator.pop(context);
      if (value != null) {
        Fluttertoast.showToast(msg: value['message']);
        if (value['status'] == "1") {
          moveBack(context, SelectAddress());
        }
      }
    });
  }

  void viewAddress(context) async {
    await repo.getAddresses().then((value) {
      if (value["status"] == "1") {
        setState(() {
          viewAddresses = value["data"];
        });
        print(viewAddresses);
      }
      else Fluttertoast.showToast(msg: value['message']);
    });
  }
}
