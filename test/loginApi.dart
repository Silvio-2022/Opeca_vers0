import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Uri tokenUrl = Uri.parse('http://83.240.225.239:130/token');

const clientId = 'tobeadmin';
const clientSecret = '!qaz2wsx';

class LoginApi {
  static Future<bool> login(String user, String password) async {
    var url = Uri.parse('http://83.240.225.239:130/api/Authenticate');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};

    Map params = {"Username": user, "Password": password};
    String para = 'grant_type=password&username=' +
        clientId +
        '&password=' +
        clientSecret;
    var jsonResponse;
    var _body = json.encode(params);
    var _body2 = json.encode(para);
    //print("json enviado : $_body");
    //print("json enviado : $_body2");

    var response = await http.post(url, headers: header, body: _body);
    var response2 = await http.post(tokenUrl, body: _body2);

    
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    //print('Response body: ${response2.body}');

    Map mapResponse = json.decode(response.body);
    Map mapResponse2 = json.decode(response2.body);
    //sharedPreferences.setString("token", mapResponse['token']);
    /*token() async{
         var res = await http.post(tokenUrl, body:'grant_type=password&username=' + clientId + '&password=' + clientSecret );
      
    }*/
    String mensagem = mapResponse["message"];
    String token = mapResponse["token"];
    String mensagem2 = mapResponse2["message"];
    String token2 = mapResponse2["token"];

    //print("message $mensagem");
    //print("token $token");
    //print("message $mensagem2");
    //print("token $token2");
    return true;
  }
}
