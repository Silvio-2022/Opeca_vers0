class ApiJsonToObject {
  late final List<Object> listaDeOperacoes;
  late final String search;
  late final int applicationID;
  late final int applicationCod;
  late final String applicationName;
  late final String tipoEstado;
  late final String vista;
  late final String additionalInfo;
  late final String modelSearch;
  late final int num_OPERATIONS_GRID_PAGE;
  late final int operationIDGerado;
  late final int hiddenBalcaoColumn;

  ApiJsonToObject({required this.listaDeOperacoes});

  factory ApiJsonToObject.fromJson(Map<String, dynamic> json) {
    var obj = json['OperationList'];
    return ApiJsonToObject(
      listaDeOperacoes: new List<Object>.from(obj),
    );
  }
}
