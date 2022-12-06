import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/views/ui/main/griddashboard.dart';
import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  final List<Sistema> listaSistemas;
  Cabecalho({required this.listaSistemas});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              //color: Colors.blue,
                              decoration:
                                  BoxDecoration(color: const Color(0xFFfff9f9)),
                            ),
                            /* SizedBox(
                          height: 4,
                        ),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SafeArea(
          child: GridDashboard(
            items: listaSistemas,
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
