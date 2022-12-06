class SistemaAPI {
  late ApplicationDetail applicationDetail;

  SistemaAPI({required this.applicationDetail});

  SistemaAPI.fromJson(Map<String, dynamic> json) {
    applicationDetail = (json['ApplicationDetail'] != null ? new ApplicationDetail.fromJson(json['ApplicationDetail'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicationDetail != null) {
      data['ApplicationDetail'] = this.applicationDetail.toJson();
    }
    return data;
  }
}

class ApplicationDetail {
  late List<ApplicationDetailItems> applicationDetailItems;

  ApplicationDetail({required this.applicationDetailItems});

  ApplicationDetail.fromJson(Map<String, dynamic> json) {
    if (json['applicationDetailItems'] != null) {
      applicationDetailItems = <ApplicationDetailItems>[];
      json['applicationDetailItems'].forEach((v) {
        applicationDetailItems.add(new ApplicationDetailItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicationDetailItems != null) {
      data['applicationDetailItems'] =
          this.applicationDetailItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplicationDetailItems {
  late int applicationID;
  late String applicationCod;
  late String applicationName;
  late String applicationNameShort;
  late String iconBase64;
  late String numOperations;

  ApplicationDetailItems(
      {required this.applicationID,
      required this.applicationCod,
      required this.applicationName,
      required this.applicationNameShort,
      required this.iconBase64,
      required this.numOperations});

  ApplicationDetailItems.fromJson(Map<String, dynamic> json) {
    applicationID = json['ApplicationID'];
    applicationCod = json['ApplicationCod'];
    applicationName = json['ApplicationName'];
    applicationNameShort = json['ApplicationNameShort'];
    iconBase64 = json['IconBase64'];
    numOperations = json['NumOperations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApplicationID'] = this.applicationID;
    data['ApplicationCod'] = this.applicationCod;
    data['ApplicationName'] = this.applicationName;
    data['ApplicationNameShort'] = this.applicationNameShort;
    data['IconBase64'] = this.iconBase64;
    data['NumOperations'] = this.numOperations;
    return data;
  }
}
