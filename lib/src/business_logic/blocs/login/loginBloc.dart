// ignore_for_file: unused_field

import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isDeviceConnected = false;
  bool textFieldEstaAtivada = false;
  bool textFieldSenhaEstaAtivada = false;
  bool temSenha = false;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String user2 = "", pass2 = "";

  LoginBloc([LoginState? initialState]) : super(LoginNormalState()) {
    on<LoginGetConnection>((event, emit) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      emit(verificarConexao(isDeviceConnected));
    });
    on<LoginProcessing>((event, emit) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      emit(verificarCredenciais(isDeviceConnected));
    });
    on<LoginValidatingCredentials>((event, emit) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      emit(verificarCredenciais2(isDeviceConnected));
    });
    on<LoginNoConnection>((event, emit) => emit(noNetwork()));
    on<LoginExecutedError>((event, emit) => emit(erroCredenciais()));
  }

  LoginState verificarConexao(bool v) {
    if (v == true) {
      return LoginNormalState(v);
    } else {
      return LoginErrorConectionState(
          message: "Verifique a sua conexão com a internet!");
    }
  }

  LoginState verificarCredenciais(isDeviceConnected) {
    return ButtonLoginPressedState(isConnected: isDeviceConnected);
  }

  LoginState verificarCredenciais2(isDeviceConnected) {
    return ButtonLoginPressedProcessingState(isConnected: isDeviceConnected);
  }

  LoginState erroCredenciais() {
    return LoginErrorState(message: "Usuário ou senha inválidos!");
  }

  LoginState noNetwork() {
    return LoginErrorConectionState(
        message: "Verifique a sua conexão com a internet!");
  }
}
