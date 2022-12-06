// ignore_for_file: must_be_immutable

import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ListaOperacoesState extends Equatable {
  @override
  List<Object?> get props => [];
}

//View Lista de Operacoes
class ListaOperacoesLoadingState extends ListaOperacoesState {
  final String sistemaNome;
  final int appID;
  final List<CardDetail> cardDetail ;
  ListaOperacoesLoadingState(  [this.cardDetail = const [],this.sistemaNome = '', this.appID = 0]);
}

class ListaOperacoesLoadedSucessState extends ListaOperacoesState {
  final List<CardDetail> message;
  ListaOperacoesLoadedSucessState({required this.message});
}

class ListaOperacoesLoadedErrorState extends ListaOperacoesState {
  final String message;
  ListaOperacoesLoadedErrorState({required this.message});
}

//Pesquisas
class ListaOperacoesPesquisaLoadingState extends ListaOperacoesState {}

class ListaOperacoesPesquisaFindSucessState extends ListaOperacoesState {
final List<CardDetail> message;
  ListaOperacoesPesquisaFindSucessState({required this.message});
}

class ListaOperacoesPesquisaFindErrorState extends ListaOperacoesState {}

class AbrindoExpandLoadingState extends ListaOperacoesState {

}
