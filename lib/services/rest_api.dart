import 'dart:convert';

// import 'package:baacstaff/utils/ConnectionStatusSingleton.dart';
import 'package:baacstaff/utils/constant.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  // Check Internet connectivity
  // CallAPI(){
  //   ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  //   connectionStatus.initialize();
  // }

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };
  
  // final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api/';

  // Register API
  postData(data, apiURL) async {
    var fullURL = baseAPIURL + apiURL;
    return await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }
  

}