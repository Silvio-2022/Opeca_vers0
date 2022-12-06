import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:equatable/equatable.dart';

abstract class AprovarReprovarState extends Equatable {
  AprovarReprovarState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class LoadingAprovarReprovarState extends AprovarReprovarState {}

class LoadedSucessAprovarReprovarState extends AprovarReprovarState {
  final OperationData a;
  LoadedSucessAprovarReprovarState({required this.a});
}

class LoadedErrorAprovarReprovarState extends AprovarReprovarState {}

class AprovarOperacaoState extends AprovarReprovarState {}

class ReprovarOperacaoState extends AprovarReprovarState {}

class AbrirAnexosState extends AprovarReprovarState {
  final bool cheia;
  final OperationData lista;
  AbrirAnexosState({required this.cheia, required this.lista});
}


class AbrindoTelaState extends AprovarReprovarState {}
