import 'package:SOP/src/business_logic/dataProviders/main/sistemasAPI.dart';
import 'package:SOP/src/business_logic/models/apiJsonToObjectSistemas.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';

class SistemaRepository {
   final SistemasAPI sistemaAPI = SistemasAPI();
  Future<List<Sistema>> getSystemsList() async {
    final List<Sistema> listaSistemas = [];
    final Map<String, dynamic> sistemasJSON = await sistemaAPI.getSystems();
    SistemaAPI sist = sistemasJSON.isNotEmpty
        ? SistemaAPI.fromJson(sistemasJSON)
        : SistemaAPI.fromJson({});
    sist.applicationDetail.applicationDetailItems.forEach((element) {
      listaSistemas.add(
        Sistema(
            applicationID: element.applicationID,
            applicationCod: element.applicationCod,
            applicationName: element.applicationName,
            applicationNameShort: element.applicationNameShort,
            iconBase64: element.iconBase64,
            numOperations: element.numOperations),
      );
    });

    return listaSistemas;
  }
}
