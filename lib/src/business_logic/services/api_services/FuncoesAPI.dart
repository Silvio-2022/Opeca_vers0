import 'dart:convert';
import 'dart:io';

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/login/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FuncoesAPI {
/*
    *   Funcao para obter o token
    *   Recebe como parametro, o nome do usuario e a senha
    *   Depois de obter o token, armazena-o em um espaço alocado
  */
  static token(String usuario, String password, BuildContext context) async {
    // Url da API para obter o token
    var url = Uri.parse('http://83.240.225.239:130/token');

    //SharedPreferences - Plugin para armazenar dados, onde armazenar-se-á o token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    late Box box;
    box = await Hive.openBox('preferencias');
    //Cabeçalho da requisiçao
    var header = {"Content-Type": "application/json"};

    //Corpo da requisiçao
    String corpo = 'Username=' +
        usuario +
        '&Password=' +
        password +
        '&grant_type=password';

    // Converte a string "corpo" para uma string no formato JSON
    //var _body = json.encode(corpo);

    // Envia uma requisiçao POST com o seu devido cabeçalho e corpo à URL
    var response = await http.post(url, headers: header, body: corpo);

    //Analisa a string em "response.body" e retorna o objeto Json resultante
    Map mapResponse = json.decode(response.body);

    try {
      //Armazena os dados no local partilhado da aplicacao
      sharedPreferences.setString("access_token", mapResponse["access_token"]);
      sharedPreferences.setBool("isLoggedIn", true);
      box.put('usuarioNomeLogin', usuario);
      box.put('usuarioSenhaLogin', password);
      sharedPreferences.setString("usuarioNomeLogin", usuario);
      sharedPreferences.setString("usuarioSenhaLogin", password);
      sharedPreferences.setStringList('ListaIdOperacoesAprovadas', []);
      sharedPreferences.setStringList('ListaIdOperacoesReprovadas', []);
      //Redireciona para a tela Home

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<MainBloc>(
                  create: (_) {
                    return MainBloc(MainOpeningState())..add(MainOpenning());

                    //return MainBloc(MainOpeningState(), lista)..add(MainOpenning());
                  },
                ),
              ],
              child: Home(),
            );
          },
        ),
      );
    } catch (e) {}
  }

  //---------------------------
  //Pega os dados do user
  contaUsuario(String usuario, String password, TextEditingController user,
      TextEditingController pass, BuildContext context) async {
    var url = Uri.parse('http://83.240.225.239:130/api/Authenticate');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"Username": usuario, "Password": password};
    var response = await http.post(url, body: body);
    Map mapResponse = json.decode(response.body);

    if (mapResponse['IsValid'] == true) {
      sharedPreferences.setString(
          "NomeBanco", mapResponse['User']['Description']);
      sharedPreferences.setString("Nome", usuario);
      sharedPreferences.setString(
          "IdAccount", mapResponse['User']['IdAccount'].toString());

      token(usuario, password, context);
    } else {
      Future.delayed(Duration.zero, () => MensagemLogin.erroLogin(context));
      user.clear();
      pass.clear();
      BlocProvider.of<LoginBloc>(context).add(LoginGetConnection());
    }
  }
}
