// ignore_for_file: unused_element

import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/business_logic/repositories/main/SistemaRepository.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  SistemaRepository sistemaRepository = SistemaRepository();
  bool estaLogado = false;
  List<Sistema> listaSistemas = [];
  bool isDeviceConnected = false;
  MainBloc(MainState initialState) : super(MainOpeningState()) {
    on<MainOpenning>((event, emit) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      try {
        listaSistemas = await sistemaRepository.getSystemsList();

        //emit(menuProcessado(listaSistemas));
      } catch (erro) {
        print('Erro lista sistemas $erro');
      }
      emit(processando(isDeviceConnected,listaSistemas));
    });
    on<MainGetConnectionSuccess>((event, emit) async {
      
    });
  }

  MainState processando(isDeviceConnected, List<Sistema> listaSistema) {
    if (isDeviceConnected == true) {
      return MainOpeningState(listaSistema);
    } else {
      return MainNetworkErrorOpeningState(
          message: "Verifique a sua conexão por favor!",);
    }
  }

  MainState menuProcessado(List<Sistema> l) {
    return MainProcessedState(lista: l);
  }

  //carrega os dados do usuario
  carregaDados() async {
    pegaDados().then((bool result) {
      estaLogado = result;
    });
  }

  //Obtem os dados partilhados do usuario
  Future<bool> pegaDados() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getBool("isLoggedIn") ?? false);
  }
  Future<void> selecionaSistema(
      BuildContext context, String sistema, int appID) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('NomeSistema', sistema);
      sharedPreferences.setString('SistemaID', appID.toString());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<ListaOperacoesBloc>(
            create: (_) {
              return ListaOperacoesBloc(ListaOperacoesLoadingState())
                ..add(ListaOperacoesGetConnection());
            },
            child: ListaAprovacoes(nomeSistema: sistema,),
          );
        },
      ),
    );
  }
}
