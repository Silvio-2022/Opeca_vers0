// ignore_for_file: unnecessary_statements

import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/dismissibleWidget.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/itemsLista.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/Header/my_header_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'constant.dart';

int toggle = 1;
late String sistema;
void main() {
  runApp(ListaAprovacoes(
    nomeSistema: sistema,
  ));
}

class ListaAprovacoes extends StatefulWidget {
  final String nomeSistema;
  ListaAprovacoes({required this.nomeSistema}) {
    sistema = nomeSistema;
  }
  @override
  State<ListaAprovacoes> createState() => _ListaAprovacoesState();
}

class _ListaAprovacoesState extends State<ListaAprovacoes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _controller = ScrollController();

  @override
  initState() {
    super.initState();
    BlocProvider.of<ListaOperacoesBloc>(context).foundUsers =
        BlocProvider.of<ListaOperacoesBloc>(context).cards;
    _controller.addListener(() {
      //bool isTop = _controller.position.pixels == 0;
      double t = _controller.position.pixels;
      if (_controller.position.pixels > 0.0) {
        setState(() {
          //print('At the bottom ${t}');
          BlocProvider.of<ListaOperacoesBloc>(context)
              .caixaDePesquisaEstaVisivel = false;
        });
      }
      if (t == 0.0) {
        setState(() {
          BlocProvider.of<ListaOperacoesBloc>(context)
              .caixaDePesquisaEstaVisivel = true;
        });
      }
    });
  }

//Função para retroceder
  Future<void> sair() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        sair(); //Função para retroceder a tela anterior
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: RetrocederButton(telaRetroceder: 'listaOperacoes'),
          toolbarHeight: 58,
          elevation: 0.0,
          backgroundColor: Color(0xFFfff9f9),
          title: (BlocProvider.of<ListaOperacoesBloc>(context)
                      .botaoHomeAparece ==
                  false)
              ? Text("Portal de Operações")
              : Text(
                  'Portal de Operações' +
                      BlocProvider.of<ListaOperacoesBloc>(context).traco +
                      sistema,
                  style: TextStyle(
                      fontSize: (BlocProvider.of<ListaOperacoesBloc>(context)
                                  .caixaDePesquisaEstaVisivel ==
                              true)
                          ? 20
                          : 15),
                ),
          actions: [
            if (BlocProvider.of<ListaOperacoesBloc>(context)
                    .caixaDePesquisaEstaVisivel ==
                false)
              IconButton(
                splashRadius: 20.0,
                splashColor: Colors.grey,
                onPressed: () {
                  setState(() {
                    BlocProvider.of<ListaOperacoesBloc>(context)
                        .caixaDePesquisaEstaVisivel = true;
                  });
                },
                icon: Image.asset(
                  'assets/images/search.png',
                  height: 18.0,
                ),
              ),
          ],
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "SEGOEUI",
          ),
        ),
        body: Column(
          children: [
            //if (BlocProvider.of<ListaOperacoesBloc>(context).foiClicado == true)
            Container(
              child: Stack(
                children: [
                  BlocProvider.of<ListaOperacoesBloc>(context)
                              .caixaDePesquisaEstaVisivel ==
                          true
                      ? Container(
                          color: Color(0xFFfff9f9),
                          child: Center(
                            child: Container(
                              height: 40.0,
                              width: double.infinity,
                              alignment: Alignment(-1.0, 0.0),
                            ),
                          ),
                        )
                      : Container(),
                  if (BlocProvider.of<ListaOperacoesBloc>(context)
                          .caixaDePesquisaEstaVisivel ==
                      true)
                    Opacity(
                      opacity: 0.65,
                      child: Center(
                        child: Container(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 375),
                            height: 40.0,
                            width: (toggle == 0) ? 50.0 : 370.0,
                            curve: Curves.easeOut,
                            decoration: BoxDecoration(
                                color: Color(0xFFeeeae9),
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: -14.0,
                                    blurRadius: 10.0,
                                    offset: Offset(-4.0, 10.0),
                                  ),
                                ]),
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 375),
                                  left: (toggle == 0) ? 45.0 : 15.0,
                                  top: 13.0,
                                  curve: Curves.easeOut,
                                  child: AnimatedOpacity(
                                    opacity: (toggle == 0) ? 0.0 : 1.0,
                                    duration: Duration(milliseconds: 200),
                                    child: Container(
                                      height: 20.0,
                                      width: 150.0,
                                      child: TextField(
                                        onChanged: (valor) => runFilter(valor),
                                        cursorRadius: Radius.circular(10.0),
                                        cursorWidth: 2.0,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          //labelText: 'Pesquisar...',
                                          label: Text('Pesquisa'),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 318),
                                  child: Material(
                                    color: Color(0xFFeeeae9),
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: IconButton(
                                      splashRadius: 20.0,
                                      splashColor: Colors.grey,
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      icon: Image.asset(
                                        'assets/images/search.png',
                                        height: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          margin: EdgeInsets.only(
                              bottom: 15,
                              left: (MediaQuery.of(context).size.width / 2) *
                                  0.001,
                              top: 6),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            BlocBuilder<ListaOperacoesBloc, ListaOperacoesState>(
              bloc: BlocProvider.of<ListaOperacoesBloc>(context),
              builder: (context, state) {
                if (state is ListaOperacoesLoadedSucessState) {
                  return Container(
                    child: Expanded(
                      flex: 360,
                      child: BlocProvider.of<ListaOperacoesBloc>(context)
                              .foundUsers
                              .isNotEmpty
                          ? ListView.builder(
                              controller: _controller,
                              itemCount:
                                  BlocProvider.of<ListaOperacoesBloc>(context)
                                      .foundUsers
                                      .length,
                              itemBuilder: (context, index) {
                                final item =
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index];
                                return BlocProvider.value(
                                    value: BlocProvider.of<ListaOperacoesBloc>(
                                        context),
                                    child: DismissibleWidget(
                                      index: index,
                                      item: item,
                                      child: buildListTile(item, index),
                                      onDismissed: (direction) => dismissItem(
                                          context, index, direction),
                                    ));
                              },
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: 130),
                              child: Center(
                                child: const Text(
                                  'Nenhum resultado encontrado.',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(CardDetail item, int index) => Container(
        child: Stack(
          children: [
            /*if (index == 0)
              Container(
                color: Color(0xFFfff9f9),
                child: Center(
                  child: Container(
                    height: 40.0,
                    width: 250.0,
                    alignment: Alignment(-1.0, 0.0),
                  ),
                ),
              ),*/
            ItemsLista(
              unidadeOrcamental: item.unidadeOrcamental,
              title: item.title,
              subtitle: item.fornecedor,
              sistema: sistema,
              id: item.id,
              data: item.subtitle,
              valor: item.valor.toString(),
              moeda: item.moeda,
              index: index,
              detalhes: item.detalhes,
            ),
          ],
        ),
      );

  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<CardDetail> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = BlocProvider.of<ListaOperacoesBloc>(context).cards;
    } else {
      results =
          BlocProvider.of<ListaOperacoesBloc>(context).cards.where((card) {
        return card.title
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.subtitle
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.fornecedor
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.valor.toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      BlocProvider.of<ListaOperacoesBloc>(context).foundUsers = results;
    });
  }

  void dismissItem(
      BuildContext context, int index, DismissDirection direction) {
    setState(() {
      BlocProvider.of<ListaOperacoesBloc>(context).foundUsers.removeAt(index);
      switch (direction) {
        case DismissDirection.endToStart:
          print('Operacao rejeitada');
          break;
        case DismissDirection.startToEnd:
          print('Operacao aprovada');
          break;
        default:
      }
    });
  }
}
