import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainOpeningState extends MainState {
final List<Sistema> lista;
  MainOpeningState([this.lista = const []]);
}

class MainNetworkErrorOpeningState extends MainState {
  final String message;
  MainNetworkErrorOpeningState({required this.message});
}

class MainProcessedState extends MainState {
  final List<Sistema> lista;
  MainProcessedState({required this.lista});
}
