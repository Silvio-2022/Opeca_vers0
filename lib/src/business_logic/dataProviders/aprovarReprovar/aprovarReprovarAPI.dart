import 'dart:convert';

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AprovarReprovarAPI {
  Future<Map<String, dynamic>> buscaDetalhes(
      String applicationID, String operationID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //print('ApID ' + applicationID);
    //print('OpID ' + operationID);
    var url = Uri.parse(
        'http://83.240.225.239:130/api/OperationData?ApplicationID=$applicationID&OperationID=$operationID');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await http.get(url, headers: header);
    Map<String, dynamic> userMap = jsonDecode(response.body);

    return userMap;
  }
  //Fim da função pegar os detalhes da

  Future<Map<String, dynamic>> aprovarReprovarAcao(
      String stepCode,
      String stepComment,
      int applicationID,
      int operationID,
      int operationCodID,
      int stepID,
      int sourceID,
      int userID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('http://83.240.225.239:130/api/Workflow');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = {
      'StepCode': stepCode, // -> aprovar "REJECT" -> rejeitar,
      'StepComment': stepComment, // -> quando rejeita,
      'ApplicationID': applicationID,
      'OperationID': operationID,
      'OperationCodID': operationCodID,
      'StepID': stepID,
      'SourceID': sourceID,
      'UserID': userID
    };
    var response = await http.post(url, headers: header, body: jsonEncode(body));
    Map<String, dynamic> userMap = jsonDecode(response.body);
    return userMap;
  }

  Future<String> buscaPdf(String operationID, String contentID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/File?OperationID=$operationID&ContentID=$contentID');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await http.get(url, headers: header);
    return jsonDecode(response.body).toString();
  }
}
