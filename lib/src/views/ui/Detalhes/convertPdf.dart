import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfConverter {
  static Future<File> writeFile(String nome, String formato, String ficb64) async {
    late File filePdf;
    formato = formato.toLowerCase();
    final decodedBytes = base64Decode(ficb64);
    final directory = await getExternalStorageDirectory();
    //print(directory!.path);
    filePdf = File('${directory!.path}/$nome.$formato');
    
    //print(filePdf.path);
    filePdf.writeAsBytesSync(List.from(decodedBytes));
    
    return filePdf;
  }
 
}
