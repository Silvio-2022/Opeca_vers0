import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CardDetailAPI{


 Future<Map<String, dynamic>> getOperationsPerSystem(
      String appID, String accountID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Operation?ApplicationID=$appID&AccountID=$accountID');
    //print(url);
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await http.get(url, headers: header);
    Map<String, dynamic> userMap = jsonDecode(response.body);
    
    return userMap;
  }
}