import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("ยืนยันรหัสเข้าใช้งาน")),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container (
        padding: EdgeInsets.all(10.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible (
              child: Column (
                children: <Widget>[
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Icon(Icons.email, size: 100.0, color: Theme.of(context).primaryColor),
                  Container(margin: EdgeInsets.symmetric(vertical: 15.0)),
                  Container (
                    width: MediaQuery.of(context).size.width * 4/5,
                    child: Text (
                      "ป้อนรหัสที่ได้รับจากอีเมล์",
                      textAlign: TextAlign.center,
                      style: TextStyle (
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.teal
                      ),
                    ),
                  ),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: PinView (
                      count: 6, // count of the fields, excluding dashes
                      autoFocusFirstField: true, 
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500
                      ),             
                      submit: (String pin){

                        if(pin == "123456"){
                          _checkPinCode(context);
                        }else{
                          Utility.getInstance().showAlertDialog(context, 'มีข้อผิดพลาด', 'รหัสยืนยันไม่ถูกต้อง ลองใหม่','ตกลง');
                        }

                        // showDialog (
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog (
                        //       title: Text("Pin received successfully."),
                        //       content: Text("Entered pin is: $pin")
                        //     );
                        //   }
                        // );
                      } // gets triggered when all the fields are filled
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }

  void _checkPinCode(BuildContext context) async {
      // สร้างตัวเก็บข้อมูลแบบ SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('storeStep', 2);
      Navigator.pushReplacementNamed(context, '/setpassword');
  }

}