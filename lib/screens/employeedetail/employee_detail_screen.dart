import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeDetailScreen({Key key}) : super(key: key);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลพนักงาน'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('นายสามิตร โกยม'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสพนักงาน'),
            subtitle: Text('5708959'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('เพศ'),
            subtitle: Text('ชาย'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('พนักงานระบบงานคอมพิวเตอร์ 7'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('ฝ่ายปฎิบัติการเทคโนโลยีสารสนเทศน์'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('99,999.00'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('17/05/2520'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล์'),
            subtitle: Text('samit@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('เบอร์โทรศัพท์'),
            subtitle: Text('089-597-8894'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('3/449 ladprao bangkok 20000'),
          ),
        ],
      ),
    );
  }
}