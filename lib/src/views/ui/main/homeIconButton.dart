import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetrocederButton extends StatelessWidget {
  final String telaRetroceder;
  final String sistema;
  RetrocederButton({required this.telaRetroceder, this.sistema = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      onPressed: () async {
        if (telaRetroceder == 'listaOperacoes') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider<MainBloc>(
                  create: (_) {
                    return MainBloc(MainOpeningState())..add(MainOpenning());
                  },
                  child: Home(),
                );
              },
            ),
          );
        } else if (telaRetroceder == 'detalhes') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider<ListaOperacoesBloc>(
                  create: (_) {
                    return ListaOperacoesBloc(ListaOperacoesLoadingState())
                      ..add(ListaOperacoesGetConnection());
                  },
                  child: ListaAprovacoes(
                    nomeSistema: sistema,
                  ),
                );
              },
            ),
          );
        } else if (telaRetroceder == 'aprovarReprovar') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                // applicationDetailItems = [];
                return ListaAprovacoes(
                  nomeSistema: sistema,
                );
              },
            ),
          );
        } else if (telaRetroceder == 'anexoVer') {
          int count = 0;
          Navigator.of(context).pop();
          //Navigator.pop(context);

          /*Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      // applicationDetailItems = [];
                      return HomeModal();
                    },
                  ),
                );*/
        }
      },
      icon: Icon(Icons.chevron_left),
      color: Colors.black,
    ));
  }
}
