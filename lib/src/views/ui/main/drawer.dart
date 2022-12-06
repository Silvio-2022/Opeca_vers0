import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/Header/my_header_drawer.dart';
import 'package:SOP/src/views/ui/Login/logar.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int isActivated = 0;
  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<LoginBloc>(
            create: (_) {
              return LoginBloc(LoginNormalState())..add(LoginGetConnection());
            },
            child: LoginScreem(),
          );
        },
      ),
    );
  }

  openMain(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<MainBloc>(
            create: (_) {
              return MainBloc(MainOpeningState())..add(MainOpenning());
            },
            child: Home(),
          );
        },
      ),
    );
  }

  void changedSelected(String paginaDestino, BuildContext context) {
    setState(() {
      if (paginaDestino == "Dashboard") {
        openMain(context);
      } else {
        logout(context);

        //BlocProvider.of<LoginBloc>(context).add(LoginProcessing1());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            MyHeaderDrawer(),
            ListTile(
              leading: Icon(Icons.dashboard_outlined),
              title: Text(
                'Dashboard',
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {
                changedSelected("Dashboard", context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {
                changedSelected("Sair", context);
              },
            )
          ],
        ),
      ),
    );
  }
}
