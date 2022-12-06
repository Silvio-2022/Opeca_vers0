
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/views/ui/main/cabecalho.dart';
import 'package:flutter/material.dart';

class Dashboard1 extends StatefulWidget {
  final List<Sistema> listaSistemas;
  Dashboard1({required this.listaSistemas});
  @override
  State<Dashboard1> createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  @override
  initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Cabecalho(listaSistemas: widget.listaSistemas);
  }
}
