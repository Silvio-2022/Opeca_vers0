import 'package:SOP/src/business_logic/dataProviders/listaOperacoes/cardDetailAPI.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/business_logic/repositories/aprovarReprovar/aprovarReprovarRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardDetailRepository {
  final CardDetailAPI cardDetailAPI = CardDetailAPI();
  AprovarReprovarRepository aprovarReprovarRepository =
      AprovarReprovarRepository();
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
  Future<List<CardDetail>> getOperationsPerSystem(
      String appID, String accountID) async {
    final List<CardDetail> listaOperacoes = [];
    final Map<String, dynamic> operacoesJSON =
        await cardDetailAPI.getOperationsPerSystem(appID, accountID);
    if (operacoesJSON.isNotEmpty) {
      for (var item in operacoesJSON['Apps']['Operacao']) {
        detalhes = await buscaDetalhes(item['OperationID']);
        listaOperacoes.add(
          CardDetail(
            unidadeOrcamental: item['Linha1Campo1'] ?? 'ok',
            title: item['Linha2Campo2'] ?? 'ok',
            subtitle: item['Linha2Campo1'] ?? 'ok',
            valor: item['Linha2Campo3'] ?? '23',
            fornecedor: item['Linha3Campo1'] ?? 'Teste',
            id: item['OperationID'] ?? 'ok'.toString(),
            moeda: item['Linha2Campo4'] ?? 'ok',
            detalhes: detalhes,
          ),
        );
      }
      return listaOperacoes;
    } else {
      return [];
    }
  }

  Future<OperationData> buscaDetalhes(String opID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String nomeSistema =
        sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
    //print(opID);
    try {
      detalhes = await aprovarReprovarRepository.getDetalhesOperacao(
          nomeSistema, opID);
    } catch (erro) {
      print('Erro ao buscar detalhes ' + erro.toString());
    }
    return detalhes;
  }
}
