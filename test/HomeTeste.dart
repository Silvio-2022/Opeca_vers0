import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Catálogo de Produtos", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Container(child: Text("Catálogo", style: TextStyle(fontSize: 20))),
    );
  }
}
