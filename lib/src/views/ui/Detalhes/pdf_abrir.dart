import 'dart:convert';

import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

late String sistemaNom = '';

class PdfAbrir extends StatefulWidget {
  final sis;
  PdfAbrir({required this.sis}) {
    sistemaNom = sis;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfAbrir> {
  var _isValid = false;
  String pathPDF = "";
  late File test;
  bool i = false;
  @override
  void initState() {
    super.initState();
    if (i == true) {
      print('teste ok');
    }
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    late File filePdf;
    //formato = formato.toLowerCase();
    final decodedBytes = base64Decode(
        BlocProvider.of<ListaOperacoesBloc>(context).ficheiroString);
    final directory = await getApplicationDocumentsDirectory();
    filePdf = File(
        '${directory.path}/$BlocProvider.of<ListaOperacoesBloc>(context).nomeAnexo');
    print(filePdf.path);
    filePdf.writeAsBytesSync(List.from(decodedBytes));
    return filePdf;
  }

  @override
  void dispose() {
    print("dis 1");
    super.dispose();
  }

//Função para retroceder
  Future<void> sair() async {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 1);
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //test = File(pathPDF);
    return WillPopScope(
      onWillPop: () async {
        sair(); //Função para retroceder a tela anterior
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfffff9f9),
            title: Center(
              //margin: EdgeInsets.only(left: 10),
              child: Text(
                BlocProvider.of<ListaOperacoesBloc>(context)
                    .nomeAnexo
                    .toUpperCase(),
                style: TextStyle(
                  fontFamily: 'SEGOEUI',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: RetrocederButton(
              telaRetroceder: 'anexoVer',
              sistema: sistemaNom,
            ),
            actions: <Widget>[Text('       ')],
          ),
          body: FutureBuilder<File>(
              future: createFileOfPdfUrl(),
              builder: (context, content) {
                if (content.hasData)
                  return SfPdfViewer.file(content.data!);
                else
                  return Text('');
              })
          //path: widget.pathPDF,
          ),
    );
  }
}
