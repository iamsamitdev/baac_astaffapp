import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:baacstaff/utils/utility.dart';
import 'package:baacstaff/services/rest_api.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {

  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // สร้างตัวแปรสำหรับผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  String empID, cizID;

  // สร้างตัวแปรไว้เก็บค่า IMEI และ MacAddress ของเครื่อง
  String _imeiNumber;
  String _macAddress;

  // ฟังก์ชันอ่านข้อมูล IMEI และ Mac Address
  Future<void> initPlatformState() async {
    String imeiNumber = "Unknown";
    String macAddress = "Unknown";
    
    try{
      imeiNumber = await ImeiPlugin
                  .getImei(shouldShowRequestPermissionRationale: false);
      macAddress = await GetMac.macAddress;
    }on PlatformException{
      macAddress = "Faild to get Device MAC Address";
    }

    if(!mounted) return;

    setState(() {
      _imeiNumber = imeiNumber;
      _macAddress = macAddress;
    });

  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/baac_bgstaff_register.jpg'),
              fit: BoxFit.fill
            )
          ),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/astaff_logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      size: 28,
                                    ),
                                    labelText: 'รหัสพนักงาน',
                                    errorStyle: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  maxLength: 7,
                                  // initialValue: '5601965',
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'กรุณากรอกรหัสพนักงานก่อน';
                                    }else if(value.length != 7){
                                      return 'กรุณาป้อนรหัสพนักงาน 7 หลัก';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onSaved: (value){
                                    empID = value.trim();
                                  },
                                ),
                                TextFormField(
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 20, color: Colors.teal),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.credit_card,
                                      size: 28,
                                    ),
                                    labelText: 'เลขบัตรประชาชน',
                                    errorStyle: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  maxLength: 13,
                                  // initialValue: '7127225663620',
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'กรุณากรอกเลขบัตรประชาชนก่อน';
                                    }else if(value.length != 13){
                                      return 'กรุณาป้อนบัตรประชาชน 13 หลัก';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onSaved: (value){
                                    cizID = value.trim();
                                  },
                                ),
                              ],
                            ),
                          ), 
                        ),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        onPressed: (){
                          // Navigator.pushNamed(context, '/consent');
                          // Call API Register
                          
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            var empData = {
                              'empid':empID,
                              'cizid':cizID
                            };
                            _register(empData);
                          }

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: Text(
                            'ลงทะเบียน', 
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      )
                    ],
                    ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันเช็คการลงทะเบียน
  void _register(empData) async {

    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต','ตกลง');
    }else{

      // สร้างตัวเก็บข้อมูลแบบ SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      var response = await CallAPI().postData(
        empData, 
        'register'
      );

      var body = json.decode(response.body);
      // Print firstname and lastname
      print(body['code']);
      // print(body['data']['firstname']);
      // print(body['data']['lastname']);

      if(body['code']=='200'){

        // การสร้างตัวแปรเก็บลง sharedPreferences
        sharedPreferences.setString('storeIMEI', _imeiNumber); // เก็บ EMEI 
        sharedPreferences.setString('storeMac', _macAddress); // เก็บ MacAddress 
        sharedPreferences.setString('storeEmpID', body['data']['empid']); // รหัสพนักงาน
        sharedPreferences.setString('storeCizID', body['data']['cizid']); // บัตรประชาชน
        sharedPreferences.setString('storePrename', body['data']['prename']);
        sharedPreferences.setString('storeFirstname', body['data']['firstname']);
        sharedPreferences.setString('storeLastname', body['data']['lastname']);
        sharedPreferences.setString('storePosition', body['data']['position']);
        sharedPreferences.setString('storeAvatar', body['data']['avatar']);
        sharedPreferences.setInt('storeStep', 1);

        Navigator.pushReplacementNamed(context, '/consent');

      }else{
        Utility.getInstance().showAlertDialog(context, 'มีข้อผิดพลาด', 'ข้อมูลที่ใช้ลงทะเบียนไม่ถูกต้อง','ตกลง');
      }

    }

  }


}