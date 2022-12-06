// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe
import 'dart:io';

import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/Login/espera.dart';
import 'package:SOP/src/views/ui/login/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreem extends StatefulWidget {
  @override
  _LoginScreemState createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  late Box box;
  final androidStrings = const AndroidAuthMessages(
    cancelButton: 'cancelar',
    biometricHint: ' ',
    //fingerprintNotRecognized: 'Impressão digital não encontrada!',
    //fingerprintRequiredTitle: 'teste3',
    //goToSettingsButton: 'teste4',
    //goToSettingsDescription: 'teste5',
    signInTitle: 'Login por impressão digital',
    //fingerprintSuccess: 'Autenticação efetuada com sucesso!'
  );
  String nome = '';
  @override
  void initState() {
    super.initState();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _localAuthentication.canCheckBiometrics;
      return isAvailable;
    } catch (e) {
      return false;
    }
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
    //print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    if (Platform.isAndroid) {
      bool isAuthenticated =
          await _localAuthentication.authenticateWithBiometrics(
              localizedReason: 'Use a biometria para efetuar o login.',
              useErrorDialogs: true,
              stickyAuth: true,
              sensitiveTransaction: true,
              androidAuthStrings: androidStrings);
      if (isAuthenticated) {
        FuncoesAPI().contaUsuario(
            BlocProvider.of<LoginBloc>(context).user2,
            BlocProvider.of<LoginBloc>(context).pass2,
            BlocProvider.of<LoginBloc>(context).user,
            BlocProvider.of<LoginBloc>(context).pass,
            context);
      }
    }
  }

  Future lembrarNome() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    box = await Hive.openBox('preferencias');
    String usuarioNomeLogin = box.get("usuarioNomeLogin");
    return usuarioNomeLogin;
  }

  Future lembrarSenha() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    box = await Hive.openBox('preferencias');
    String usuarioSenhaLogin = box.get("usuarioSenhaLogin");
    return usuarioSenhaLogin;
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    String senha = '';
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: test, //Desabilitar

      body: FutureBuilder(
          future: lembrarSenha(),
          builder: (context, pass) {
            return FutureBuilder(
                future: lembrarNome(),
                builder: (context, value) {
                  if (pass.hasData) {
                    if (value.hasData) {
                      if (i == 0 &&
                          BlocProvider.of<LoginBloc>(context)
                                  .textFieldEstaAtivada ==
                              false &&
                          value.data.toString().isNotEmpty) {
                        BlocProvider.of<LoginBloc>(context).user.text =
                            value.data.toString();
                        BlocProvider.of<LoginBloc>(context).user2 =
                            value.data.toString();

                        if (i == 0 &&
                            BlocProvider.of<LoginBloc>(context)
                                    .textFieldSenhaEstaAtivada ==
                                false &&
                            pass.data.toString().isNotEmpty) {
                          BlocProvider.of<LoginBloc>(context).temSenha = true;
                          BlocProvider.of<LoginBloc>(context).pass2 =
                              pass.data.toString();
                          senha = pass.data.toString();
                          authenticate();
                        }
                      }

                      i++;
                    }
                  }

                  return BlocBuilder<LoginBloc, LoginState>(
                    bloc: BlocProvider.of<LoginBloc>(context),
                    builder: (context, state) {
                      if (state is LoginErrorConectionState) {
                        return Center(child: Text(state.message));
                      }
                      if (state is LoginErrorState) {
                        Future.delayed(Duration(seconds: 1),
                            () => MensagemLogin.erroLogin(context));
                        BlocProvider.of<LoginBloc>(context)
                            .textFieldEstaAtivada = false;
                        BlocProvider.of<LoginBloc>(context)
                            .textFieldSenhaEstaAtivada = false;
                      }
                      if (state is ButtonLoginPressedProcessingState) {
                        if (state.isConnected) {
                          if (BlocProvider.of<LoginBloc>(context)
                              .pass
                              .text
                              .isNotEmpty) {
                            FuncoesAPI().contaUsuario(
                                BlocProvider.of<LoginBloc>(context).user2,
                                BlocProvider.of<LoginBloc>(context).pass2,
                                BlocProvider.of<LoginBloc>(context).user,
                                BlocProvider.of<LoginBloc>(context).pass,
                                context);
                          } else {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginGetConnection(),
                            );
                          }
                        } else {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginNoConnection());
                        }
                      }

                      if (state is LoginNormalState) {
                        return Stack(
                          children: [
                            Container(
                              //Aqui esta o principal
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFfff9f9),
                                  Color(0xFFfff9f9),
                                  Color(0xFFFFFFFF),
                                  Color(0xFFFFFFFF),
                                ],
                                stops: [0.2, 0.4, 0.7, 0.9],
                              )),
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      //height: 100,

                                      // margin: EdgeInsets.only(bottom: 2),
                                      child: Row(
                                        children: [
                                          Stack(
                                            //alignment: Alignment.topCenter,
                                            children: [
                                              FittedBox(
                                                child: Container(
                                                  //alignment: Alignment.topCenter,
                                                  width: largura * 1,
                                                  // height: MediaQuery.of(context).size.height ,
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: SvgPicture.asset(
                                                          "assets/images/login.svg",
                                                          width: largura * 0.9,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          // alignment: Alignment.topCenter,
                                                          width: largura / 1.4,
                                                          height: largura / 4,

                                                          margin:
                                                              EdgeInsets.only(
                                                            top: largura / 4,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      30.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      30.0),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                // color: Colors.amberAccent,
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                                spreadRadius: 6,
                                                                blurRadius: 0.1,
                                                                offset: Offset(
                                                                    0, 0),
                                                              ),
                                                            ],
                                                          ),
                                                          //margin: EdgeInsets.only(top: 65),
                                                          child: Image.asset(
                                                            "assets/images/keve_exe.jpg",
                                                            scale: 0.8,
                                                          ), //logo da aplicação
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                3,
                                                          ),
                                                          child: Text(
                                                            "Bem vindo!",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF3b98d4),
                                                                fontFamily:
                                                                    "SEGOEUI",
                                                                fontSize: 27,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          //Logo
                                        ],
                                      ), //logo da aplicação
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //Container de Autenticação
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                //AlwaysScrollableScrollPhysics() habilitar scrol  NeverScrollableScrollPhysics()

                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.006,
                                  vertical: MediaQuery.of(context).size.height /
                                      2.8, //Era 7
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 80, bottom: 1),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(42.0),

                                            /*border: Border.all(
                                          color:  Color(0xFFD50000),
                                        ),*/
                                          ),
                                          child: Column(
                                            children: [
                                              //SizedBox(height: 35.0),
                                              /*
                                         Container com img do banco*/
                                              /*
                                              Conteiner com os dizeres autenticação
                                          */

                                              SizedBox(height: largura * 0.03),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Linha Horizontal por cima do login
                                                  Center(
                                                    child: Container(
                                                      height: 7,
                                                      width: largura * 0.2,
                                                      //color: Colors.grey,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset:
                                                                  Offset(0, 7),
                                                              blurRadius: 40,
                                                              color: Color(
                                                                  0xfEEEEEE)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 21,
                                                            bottom: 10),
                                                    child: Text(
                                                      'Login',
                                                      style: TextStyle(
                                                        fontFamily: "Ubuntu",
                                                        color:
                                                            Color(0xFF2b395b),
                                                        fontSize: 26,
                                                        letterSpacing: 1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: largura * 0.01,
                                                  ),

                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20,
                                                            left: 20),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xFFf9f9f9),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 7),
                                                            blurRadius: 40,
                                                            color: Color(
                                                                0xfEEEEEE)),
                                                      ],
                                                    ),
                                                    height: 60,
                                                    child: GestureDetector(
                                                      onDoubleTap: () {
                                                        setState(() {
                                                          BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .textFieldEstaAtivada = true;
                                                        });
                                                      },
                                                      child: TextField(
                                                        enabled: value
                                                                    .hasData ==
                                                                false
                                                            ? true
                                                            : BlocProvider.of<
                                                                        LoginBloc>(
                                                                    context)
                                                                .textFieldEstaAtivada,
                                                        onChanged: (text) {
                                                          setState(() {
                                                            BlocProvider.of<
                                                                        LoginBloc>(
                                                                    context)
                                                                .user2 = text;
                                                          });
                                                        },

                                                        controller: BlocProvider
                                                                .of<LoginBloc>(
                                                                    context)
                                                            .user,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF2b395b),
                                                          fontFamily: "Ubuntu",
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 18,
                                                        ),
                                                        // obscureText: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Utilizador',
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            top: 16.0,
                                                            //right: 2,
                                                          ),

                                                          prefixIcon: Container(
                                                            width: 35,
                                                            height: 35,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Material(
                                                              color:
                                                                  Colors.blue,
                                                              // elevation: 2.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          95),
                                                              child: Icon(
                                                                  Icons
                                                                      .person_outline,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),

                                                          // hintText: 'Senha',
                                                          //hintStyle: TextStyle(color: Color(0xFF616161)),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  //
                                                ],
                                              ),
                                              SizedBox(
                                                height: largura * 0.05,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  /*  height
                                                  Tinha o texto para Senha
                                              */

                                                  SizedBox(
                                                    height: largura * 0.001,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20,
                                                            left: 20),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xFFf9f9f9),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 7),
                                                            blurRadius: 40,
                                                            color: Color(
                                                                0xfEEEEEE)),
                                                      ],
                                                    ),
                                                    height: 60,
                                                    child: GestureDetector(
                                                      onDoubleTap: () {
                                                        setState(() {
                                                          BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .textFieldSenhaEstaAtivada = true;
                                                        });
                                                      },
                                                      child: TextField(
                                                        enabled: BlocProvider.of<
                                                                            LoginBloc>(
                                                                        context)
                                                                    .temSenha ==
                                                                false
                                                            ? true
                                                            : BlocProvider.of<
                                                                        LoginBloc>(
                                                                    context)
                                                                .textFieldSenhaEstaAtivada,
                                                        onChanged: (text) {
                                                          setState(() {
                                                            BlocProvider.of<
                                                                        LoginBloc>(
                                                                    context)
                                                                .pass2 = text;
                                                          });
                                                        },
                                                        controller: BlocProvider
                                                                .of<LoginBloc>(
                                                                    context)
                                                            .pass,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF2b395b),
                                                          fontFamily: "Ubuntu",
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 18,
                                                        ),
                                                        // textAlign: TextAlign.values(1,2),
                                                        obscureText: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Senha',
                                                          //hintTextDirection:TextDirection.ltr,
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            top: 16.0,
                                                          ),

                                                          prefixIcon: Container(
                                                            width: 35,
                                                            height: 35,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Material(
                                                              color:
                                                                  Colors.blue,
                                                              // elevation: 2.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          95),
                                                              child: Icon(
                                                                  Icons.lock,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              //Botão
                                              SizedBox(
                                                height: largura * 0.01,
                                              ),
                                              //Botão Entrar
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0),
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                    right: 20, left: 20),
                                                child: SizedBox(
                                                  height: 60, //altura do button
                                                  width: 150, //Largura button
                                                  child: BlocBuilder<LoginBloc,
                                                          LoginState>(
                                                      //bloc: BlocProvider.of<LoginBloc>(context),
                                                      builder:
                                                          (context, state) {
                                                    return ElevatedButton(
                                                      //  elevation: 5.0,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          //side: BorderSide(color: Colors.red)
                                                        ),
                                                        primary: Color(
                                                            0xFF3b98d4), // background
                                                        onPrimary: Colors
                                                            .white, // foreground
                                                      ),
                                                      onPressed: ((BlocProvider.of<
                                                                              LoginBloc>(
                                                                          context)
                                                                      .pass
                                                                      .text
                                                                      .isEmpty ||
                                                                  BlocProvider.of<
                                                                              LoginBloc>(
                                                                          context)
                                                                      .user
                                                                      .text
                                                                      .isEmpty) ==
                                                              true)
                                                          ? () {
                                                              BlocProvider.of<
                                                                          LoginBloc>(
                                                                      context)
                                                                  .add(
                                                                      LoginExecutedError());
                                                            }
                                                          : () {
                                                              BlocProvider.of<
                                                                          LoginBloc>(
                                                                      context)
                                                                  .add(
                                                                      LoginProcessing());
                                                            },

                                                      child: Text("Login",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Ubuntu",
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  1.5,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              SizedBox(
                                                height: largura * 0.02,
                                              ),
                                              Container(
                                                child: Text(
                                                  "Ao iniciar a sessão concordará com os nossos ",
                                                  style: TextStyle(
                                                      color: Color(0xFF616161),
                                                      fontFamily: "Ubuntu",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  " termos de serviço & Politicas de privacidade",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontFamily: "Ubuntu",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return IndicadorProgressoCircularUI();
                    },
                  );
                });
          }),
    );
  }
}
