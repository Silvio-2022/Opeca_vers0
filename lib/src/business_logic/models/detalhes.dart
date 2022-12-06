class Detalhes {
  late OperationData operationData;

  Detalhes({required this.operationData});

  Detalhes.fromJson(Map<String, dynamic> json) {
    operationData = (json["OperationData"] == null
        ? null
        : OperationData.fromJson(json["OperationData"]))!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (operationData != null) {
      data["OperationData"] = operationData.toJson();
    }
    return data;
  }
}

class OperationData {
  late String applicationId;
  late String operationCodId;
  late String operationId;
  late String stepID;
  late Header header;
  late List<Data0> dados;
  late Grelha grelha;
  late List<Anexo> anexo;

  OperationData(
      {required this.applicationId,
      required this.operationCodId,
      required this.operationId,
      required this.stepID,
      required this.header,
      required this.dados,
      required this.grelha,
      required this.anexo});

  OperationData.fromJson(Map<String, dynamic> json) {
    applicationId = json["ApplicationID"];
    operationCodId = json["OperationCodID"];
    operationId = json["OperationID"];
    stepID = json["StepID"];
    header = (json["Header"] == null ? null : Header.fromJson(json["Header"]))!;
    dados = (json["Data"] == null
        ? null
        : (json["Data"] as List).map((e) => Data0.fromJson(e)).toList())!;
    grelha = (json["Grelha"] == null ? null : Grelha.fromJson(json["Grelha"]))!;
    // anexo = (json["Anexo"] == null ? null : Anexo.fromJson(json["Anexo"]))!;
    //Para anexos a
    anexo = (json["Anexo"] == null
        ? null
        : (json["Anexo"] as List).map((e) => Anexo.fromJson(e)).toList())!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ApplicationID"] = applicationId;
    data["OperationCodID"] = operationCodId;
    data["OperationID"] = operationId;
    if (header.toString().isNotEmpty) {
      data["Header"] = header.toJson();
    }
    if (data.isNotEmpty) {
      data["Data"] = this.dados.map((e) => e.toJson()).toList();
    }
    if (grelha != null) {
      data["Grelha"] = grelha.toJson();
    }
    if (anexo != null) {
      data["Anexo"] = this.anexo.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Anexo {
  late String operationId;
  late String idConteudo;
  late List<Data2> data;

  Anexo(
      {required this.operationId,
      required this.idConteudo,
      required this.data});

  Anexo.fromJson(Map<String, dynamic> json) {
    operationId = json["OperationID"];
    idConteudo = json["IDConteudo"];
    data = (json["Data"] == null
        ? null
        : (json["Data"] as List).map((e) => Data2.fromJson(e)).toList())!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["OperationID"] = operationId;
    data["IDConteudo"] = idConteudo;
    if (this.data.isNotEmpty) {
      data["Data"] = this.data.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

//Data para grelha //DAdos da grelha
class Data_grelha {
  late String valor1;
  late String valor2;
  late String valor3;

  Data_grelha(
      {required this.valor1, required this.valor2, required this.valor3});

  Data_grelha.fromJson(Map<String, dynamic> json) {
    valor1 = json['Valor1'];
    valor2 = json['Valor2'];
    valor3 = json['Valor3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Valor1'] = this.valor1;
    data['Valor2'] = this.valor2;
    data['Valor3'] = this.valor3;
    return data;
  }
}

class Data2 {
  late String campo;
  late String valor;

  Data2({required this.campo, required this.valor});

  Data2.fromJson(Map<String, dynamic> json) {
    campo = json["Campo"];
    valor = json["Valor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Campo"] = campo;
    data["Valor"] = valor;
    return data;
  }
}

class Grelha {
  //late Header_grelha headgrelha;
  late Header_grelha header;
  late List<Data_grelha> data;

  Grelha({required this.header, required this.data});

  Grelha.fromJson(Map<String, dynamic> json) {
    header = (json['Header'] != null
        ? new Header_grelha.fromJson(json['Header'])
        : null)!;
    if (json['Data'] != null) {
      data = <Data_grelha>[];
      json['Data'].forEach((v) {
        data.add(new Data_grelha.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (header != null) {
      data['Header'] = this.header.toJson();
    }
    if (data.isNotEmpty) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data0 {
  late String campo;
  late String valor;

  Data0({required this.campo, required this.valor});

  Data0.fromJson(Map<String, dynamic> json) {
    campo = json["Campo"];
    valor = json["Valor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Campo"] = campo;
    data["Valor"] = valor;
    return data;
  }
}

class Header_grelha {
  late String coluna1;
  late String coluna2;
  late String coluna3;

  Header_grelha(
      {required this.coluna1, required this.coluna2, required this.coluna3});

  Header_grelha.fromJson(Map<String, dynamic> json) {
    coluna1 = json['Coluna1'];
    coluna2 = json['Coluna2'];
    coluna3 = json['Coluna3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Coluna1'] = this.coluna1;
    data['Coluna2'] = this.coluna2;
    data['Coluna3'] = this.coluna3;
    return data;
  }
}

class Header {
  late String campo;
  late String valor;

  Header({required this.campo, required this.valor});

  Header.fromJson(Map<String, dynamic> json) {
    campo = json["Campo"];
    valor = json["Valor"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Campo"] = campo;
    data["Valor"] = valor;
    return data;
  }
}
