import 'dart:io';

class VerificaConexao {
  Future<List> buscaConexao() async {
    List resultado = [];
    try {
      resultado = await InternetAddress.lookup('google.com');
      //print(resultado);
      return resultado;
    } catch (e) {}
    return resultado;
  }
}
