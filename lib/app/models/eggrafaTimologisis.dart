
import 'package:meta/meta.dart';

class EggrafoTimologisis{
  EggrafoTimologisis({@required this.id, @required this.name, @required this.plirofories, @required this.kodikos});
  final String name;
  final String kodikos;
  final String plirofories;
  final String id;

  factory EggrafoTimologisis.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String kodikos = data['kodikos'];
    final String plirofories = data['plirofories'];
    return EggrafoTimologisis(
      id: documentId,
        name: name,
        plirofories: plirofories,
        kodikos: kodikos
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'plirofories': plirofories,
      'kodikos': kodikos
    };
  }
}