import 'package:SOP/src/business_logic/dataProviders/aprovarReprovar/aprovarReprovarAPI.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';

class AprovarReprovarRepository {
  final AprovarReprovarAPI aprovarReprovarAPI = AprovarReprovarAPI();
  Future<OperationData> getDetalhesOperacao(
      String applicationID, String operationID) async {
    OperationData dadosObjecto = OperationData(
      applicationId: '',
      operationCodId: '',
      operationId: '',
      stepID: '',
      header: Header(campo: '', valor: ''),
      dados: [],
      grelha: Grelha(
          header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''),
          data: []),
      anexo: [],
    );
    final Map<String, dynamic> detalhesJSON =
        await aprovarReprovarAPI.buscaDetalhes(applicationID, operationID);

    //Variaveis para os Dados
    List<Data0> listaData = [];
    List<Data2> listaData2 = [];
    List<Anexo> anexos = [];
    Header_grelha gr = Header_grelha(coluna1: '', coluna2: '', coluna3: '');
    Grelha grelha = Grelha(header: gr, data: []);
    if (detalhesJSON['OperationData']['Grelha'] != null) {
      print('Tem grelha');

      grelha = Grelha.fromJson(detalhesJSON['OperationData']['Grelha']);
    } else {
      print('Nao tem grelha');
      //print(detalhesJSON['OperationData'].toString());
    }
    //OperationData detals;
    //print(detalhesJSON['OperationData'].toString());
    //Para os dados do detalhes
    for (var item in detalhesJSON['OperationData']['Data']) {
      Data0 data = Data0(campo: item['Campo'], valor: item['Valor'] ?? "ok");
      listaData.add(data);
    }
    if (detalhesJSON['OperationData']['Anexo'] != null) {
      //Pear dados dos Anexos
      for (var item2 in detalhesJSON['OperationData']['Anexo']) {
        anexos.add(Anexo.fromJson(item2));
        //print('APP ID ' + detalhesJSON['OperationData']['OperationCodID']);
      }
    } else {
      print('buggs');
    }

    //Para a Construção da  Tabela
    dadosObjecto = OperationData(
      applicationId: detalhesJSON['OperationData']['ApplicationID'],
      operationCodId: detalhesJSON['OperationData']['OperationCodID'],
      operationId: detalhesJSON['OperationData']['OperationID'].toString(),
      stepID: detalhesJSON['OperationData']['StepID'],
      header: Header.fromJson(detalhesJSON['OperationData']['Header']),
      dados: listaData,
      grelha: grelha,
      anexo: anexos.isNotEmpty ? anexos : [],
    );
    return dadosObjecto;
  }

  Future<String> getPDFOperacao(String operationID, String contentID) async {
    final String pdfStringJSON =
        await aprovarReprovarAPI.buscaPdf(operationID, contentID);
    return pdfStringJSON;
  }

  Future<bool> getResultadoAprovarRejeitar( String stepCode,
      String stepComment,
      int applicationID,
      int operationID,
      int operationCodID,
      int stepID,
      int sourceID,
      int userID) async {
    final Map<String, dynamic> resultado =
        await aprovarReprovarAPI.aprovarReprovarAcao(
            stepCode, stepComment, applicationID, operationID, operationCodID, stepID, sourceID, userID);
    print(resultado['Message'].toString());
    return true;
  }
}
