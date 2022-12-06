import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SistemasAPI {
  Future<Map<String, dynamic>> getSystems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accountID = (sharedPreferences.getString("IdAccount") ?? "");
    var url =
        Uri.parse('http://83.240.225.239:130/api/Systems?AccountID=$accountID');
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
