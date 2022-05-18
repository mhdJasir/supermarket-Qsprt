


import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Constants.dart';
import '../Model/ApiModel.dart';
import '../Utils/NetworkUtils.dart';
import '../View/GlobalVar.dart';

class ProfileController extends GetxController{

Map profileData={}.obs;
 Future getProfileData()async{
    var url=NetworkUtils.myprofile;
    var body={
    "user_id":USERID
    };
    var data=await httpPost(url,body: body);
    if(data["status"]=="1"){
      profileData=data["data"];
    }
  }

  Future editProfile(name,email,phone)async{
  await getDeviceId();
    var url=NetworkUtils.profile_edit;
    var body={
      "user_id":USERID,
      "device_id":deviceId.toString(),
      "user_name":name,
      "user_email":email,
      "user_phone":phone,
    };
    var data= await httpPost(url,body: body);
    Fluttertoast.showToast(msg: data['message']);
    if(data["status"]=="1"){

    }
  }
}