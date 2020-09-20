// import 'package:baacstaff/utils/constant.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  // สร้าง Object SharedPreferences 
  SharedPreferences sharedPreferences;

  // Sign out
  signOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: ListView(
         children: [
           Container(
             width: double.infinity,
             height: 250.0,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/images/bg_account.jpg'),
                 fit: BoxFit.cover
               )
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 CircleAvatar(
                   radius: 50,
                   backgroundColor: Color(0xffffffff),
                   child: CircleAvatar(
                     radius: 46,
                     backgroundImage: AssetImage('assets/images/avatar.jpg'),
                   ),
                 ),
                 SizedBox(height: 10,),
                 Text(
                   'นาย สามิตร โกยม',
                   style: TextStyle(fontSize: 24, color: Colors.white),
                 ),
                 Text(
                   'รหัสพนักงาน 5671985',
                   style: TextStyle(fontSize: 20, color: Colors.white),
                 ),
                 Text(
                   'พนักงานระบบคอมพิวเตอร์ 7',
                   style: TextStyle(fontSize: 16, color: Colors.white),
                 )
               ],
             ),
           ),
           ListTile(
                leading: Icon(Icons.person),
                title: Text('ข้อมูลพนักงาน'),
                onTap: (){
                  Navigator.pushNamed(context, '/employeedetail');
                },
           ),
           ListTile(
                leading: Icon(Icons.lock),
                title: Text('เปลี่ยนรหัสผ่าน'),
                onTap: (){
                  Navigator.pushNamed(context, '/changepassword');
                },
           ),
           ListTile(
                leading: Icon(Icons.email),
                title: Text('ติดต่อทีมงาน'),
                onTap: (){
                  Navigator.pushNamed(context, '/contactus');
                },
           ),
           ListTile(
                leading: Icon(Icons.language),
                title: Text('เปลี่ยนภาษา'),
                onTap: (){
                  Navigator.pushNamed(context, '/changelang');
                },
           ),
           ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: (){
                  signOut();
                },
           ),
         ],
       ),
    );
  }
}