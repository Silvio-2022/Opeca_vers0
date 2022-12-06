import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/Login/logar.dart';
import 'package:SOP/src/views/ui/main/hiveConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Função Raiz da App, que define a tela principal
void main() async{
  WidgetsFlutterBinding
      .ensureInitialized();
  await HiveConfig.start();
      
  //Forçar o modo retrato para Aplicação Inteira
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<LoginBloc>(
        create: (_) {
          return LoginBloc(LoginNormalState())..add(LoginGetConnection());
        },
        child: LoginScreem(),
      ),
    );
  }
}
