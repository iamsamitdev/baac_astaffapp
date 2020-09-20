import 'package:baacstaff/screens/changepassword/changepassword_screen.dart';
import 'package:baacstaff/screens/consent/consent_screen.dart';
import 'package:baacstaff/screens/contactus/contactus_screen.dart';
import 'package:baacstaff/screens/dashboard/dashboard_screen.dart';
import 'package:baacstaff/screens/drawer/baac_news_screen.dart';
import 'package:baacstaff/screens/drawer/cancel_account_screen.dart';
import 'package:baacstaff/screens/employeedetail/employee_detail_screen.dart';
import 'package:baacstaff/screens/lockscreen/locksceen.dart';
import 'package:baacstaff/screens/pincode/pincode_screen.dart';
import 'package:baacstaff/screens/register/register_screen.dart';
import 'package:baacstaff/screens/setpassword/setpassword_screen.dart';
import 'package:baacstaff/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = 
<String, WidgetBuilder> {
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => Register(), 
  "/consent": (BuildContext context) => ConsentScreen(),
  "/pincode": (BuildContext context) => PinCodeScreen(),
  "/setpassword": (BuildContext context) => SetPasswordScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/baacnews": (BuildContext context) => BaacNews(),
  "/cancelaccount": (BuildContext context) => CancelAccount(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/changepassword": (BuildContext context) => ChangePasswordScreen(),
  "/employeedetail": (BuildContext context) => EmployeeDetailScreen(),
  "/contactus": (BuildContext context) => ContactusScreen(),
};