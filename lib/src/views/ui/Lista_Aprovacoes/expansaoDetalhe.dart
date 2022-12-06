import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Detalhes/pdf_abrir.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ExpandirDetalhes extends StatefulWidget {
  late final String forn;
  late final String id;
  late final BuildContext context;
  final OperationData detalhes;
  final String sistemaNome;
  ExpandirDetalhes(
      {required this.forn,
      required this.id,
      required this.context,
      required this.detalhes,
      required this.sistemaNome});
  @override
  State<ExpandirDetalhes> createState() => _ExpandirDetalhesState();
}

class _ExpandirDetalhesState extends State<ExpandirDetalhes> {
  String seta = 'assets/setabaixo.PNG';
  String test = "{Header: {Coluna1: , Coluna2: , Coluna3: }, Data: []}";
  bool estaExpandido = false;
  List<String> columns = [];
  bool docAbrir = false;
  bool _loading = false;

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  initState() {
    super.initState();
    BlocProvider.of<ListaOperacoesBloc>(context).detalhes = widget.detalhes;
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Container(
      child: ExpansionTile(
        textColor: Colors.black,
        collapsedTextColor: Colors.black,
        onExpansionChanged: (value) {
          print(widget.id);
          //BlocProvider.of<ListaOperacoesBloc>(widget.context)
          //   .buscaDetalhes(widget.id);
          if (value == true) {
            setState(() {
              seta = "assets/setacima.PNG";
              estaExpandido = true;
            });
            if (estaExpandido == true) {
              columns = [
                widget.detalhes.grelha.header.coluna1,
                widget.detalhes.grelha.header.coluna2,
                widget.detalhes.grelha.header.coluna3,
              ];
            }
          } else {
            setState(() {
              seta = "assets/setabaixo.PNG";
              estaExpandido = false;
            });
          }
        },
        title: Container(
          height: largura * 0.15,
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                child: Container(
                  //color: Colors.red,
                  padding: EdgeInsets.zero,
                  //height: 22,
                  width: largura * 0.16,
                  margin: EdgeInsetsDirectional.only(
                    start: MediaQuery.of(context).size.width - 102,
                  ),
                  child: Center(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          splashColor: Colors.white,
                          splashRadius: 15,
                          padding: EdgeInsets.zero,
                          iconSize: 35,
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,

                            //size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      seta,
                      height: largura * 0.09,
                      width: largura * 0.08,
                    ),
                  ),
                  Text(
                    widget.forn,
                    style: TextStyle(
                      fontSize: largura * 0.05,
                      fontFamily: "SEGOEUI",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        //leading: ,

        // trailing: Icon(Icons.no),
        children: [
          estaExpandido == true
              ? Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //aqui irei colocar todos os widgets q farão parte dos detalhes
                          Container(
                            margin: EdgeInsets.only(
                              right: 0,
                              left: 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 2,
                                    //left: 20,
                                  ),
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        top: 25, end: 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Intrução for
                                        for (int i = 2;
                                            i < widget.detalhes.dados.length;
                                            i++)
                                          (widget.detalhes.dados[i].valor ==
                                                  'ok')
                                              ? camposPovoar(++i)
                                              : camposPovoar(i),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.detalhes.grelha
                                      .toJson()
                                      .toString()
                                      .contains(test) ==
                                  false
                              ? Column(
                                  children: [
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        child: tabelaDados(),
                                        padding: EdgeInsets.only(bottom: 18)),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    widget.detalhes.anexo.isNotEmpty == true
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.zero,
                            height: largura * 0.10,
                            color: Color(0xffeaeaea),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsetsDirectional.only(start: 10),
                              child: Text(
                                'Arquivos Anexados',
                                style: TextStyle(
                                    fontSize: largura * 0.06,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SEGOEUI'),
                              ),
                            ),
                          )
                        : Container(),
                    widget.detalhes.anexo.isNotEmpty == true
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.detalhes.anexo.isNotEmpty)
                                    if ((widget.detalhes.anexo.length) <
                                        2) //Se tiver apenas 1 anexo
                                      for (int aux = 0;
                                          aux <
                                              (widget.detalhes.anexo[0].data
                                                      .length) -
                                                  1;
                                          aux++)
                                        if (widget.detalhes.anexo[0].data[aux]
                                                .campo !=
                                            'Formato')
                                          _listaFicheiro(0, aux),
                                  if (widget.detalhes.anexo.isNotEmpty)
                                    if ((widget.detalhes.anexo.length) >= 2)
                                      for (int i = 0;
                                          i < (widget.detalhes.anexo.length);
                                          i++)
                                        for (int aux = 0;
                                            aux <
                                                (widget.detalhes.anexo[i].data
                                                        .length) -
                                                    1;
                                            aux++)
                                          _listaFicheiro(i, aux),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              : Container(),
          widget.detalhes.anexo.isNotEmpty == true
              ? SizedBox(
                  height: 20,
                )
              : Container(),
        ],
      ),
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF3b98d4)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      " A processar ... aguarde...",
                      style: new TextStyle(
                        color: Colors.orange,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 0), () {
      //Navigator.pop(context); //pop dialog
      setState(() {
        _loading = true;
      });
    }).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  _mudarEstado() {
    new Future.delayed(
      new Duration(seconds: 1),
      () {
        setState(() {
          docAbrir = false;
        });
      },
    );
  }

  _listaFicheiro(int i, int aux) {
    final largura = MediaQuery.of(context).size.width;

    return GestureDetector(
      onDoubleTap: () async {
        String fo = widget.detalhes.anexo[i].data[aux].valor.toString() == 'PDF'
            ? 'pdf'
            : 'bug';
        BlocProvider.of<ListaOperacoesBloc>(context).ficheiroString =
            await BlocProvider.of<ListaOperacoesBloc>(context).buscaPDF(
                widget.detalhes.anexo[i].operationId,
                widget.detalhes.anexo[i].idConteudo);
        BlocProvider.of<ListaOperacoesBloc>(context).nomeAnexo =
            widget.detalhes.anexo[i].data[aux].valor;
        BlocProvider.of<ListaOperacoesBloc>(context).opID =
            widget.detalhes.anexo[aux].operationId;
        BlocProvider.of<ListaOperacoesBloc>(context).idCont =
            widget.detalhes.anexo[aux].idConteudo;
        //print(widget.sistemaNome + ' testando');
        // ignore: unnecessary_statements
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<ListaOperacoesBloc>(context),
            child: PdfAbrir(
              sis: widget.sistemaNome,
            ),
          ),
        );
      },
      child: Container(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.34,
                  height: MediaQuery.of(context).size.height * 0.13,
                  //aqui
                  margin: EdgeInsetsDirectional.only(
                      start: largura * 0.005, top: largura * 0.04),
                  child: Image.asset(
                    'assets/images/borda.png',
                    fit: BoxFit.fill,
                    //fit: BoxFit.fill,
                  ),
                ),
                if (i % 2 == 0) SizedBox(width: largura * 0.06),
              ],
            ),
            Positioned(
              top: largura * 0.09,
              left:
                  widget.detalhes.anexo[i].data[aux].valor.toString().length ==
                          7
                      ? largura * 0.13
                      : largura * 0.11,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/fich.PNG',
                        width: largura * 0.09,
                        height: largura * 0.1,
                      ),
                    ),
                    AutoSizeText(
                      widget.detalhes.anexo[i].data[aux].valor
                                  .toString()
                                  .length >
                              8
                          ? 'Ecomenda'
                          : widget.detalhes.anexo[i].data[aux].valor,
                      style: TextStyle(fontSize: 2),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Gera o conteudo das celulas
  List<DataCell> getCelulas(List<dynamic> cells) => cells
      .map(
        (data) => DataCell(
          //Itens da tabela
          Text(
            data.toString().length >= 14
                ? '$data                '
                : (data.toString().length >= 7 && data.toString().length < 10)
                    ? '$data            '
                    : (data.toString().length >= 10 &&
                            data.toString().length < 14)
                        ? '$data     '
                        : data,
            style: TextStyle(
              fontSize: 16,
              fontFamily: "SEGOEUI",
            ),
          ),
        ),
      )
      .toList();

  //Desenha o cabeçalho das Colunas
  List<DataColumn> getColunas(List<String> columns) => columns
      .map((String columns) => DataColumn(
            //Desenho do cabeçalho da tabela
            label: Text(
              columns,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "SEGOEUI",
              ),
            ),
          ))
      .toList();

  //Desenha as linhas
  List<DataRow> getLinhas(List<String> columns, List<dynamic> cell) => columns
      .map((String columns) => DataRow(
            cells: getCelulas(cell),
          ))
      .toList();

  List<DataRow> tabela() {
    var celulas = [];
    List<DataRow> lista = [];
    for (int i = 0; i < widget.detalhes.grelha.data.length; i++) {
      celulas = [
        widget.detalhes.grelha.data[i].valor1,
        widget.detalhes.grelha.data[i].valor2,
        widget.detalhes.grelha.data[i].valor3
      ];
      DataRow rows = DataRow(cells: getCelulas(celulas));
      lista.add(rows);
    }
    return lista;
  }

  //Construção da Tabela
  Widget tabelaDados() {
    return Container(
      child: FittedBox(
        fit: BoxFit.fill,
        //margin: EdgeInsets.only(right: 10, top: 10), poderia usar o FitdBox para rem o pading
        child: DataTable(
          horizontalMargin: 1,

          columnSpacing: MediaQuery.of(context).size.width * 0.02,
          columns: getColunas(columns),
          rows: tabela(),
          dataRowHeight: MediaQuery.of(context).size.width * 0.2, //tab
        ),
      ),
    );
  }

  //Construção dos campos
  Widget camposPovoar(int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 1,
          ),
          child: Text(
            (widget.detalhes.dados[i].campo == 'ok')
                ? ''
                : widget.detalhes.dados[i].campo,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 15,
                fontFamily: "SEGOEUI"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            (widget.detalhes.dados[i].campo.contains('Data'))
                ? widget.detalhes.dados[i].valor.split('-').reversed.join('-')
                : widget.detalhes.dados[i].valor,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontFamily: "SEGOEUI",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
