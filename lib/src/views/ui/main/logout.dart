import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  //LoginBloc login = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0),
      child: IconButton(
        onPressed: () async {
          //SharedPreferences prefs = await SharedPreferences.getInstance();
          //String? usuarioNomeLogin = prefs.getString("usuarioNomeLogin");
          //String? usuarioSenhaLogin = prefs.getString("usuarioSenhaLogin");
          //prefs.clear();

          //SharedPreferences prefs2 = await SharedPreferences.getInstance();
          //prefs.setString('usuarioNomeLogin', usuarioNomeLogin!);
          //prefs.setString('usuarioSenhaLogin', usuarioSenhaLogin!);
          //login.add(LoginGetConnection());
          //BlocProvider.of<LoginBloc>(context).add(LoginGetConnection());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider<LoginBloc>(
                  create: (_) {
                    return LoginBloc(LoginNormalState())
                      ..add(LoginGetConnection());
                  },
                  child: LoginScreem(),
                );
              },
            ),
          );
        },
        icon: Image.asset(
          'assets/images/logout.png',
          scale: 0.01,
        ),
        iconSize: 30,
      ),
    );
  }
}
