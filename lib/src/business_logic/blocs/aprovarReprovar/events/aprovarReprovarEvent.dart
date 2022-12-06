import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:equatable/equatable.dart';

class AprovarReprovarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AbrindoTelaEvent extends AprovarReprovarEvent {}
class LoadAprovarReprovarEvent extends AprovarReprovarEvent {}

class AprovarEvent extends AprovarReprovarEvent {}

class ReprovarEvent extends AprovarReprovarEvent {}

class AbrirAnexosEvent extends AprovarReprovarEvent {
  final List lista;
  final OperationData objeto;
  AbrirAnexosEvent({required this.lista, required this.objeto});
}
