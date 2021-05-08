import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Job {
  Job(
      {@required this.id, @required this.nameKatastimatos,
      @required this.afm,
      @required this.dieuthinsiKatastimatos,
      @required this.tilephono,
      @required this.user_id
      });
  final String id;
  final String nameKatastimatos;
  final String afm;
  final String dieuthinsiKatastimatos;
  final String tilephono;
  final String user_id;

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String nameKatastimatos = data['nameKatastimatos'];
    final String afm = data['afm'];
    final String dieuthinsiKatastimatos = data['dieuthinsiKatastimatos'];
    final String tilephono = data['tilephono'];
    return Job(
        id: documentId,
        nameKatastimatos: nameKatastimatos,
        afm: afm,
        dieuthinsiKatastimatos: dieuthinsiKatastimatos,
        tilephono: tilephono);
  }

  Map<String, dynamic> toJson() {
    return {
      'nameKatastimatos': nameKatastimatos,
      'afm': afm,
      'dieuthinsiKatastimatos': dieuthinsiKatastimatos,
      'tilephono': tilephono,
      'user_id': user_id
    };
  }
}
