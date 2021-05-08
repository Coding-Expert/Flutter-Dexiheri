import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/models/eggrafaTimologisis.dart';
import 'package:dexiheri/common_widgets/show_alert_dialog.dart';
import 'package:dexiheri/common_widgets/show_exception_alert_dialog.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditStoixeiaTimologisis extends StatefulWidget {
  const EditStoixeiaTimologisis({Key key, @required this.database, this.eggrafo})
      : super(key: key);
  final Database database;
  final EggrafoTimologisis eggrafo;

  static Future<void> show(BuildContext context, {EggrafoTimologisis eggrafo}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
          builder: (context) => EditStoixeiaTimologisis(database: database, eggrafo: eggrafo),
          fullscreenDialog: true),
    );
  }

  @override
  _EditStoixeiaTimologisisState createState() => _EditStoixeiaTimologisisState();
}

class _EditStoixeiaTimologisisState extends State<EditStoixeiaTimologisis> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _plirofories;
  String _kodikos;

  @override
  void initState(){
    super.initState();
    if(widget.eggrafo !=null){
      _title = widget.eggrafo.name;
      _plirofories = widget.eggrafo.plirofories;
      _kodikos = widget.eggrafo.kodikos;
    }
  }


  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.eggrafo == null ? 'Νέο αρχείο Τιμολόγησης' : 'Επεξεργασία αρχείου'),
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Τίτλος'),
        initialValue: _title,
        onSaved: (value) => _title = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Ο τίτλος δεν μπορεί να είναι κενός',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Πληροφορίες'),
        initialValue: _plirofories,
        onSaved: (value) => _plirofories = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Το πεδίο δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Κωδικός'),
        initialValue: _kodikos,
        onSaved: (value) => _kodikos = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Ο κωδικός δεν μπορεί να είναι κενός',
      ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: _submit,
        child: Text('Αποθήκευση'),
      )
    ];
  }

  Future<void> _submit() async {
    //TODO: Validate $ Save form
    if (_validateAndSaveForm()) {
      try {
        final eggrafaTimologisis =
            await widget.database.eggrafaTimologisisStream().first;
        final allEggrafa =
            eggrafaTimologisis.map((eggrafo) => eggrafo.name).toList();
        if(widget.eggrafo != null){
          allEggrafa.remove(widget.eggrafo.name);
        }
        if (allEggrafa.contains(_title)) {
          showAlertDialog(context,
              title: 'Το όνομα χρησιμοποιείται ήδη',
              content: 'Εισάγεται διαφορετικό όνομα',
              defaultActionText: 'ΟΚ');
        } else {
          final id = widget.eggrafo?.id ?? documentIdFromCurrentDate();
          print(
              'form saved: titlos: $_title, plirofories: $_plirofories, kodikos: $_kodikos');
          final eggrafoTimologisis = EggrafoTimologisis(id: id,
              name: _title, plirofories: _plirofories, kodikos: _kodikos);
          await widget.database.setEggrafoTimologisis(eggrafoTimologisis);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context, title: 'Μήνυμα Λάθους', exception: e);
      }
    }
  }
}
