import 'package:baacstaff/screens/bottomnav/benefit_screen.dart';
import 'package:baacstaff/screens/bottomnav/checkin_screen.dart';
import 'package:baacstaff/screens/bottomnav/employee_screen.dart';
import 'package:baacstaff/screens/bottomnav/fundloan_screen.dart';
import 'package:baacstaff/screens/bottomnav/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้าง Object SharedPreferences 
  SharedPreferences sharedPreferences;

  // สร้างตัวแปร ไว้เก็บชื่อและอีเมล์ผู้ใช้
  String fullnameAccount, empIDAccount, avatarURL;

  // สร้างตัวแปร List เก็บรายการหน้าที่ต้องการเปลี่ยนใน Bottom Navigationbar
  int _currentIndex = 0;
  String _title;

  @override
  void initState() { 
    super.initState();
    _title = 'หน้าหลัก';
    // ตรวจข้อมูล sharedPreferences ของผู้ใช้
    checkLoginStatus();
  }

  // Check Login Status
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullnameAccount = sharedPreferences.getString('storePrename') + sharedPreferences.getString('storeFirstname')+" "+sharedPreferences.getString('storeLastname');
      empIDAccount = sharedPreferences.getString('storeEmpID');
      avatarURL = sharedPreferences.getString('storeAvatar');
    });
    
  }

  // Sign out
  signOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  final List<Widget> _children = [
    HomeScreen(),
    BenefitScreen(),
    FundLoanScreen(),
    CheckinScreen(),
    EmployeeScreen()
  ];

  // สร้าง method สำหรับการเปลี่ยนหน้า
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;

      switch (index) {
        case 0: _title = 'หน้าหลัก';
          break;
        case 1: _title = 'สวัสดิการ';
          break;
        case 2: _title = 'กองทุนกู้ยืมเพื่อสวัสดิการ';
          break;
        case 3: _title = 'ลงเวลาเข้าออกงาน'; 
          break;
        case 4: _title = 'ข้อมูลของฉัน'; 
          break;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(_title),
      ),

      // ส่วนของ Drawer Menu
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () { },
                  child: CircleAvatar(
                    // backgroundImage: NetworkImage('$avatarURL')
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ),
                accountName: Text('$fullnameAccount'), 
                accountEmail: Text('$empIDAccount'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/greenbg3.jpg'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('ข้อมูลข่าวสาร ธกส.'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/baacnews');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('ข้อมูลพนักงาน '),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: Text('สวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: Icon(Icons.data_usage),
                title: Text('กองทุนกู้ยืมเพื่อสวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('ลงเวลาทำงาน'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text('พื้นที่ให้บริการ'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/servicemap');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('ถ่ายภาพและอัพโหลด'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/camera_and_upload');
                },
              ),
              Divider(color: Colors.green[200],),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: (){
                  signOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('ยกเลิกการลงทะเบียน'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cancelaccount');
                },
              ),
            ],
          ),
        )
      ),

      body:_children[_currentIndex],

    // Bottom Navigationbar
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex,
       type: BottomNavigationBarType.fixed,
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('หน้าหลัก', style: TextStyle(fontSize: 16),)),
         BottomNavigationBarItem(icon: Icon(Icons.enhanced_encryption), title: Text('สวัสดิการ', style: TextStyle(fontSize: 16),)),
         BottomNavigationBarItem(icon: Icon(Icons.account_balance), title: Text('กองทุน', style: TextStyle(fontSize: 16),)),
         BottomNavigationBarItem(icon: Icon(Icons.access_time), title: Text('ลงเวลา', style: TextStyle(fontSize: 16),)),
         BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('ฉัน', style: TextStyle(fontSize: 16),)),
       ]
      ),

    );
  }
  
}