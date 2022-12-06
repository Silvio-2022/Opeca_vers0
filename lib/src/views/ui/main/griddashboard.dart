import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/views/ui/main/iconSistema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Silvio mecheste tod
List<Sistema> applicationDetailItems = [];

class GridDashboard extends StatefulWidget {
  GridDashboard({required List<Sistema> items}) {
    applicationDetailItems = items;
  }

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  var nome = '';

   //carrega os dados do usuario
  _carregaDados() async {
    final result = await pegaDados().then((List<String> lista) {
      setState(() {
        nome = lista[0];
      });
    });
  }
  Future<List<String>> pegaDados() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> listaDados = [];
    listaDados.add((sharedPreferences.getString("Nome") ?? ""));
    return listaDados;
  }
  @override
  initState() {
    super.initState();
    _carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    List<Sistema> myList = applicationDetailItems;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 34, top: 9, bottom: 2),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Olá, $nome ",
              style: TextStyle(
                fontFamily: "SEGOEUI",
                color: Colors.black,
                fontSize: largura * 0.06,
                fontWeight: FontWeight.w500,
                //fontFamily: "Open Sans",
              ),
            ),
          ),
        ),
        Flexible(
          child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom:25),
            crossAxisCount: 2,
            crossAxisSpacing: 35,
            mainAxisSpacing: 28,
            children: myList.map(
              (data) {
                return InkWell(
                  onTap: () => BlocProvider.of<MainBloc>(context)
                      .selecionaSistema(
                          context, data.applicationCod, data.applicationID),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(bottom:(myList.lastIndexOf(data)+1==applicationDetailItems.length )? 12:myList.lastIndexOf(data)+1==applicationDetailItems.length-1?12:0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFfb2436),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 0.2,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          height: largura * 0.07,
                          width: largura * 0.07,
                          child: Center(
                            child: Text(
                              int.parse(data.numOperations) > 100
                                  ? '+99'
                                  : data.numOperations,
                              style: TextStyle(
                                color: data.numOperations == "0"
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: largura * 0.03,
                                fontWeight: FontWeight.w900,
                                fontFamily: "SEGOEUI",
                              ),
                            ),
                          ),
                          margin:
                              EdgeInsets.only(left: largura * 0.23, bottom: 0),
                        ),
                        Container(
                          // height: largura*0.07,
                          width: largura * 0.1,
                          child: IconSistema(
                            imageAnalysed: data.iconBase64,
                            nome: data.applicationCod,
                          ),
                          margin: EdgeInsets.only(bottom: 0.1),
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              data.applicationCod,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: largura * 0.06,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SEGOEUI",
                                letterSpacing: 1,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom:  largura * 0.009),
                          ),
                        ),
                        Text(
                          data.applicationNameShort,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SEGOEUI",
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          
          ),
        ),
        
      ],
    );
  }
}
