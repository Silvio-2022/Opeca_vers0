import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/business_logic/repositories/aprovarReprovar/aprovarReprovarRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AprovarReprovarBloc
    extends Bloc<AprovarReprovarEvent, AprovarReprovarState> {
  AprovarReprovarRepository aprovarReprovarRepository =
      AprovarReprovarRepository();
      String ficheiroString = '';
      String opID = '';
      String idCont = '';
      String nomeAnexo = '';
  OperationData detalhes = OperationData(
    applicationId: '',
    operationCodId: '',
    operationId: '',
    stepID: '',
    header: Header(campo: '', valor: ''),
    dados: [],
    grelha: Grelha(
        header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''), data: []),
    anexo: [],
  );
  String nomeSistema = '';
  String operationID = '';
  List<String> columns = [];
  bool isDeviceConnected = false;
  AprovarReprovarBloc(AprovarReprovarState initialState)
      : super(LoadingAprovarReprovarState()) {
    on<LoadAprovarReprovarEvent>((event, emit) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      nomeSistema = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
      operationID = sharedPreferences.getString('OperationID') ?? 'bug';
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      try {
        detalhes = await teste(operationID);
      } catch (erro) {
        print('Erro lista sistemas $erro');
      }
      emit(processandoDetalhes(isDeviceConnected, detalhes));
    });

    on<AbrirAnexosEvent>((event, emit) async {
      emit(abrindoAnexo(event.lista, event.objeto));
    });
  }
  AprovarReprovarState abrindoTela() {
    return AbrindoTelaState();
  }

  AprovarReprovarState processandoDetalhes(bool v, OperationData c) {
    if (v == true) {
      return LoadedSucessAprovarReprovarState(a: c);
    } else {
      return LoadedErrorAprovarReprovarState();
    }
  }

  Future<OperationData> teste(String opID)async{
  SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      nomeSistema = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
     
      try {
        detalhes = await aprovarReprovarRepository.getDetalhesOperacao(
            nomeSistema, opID);
      } catch (erro) {
        print('Erro ao buscar detalhes ' + erro.toString());
      }
      return detalhes;
  }
  
  Future<String> buscaPDF(String opID, String idCont)async{
  SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      nomeSistema = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
     String ficheiroBase64 = '';
      try {
        ficheiroBase64 = await aprovarReprovarRepository.getPDFOperacao(opID, idCont);
      } catch (erro) {
        print('Erro ao buscar detalhes ' + erro.toString());
      }
      return ficheiroBase64;
  }
  AprovarReprovarState abrindoAnexo(List a, OperationData b) {
    if (a.isEmpty) {
      return AbrirAnexosState(cheia: false, lista: b);
    } else {
      return AbrirAnexosState(cheia: true, lista: b);
    }
  }

  //Gera o conteudo das celulas
  List<DataCell> getCelulas(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  //Desenha o cabeçalho das Colunas
  List<DataColumn> getColunas(List<String> columns) => columns
      .map((String columns) => DataColumn(
            label: Text(columns),
          ))
      .toList();

  //Desenha as linhas
  List<DataRow> getLinhas(List<String> columns, List<dynamic> cell) => columns
      .map((String columns) => DataRow(
            cells: getCelulas(cell),
          ))
      .toList();

  List<DataRow> tabela() {
    var celulas = [];
    List<DataRow> lista = [];
    for (int i = 0; i < detalhes.grelha.data.length; i++) {
      celulas = [
        detalhes.grelha.data[i].valor1,
        detalhes.grelha.data[i].valor2,
        detalhes.grelha.data[i].valor3
      ];
      DataRow rows = DataRow(cells: getCelulas(celulas));
      lista.add(rows);
    }
    return lista;
  }

  //Construção da Tabela
  Widget tabelaDados() {
    return Container(
      //margin: EdgeInsets.only(right: 10, top: 10), poderia usar o FitdBox para rem o pading
      child: Center(
        child: DataTable(
          horizontalMargin: 1,
          columnSpacing: 19,
          columns: getColunas(columns),
          rows: tabela(),
        ),
      ),
    );
  }

  //Construção dos campos
  Widget camposPovoar(int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            (detalhes.dados[i].campo == 'ok') ? '' : detalhes.dados[i].campo,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 13,
                fontFamily: "Open Sans"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            (detalhes.dados[i].campo.contains('Data'))
                ? detalhes.dados[i].valor.split('-').reversed.join('-')
                : detalhes.dados[i].valor,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 17,
                fontFamily: "Open Sans"),
          ),
        ),
      ],
    );
  }
}
