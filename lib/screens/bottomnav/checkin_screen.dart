import 'package:baacstaff/services/rest_api.dart';
import 'package:baacstaff/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({Key key}) : super(key: key);

  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {

  getTimeDetail() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต','ตกลง');
    }else{
      var response = await CallAPI().getTimeDetail();
      print(response.first.empId);
      print(response.first.date);
      print(response.first.time);
      print(response.first.type);
    }
  }

  @override
  void initState() {
    super.initState();
    getTimeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text('เนื้อหาหน้าลงเวลาเข้าออกงาน'),
       ),
    );
  }
}