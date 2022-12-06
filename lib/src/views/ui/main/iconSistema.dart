import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class IconSistema extends StatefulWidget {
  final String imageAnalysed;
  final String nome;
  const IconSistema({required this.imageAnalysed, required this.nome});

  @override
  _IconSistemaState createState() => _IconSistemaState();
}

class _IconSistemaState extends State<IconSistema> {
  late File fileImg;
  bool isLoading = true;

  void writeFile() async {
    final decodedBytes = base64Decode(widget.imageAnalysed);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/${widget.nome}.png');
    //print(fileImg.path);
    fileImg.writeAsBytesSync(List.from(decodedBytes));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      writeFile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Image.file(fileImg, width: 55, );
  }
}
