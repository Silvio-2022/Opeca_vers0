import 'package:flutter/material.dart';

import 'HomeTeste.dart';
import 'loginApi.dart';

class LoginPage extends StatelessWidget {
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acesso", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            _textFormField("Login", "Digite o Login",
                controller: _ctrlLogin),
            _textFormField("Senha", "Digite a Senha",
                senha: true, controller: _ctrlSenha),
            _raisedButton("Login", Colors.orange, context),
          ],
        ),
      ),
    );
  }

  _textFormField(
    String label,
    String hint, {
    bool senha = false,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: senha,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  String _validaLogin() {
    
    return "ola";
  }

  String _validaSenha(String texto) {
    if (texto.isEmpty) {
      return "Digite a Senha";
    }
    return "";
  }

  _raisedButton(String texto, Color cor, BuildContext context) {
    return RaisedButton(
      color: cor,
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onPressed: () {
        _clickButton(context);
      },
    );
  }

  _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;

   // print("login : $login senha: $senha");

   // var response = await Token.token(login, senha);

    /*if (response) {
      _navegaHomepage(context);
    }*/
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
