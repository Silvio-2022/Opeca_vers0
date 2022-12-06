import 'package:equatable/equatable.dart';

class ListaOperacoesEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ListaOperacoesGetConnection extends ListaOperacoesEvent {}
class AbrirExpanded extends ListaOperacoesEvent {}

class ListaOperacoesGetConnectionError extends ListaOperacoesEvent {}
class ListaOperacoesGetConnectionSucess extends ListaOperacoesEvent {}
class ListaOperacoesGetLista extends ListaOperacoesEvent {}
class ListaOperacoesGetPesquisaLista extends ListaOperacoesEvent {
  final String pesquisa;
  ListaOperacoesGetPesquisaLista([this.pesquisa = '']);
}