import 'package:flutter/material.dart';

import '../View/Widgets/Style.dart';

Future<bool> showLoading(context) async {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(0),
            content: StatefulBuilder(builder: (BuildContext context, i) {
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
}
