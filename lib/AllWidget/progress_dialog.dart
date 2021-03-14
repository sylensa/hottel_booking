import 'package:flutter/material.dart';
import 'package:hottel_booking/helper/helper.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: appColors(2),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(width: 6,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(width: 15,),
            appText("$message",col: Colors.white,z: 14)
          ],
        ),
      ),
    );
  }
}
