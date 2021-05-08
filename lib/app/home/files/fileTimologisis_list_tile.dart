import 'package:dexiheri/app/models/eggrafaTimologisis.dart';
import 'package:flutter/material.dart';

class FileTimologisisListFile extends StatelessWidget {
  const FileTimologisisListFile({Key key, @required this.eggrafo, this.onTap}) : super(key: key);
  final EggrafoTimologisis eggrafo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(eggrafo.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
