import 'dart:convert';
import 'package:baacstaff/models/BaacMapBranch.dart';
import 'package:baacstaff/models/BaacTimeDetailModel.dart';
import 'package:baacstaff/models/NewsModel.dart';
import 'package:baacstaff/models/TimeDetailModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:baacstaff/models/RegisterModel.dart';

class CallAPI {

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };
  
  _setBAACHeaders() => {
    'Content-Type':'application/x-www-form-urlencoded',
    'Accept': 'application/json'
  };
  
  final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api/';
  final String baseURLBAAC = 'https://dinodev.baac.or.th/wsBEM/';
  final String baseURLBAACV2 = 'https://dinodev.baac.or.th/wsBEMV2/';

  // Register API
  postData(data, apiURL) async {
    var fullURL = baseAPIURL + apiURL;
    return await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  // Read Employee Detail
  Future<RegisterModel> getEmployee(data) async {
      final response = await http.post(
        baseAPIURL+'register', 
        body: jsonEncode(data),
        headers: _setHeaders()
      );
      if(response.statusCode == 200){
        return registerModelFromJson(response.body);
      }else{
        return null;
      }
  }

  // Read News
  Future<List<NewsModel>> getNews() async{
    var result = await Connectivity().checkConnectivity();
    
    if (result == ConnectivityResult.none) {
      return null;
    }else{
      final response = await http.get(
        baseAPIURL+'news',
        headers: _setHeaders()
      );
      if(response.body != null){
        return newsModelFromJson(response.body);
      }else{
        return null;
      }
    }
  }

  // Check In/Out working time
  checkInAndOut(data, apiURL) async {
    var fullURL = baseURLBAAC + apiURL;
    return await http.post(
      fullURL,
      body: data,
      headers: _setBAACHeaders(),
      encoding: Encoding.getByName("utf-8")
    );
  }

  // Read Time Detail
  Future<List<TimeDetailModel>> getTimeDetail() async{
    var result = await Connectivity().checkConnectivity();
    
    if (result == ConnectivityResult.none) {
      return null;
    }else{
      final response = await http.get(
        baseAPIURL+'timeDetail',
        headers: _setBAACHeaders()
      );
      if(response.body != null){
        return timeDetailModelFromJson(response.body);
      }else{
        return null;
      }
    }
  }

  // Read BAAC Location branch
  Future<BaacMapBranch> getBAACBranch() async {

    var result = await Connectivity().checkConnectivity();
    
    if (result == ConnectivityResult.none) {
      return null;
    }else{
      final response = await http.get(
        baseAPIURL+'baacbranch',
        headers: _setHeaders()
      );
      if(response.body != null){
        return baacMapBranchFromJson(response.body);
      }else{
        return null;
      }
    }  
  }


  // BAAC Post Time Detail
  Future<List<BaacTimeDetailModel>> baacPostTimeDetail(data) async {

    final response = await http.post(
      baseURLBAACV2+'TimeDetail', 
      body: data,
      headers: _setBAACHeaders(),
      encoding: Encoding.getByName("utf-8")
    );
    if(response.statusCode == 200){
      return baacTimeDetailModelFromJson(response.body);
    }else{
      return null;
    }

  }
}