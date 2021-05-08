import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Eggrafo {
  Eggrafo(
      {@required this.id, @required this.nameKatastimatos,
        @required this.fakelos,
        @required this.titlos,
        @required this.imerominia});
  final String id;
  final String nameKatastimatos;
  final String fakelos;
  final String titlos;
  final String imerominia;

  factory Eggrafo.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String nameKatastimatos = data['nameKatastimatos'];
    final String fakelos = data['fakelos'];
    final String titlos = data['titlos'];
    final String imerominia = data['imerominia'];
    return Eggrafo(
        id: documentId,
        nameKatastimatos: nameKatastimatos,
        fakelos: fakelos,
        titlos: titlos,
        imerominia: imerominia);
  }

  Map<String, dynamic> toMap() {
    return {
      'nameKatastimatos': nameKatastimatos,
      'fakelos': fakelos,
      'titlos': titlos,
      'imerominia': imerominia,
    };
  }
}
