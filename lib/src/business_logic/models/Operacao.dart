class Operacao {
  late final int operationID;
  late final int operationCodID;
  late final int operationStep;
  late final int operationTypeID;
  late final int operationError;
  late final String area;
  late final String operation;
  late final String stateOperation;
  late final String date;
  late final String description;
  late final String description2;
  late final String balcony;
  late final bool isOnlyView;
  late final bool isLockError;
  late final String valueOperation;
  late final String currency;
  late final String entity1;
  late final String entity2;
  late final bool isNotifyUser;
  late final int operationWorkflowStepID;
  late final String blindNextStep;
  late final String nextStepDesc;
  late final int applicationID;

  Operacao({
    required this.operationID,
    required this.operationCodID,
    required this.operationStep,
    required this.operationTypeID,
    required this.operationError,
    required this.area,
    required this.operation,
    required this.stateOperation,
    required this.date,
    required this.description,
    required this.valueOperation,
    required this.entity1,
    required this.operationWorkflowStepID,
    required this.applicationID,
  });

  factory Operacao.fromJson(Map<String, dynamic> json) {
    return Operacao(
      operationID: json['operationID'],
      operationCodID: json['operationCodID'],
      operationStep: json['operationStep'],
      operationTypeID: json['operationTypeID'],
      operationError: json['operationError'],
      area: json['area'],
      operation: json['operation'],
      stateOperation: json['stateOperation'],
      date: json['date'],
      description: json['description'],
      valueOperation: json['valueOperation'],
      entity1: json['entity1'],
      operationWorkflowStepID: json['operationWorkflowStepID'],
      applicationID: json['applicationID']
    );
  }
}
