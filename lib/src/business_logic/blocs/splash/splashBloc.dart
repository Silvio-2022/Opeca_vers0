// ignore_for_file: cancel_subscriptions

import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  bool isDeviceConnected = false;

  SplashBloc([SplashState? initialState, bool isConnected = false])
      : super(SplashRunningState()) {
    on<SplashProcessing>((event, emit) {
      emit(processandoSplash());
    });

    on<SplashProcessed>((event, emit) {
      emit(abrirLoginView());
    });
  }
  //Função do tempo
  inicioTempo(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<LoginBloc>(
          create: (_) {
            return LoginBloc(LoginNormalState())..add(LoginGetConnection());
          },
          child: LoginScreem(),
        );
      }),
    );
  }

  SplashState abrirLoginView() {
    return SplashExecutedState();
  }

  SplashState processandoSplash() {
    return SplashRunningState();
  }
}
