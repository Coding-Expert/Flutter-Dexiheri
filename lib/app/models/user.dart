import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Xristis {
  Xristis(
      {@required this.id, @required this.eponymo,
        @required this.onoma,
        @required this.fylo,
        @required this.dieuthinsi,
        @required this.tilephono});
  final String id;
  final String eponymo;
  final String onoma;
  final String fylo;
  final String dieuthinsi;
  final String tilephono;

  factory Xristis.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String eponymo = data['eponymo'];
    final String onoma = data['onoma'];
    final String fylo = data['fylo'];
    final String dieuthinsi = data['dieuthinsi'];
    final String tilephono = data['tilephono'];
    return Xristis(
        id: documentId,
        eponymo: eponymo,
        onoma: onoma,
        fylo: fylo,
        dieuthinsi: dieuthinsi,
        tilephono: tilephono);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eponymo': eponymo,
      'onoma': onoma,
      'fylo': fylo,
      'dieuthinsi': dieuthinsi,
      'tilephono': tilephono,
    };
  }
}
