import 'package:SOP/src/business_logic/models/detalhes.dart';

class CardDetail {
  CardDetail(
      {required this.unidadeOrcamental,
      required this.title,
      required this.subtitle,
      required this.valor,
      required this.fornecedor,
      required this.id,
      required this.moeda,
      required this.detalhes});

  String fornecedor;
  String id;
  String moeda;
  String subtitle;
  String title;
  String valor;
  String unidadeOrcamental;
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
}
