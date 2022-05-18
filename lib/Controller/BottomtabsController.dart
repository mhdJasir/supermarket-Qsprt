

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:supermarket/Repository/BottomtabsReposi.dart'as repo;
import '../View/GlobalVar.dart';
class BottomController extends ControllerMVC{

List pordrdetails,pastorder;


var userid;
void pendingordr()async{

   repo.pndingodr(USERID).then((value) {
      setState(() {
        pordrdetails = value;
      });
      }
    );


  }
void pasorder()async{


  repo.pstorder(USERID).then((value) {
    setState(() {
      pastorder = value;
    });

    print("Finallll"+pastorder.toString());
    print(pastorder[0]["order_status"]);
    print(pastorder[0]["time_slot"]);

  }
  );


}

}