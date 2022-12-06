import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:SOP/src/views/ui/main/logout.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/main/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (BlocProvider.of<MainBloc>(context).estaLogado == true)
            ? Home()
            : LoginScreem(),
      );
    }),
  );
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MainBloc>(context).carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 9,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 62,
              height: 45,
              child: Image.asset(
                'assets/images/logo_app.PNG',
              ),
            ),
            Container(
             
              child: Text(
                'Portal de Operações',
                style: TextStyle(
                  fontFamily: "SEGOEUI",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: largura * 0.046,
                ),
                //textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFfff9f9), //fae0e2
        centerTitle: true,
        actions: [
          LogoutButton(),
        ],

        /* SvgPicture.asset(
          "assets/images/simbportal.svg",
          color: const Color(0xFFffb574),
        ),*/
        //leadingWidth: 65,
      ),

      backgroundColor: Colors.white, //
      body: BlocBuilder<MainBloc, MainState>(
        bloc: BlocProvider.of<MainBloc>(context),
        builder: (context, state) {
          if (state is MainNetworkErrorOpeningState) {
            return Center(child: Text(state.message));
          } else if (state is MainOpeningState) {
            return Dashboard1(
              listaSistemas: state.lista,
            );
          }
          return Container();
        },
      ),
    );
  }
}
