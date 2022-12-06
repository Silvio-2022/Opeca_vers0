import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var nome = '';
var nomeBanco = '';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  //carrega os dados do usuario
  _carregaDados() async {
    final result = await pegaDados().then((List<String> lista) {
      setState(() {
        nome = lista[0];
        nomeBanco = lista[1];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //carrega os dados do usuario ao se abrir a view
    _carregaDados();
  }

  //Obtem os dados partilhados do usuario
  Future<List<String>> pegaDados() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> listaDados = [];
    listaDados.add((sharedPreferences.getString("Nome") ?? ""));
    listaDados.add((sharedPreferences.getString("NomeBanco") ?? ""));
    return listaDados;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[900],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            /*decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/user.png'),
                
              ),
              color: Colors.white
            ),*/
            child: Image.asset(
              'assets/images/user.png',
              color: Colors.white,
              width: 55,
            ),
          ),
          Text(
            nome,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            nomeBanco,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
