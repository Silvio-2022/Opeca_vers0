import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DismissibleWidget<T> extends StatefulWidget {
  const DismissibleWidget(
      {required this.index,
      required this.item,
      required this.child,
      required this.onDismissed});

  final Widget child;
  final int index;
  final CardDetail item;
  final DismissDirectionCallback onDismissed;

  @override
  State<DismissibleWidget<T>> createState() => _DismissibleWidgetState<T>();
}

class _DismissibleWidgetState<T> extends State<DismissibleWidget<T>> {
  bool temTexto = false;

  @override
  void initState() {
    super.initState();
  }

  //funcao de msg de success_color
  void showSuccessMessage(BuildContext context, String op) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Operação $op com sucesso "),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.pop(ctx), child: Text("Ok"))
        ],
      ),
    );
    //Navigator.pop(context, transf);
  }
  

  @override
  Widget build(BuildContext context1) {
    bool clique = false;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction > 0) {
          print('okk');
        }
      },
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey<CardDetail>(widget.item),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SizedBox(width: 50),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsetsDirectional.only(end: 10, top: 40),
              //color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final obsController = TextEditingController();
                      showDialog(
                        context: context1,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              'Observações',
                              style: TextStyle(
                                fontFamily: 'SEGOEUI',
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Container(
                              width: 90,
                              height: 50,
                              child: TextField(
                                autofocus: true,
                                cursorColor: Colors.black,
                                controller: obsController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Color(0xfff9ead6), width: 4),
                                  ),
                                  suffixIcon: IconButton(
                                    iconSize: 17,
                                    color: Colors.black,
                                    icon: Icon(Icons.close),
                                    onPressed: () => obsController.clear(),
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            actions: [
                              Container(
                                //margin: EdgeInsets.only(
                                //    right: MediaQuery.of(context).size.width),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'SEGOEUI',
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: SizedBox(
                                        height: 40,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            if (obsController.text.isNotEmpty) {
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();

                                              String idAccount =
                                                  sharedPreferences.getString(
                                                          'IdAccount') ??
                                                      'bug idAcount';
                                              BlocProvider.of<
                                                          ListaOperacoesBloc>(
                                                      context1)
                                                  .acaoBotoes(
                                                      "REJECT",
                                                      obsController.text,
                                                      int.parse(
                                                          widget.item.detalhes
                                                              .applicationId),
                                                      int.parse(widget.item
                                                          .detalhes.operationId),
                                                      int.parse(widget
                                                          .item
                                                          .detalhes
                                                          .operationCodId),
                                                      int.parse(widget.item
                                                          .detalhes.stepID),
                                                      20,
                                                      int.parse(idAccount));
                                              List<String> lista =
                                                  sharedPreferences.getStringList(
                                                          'ListaIdOperacoesAprovadas')
                                                      as List<String>;
                                              List<int> intLista = lista
                                                  .map((i) => int.parse(i))
                                                  .toList();
                                              intLista.add(widget.index);
                                              lista = intLista
                                                  .map((i) => i.toString())
                                                  .toList();
                                              sharedPreferences.remove(
                                                  'ListaIdOperacoesAprovadas');
                                              sharedPreferences.setStringList(
                                                  'ListaIdOperacoesAprovadas',
                                                  lista);
                                              BlocProvider.of<
                                                          ListaOperacoesBloc>(
                                                      context1)
                                                  .foundUsers
                                                  .removeAt(widget.index);
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context1,
                                                MaterialPageRoute(
                                                  builder: (context1) =>
                                                      ListaAprovacoes(
                                                    nomeSistema: sistema,
                                                  ),
                                                ),
                                              );
                                              //Aqui hei de chamar a pop para mostrar a msg de success_color
                                              showSuccessMessage(
                                                  context, "rejeitada");
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color(0xffe8912e)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            )),
                                          ),
                                          child: const Text(
                                            'Confirmar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'SEGOEUI',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'REJEITAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'SEGOEUI'
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xfffc312c)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      String idAccount =
                          sharedPreferences.getString('IdAccount') ??
                              'bug idAcount';
                      BlocProvider.of<ListaOperacoesBloc>(context1).acaoBotoes(
                          "NEXT",
                          '',
                          int.parse(widget.item.detalhes.applicationId),
                          int.parse(widget.item.detalhes.operationId),
                          int.parse(widget.item.detalhes.operationCodId),
                          int.parse(widget.item.detalhes.stepID),
                          20,
                          int.parse(idAccount));
                      List<String> lista = sharedPreferences.getStringList(
                          'ListaIdOperacoesAprovadas') as List<String>;
                      List<int> intLista =
                          lista.map((i) => int.parse(i)).toList();
                      intLista.add(widget.index);
                      lista = intLista.map((i) => i.toString()).toList();
                      sharedPreferences.remove('ListaIdOperacoesAprovadas');
                      sharedPreferences.setStringList(
                          'ListaIdOperacoesAprovadas', lista);

                      BlocProvider.of<ListaOperacoesBloc>(context1)
                          .foundUsers
                          .removeAt(widget.index);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaAprovacoes(
                            nomeSistema: sistema,
                          ),
                        ),
                      );

                      //Aqui hei de chamar a pop para mostrar a msg de success_color
                      showSuccessMessage(context, "aprovada");
                    },
                    child: Text(
                      'APROVAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'SEGOEUI'
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff59c36a)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: widget.child,
      ),
    );
  }
}
