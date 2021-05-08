import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/common_widgets/show_alert_dialog.dart';
import 'package:dexiheri/common_widgets/show_exception_alert_dialog.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.database, this.job}) : super(key: key);
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, {Job job}) async {
    final database = Provider.of<Database>(context, listen: false);
    
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => EditJobPage(database: database, job: job),
        fullscreenDialog: true),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _afm;
  String _dieuthinsi;
  String _tilefono;
  FocusNode myFocusNodeName = new FocusNode();
  FocusNode myFocusNodeAfm = new FocusNode();
  FocusNode myFocusNodeDieythinsi = new FocusNode();
  FocusNode myFocusNodeTilefono = new FocusNode();


  @override
  void initState(){
    super.initState();
    
    if(widget.job !=null){
      _name = widget.job.nameKatastimatos;
      _afm = widget.job.afm;
      _dieuthinsi = widget.job.dieuthinsiKatastimatos;
      _tilefono = widget.job.tilephono;
    }
  }


  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async{
    //TODO:Validate & save form
    if(_validateAndSaveForm()){
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.nameKatastimatos).toList();
        if (widget.job != null){
          allNames.remove(widget.job.nameKatastimatos);
        }
        if(allNames.contains(_name)){
          showAlertDialog(context, title: 'Το όνομα χρησιμοποιείται ήδη', content: 'Διαλέξτε άλλο όνομα', defaultActionText: 'ΟΚ');
        } else {
          print(
              'from saved: name: $_name , afm: $_afm, dieuthinsi: $_dieuthinsi, tilefono: $_tilefono');
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id,
              nameKatastimatos: _name,
              afm: _afm,
              dieuthinsiKatastimatos: _dieuthinsi,
              tilephono: _tilefono);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
          //TODO:submit data to FIrestore
        }
      } on FirebaseException catch (e){
        showExceptionAlertDialog(context, title: 'Μήνυμα λάθους', exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ?'Νέο κατάστημα' : 'Επεξεργασία'),
        actions: <Widget>[
          FlatButton(
            child: Text('Αποθήκευση'),
            onPressed: _submit,
          ),
        ],
      ),
      body:_buildContents(),
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

  List<Widget>_buildFormChildren() {
    return [
      TextFormField(
        focusNode: myFocusNodeName,
        initialValue: _name,
        decoration: InputDecoration(
          labelText: 'Όνομα Καταστήματος',
          labelStyle: TextStyle(color: myFocusNodeName.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : 'Το όνομα δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeAfm,
        initialValue: _afm,
        decoration: InputDecoration(
            labelText: 'ΑΦΜ',
            labelStyle: TextStyle(color: myFocusNodeAfm.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _afm = value,
        validator: (value) => value.isNotEmpty ? null : 'Το ΑΦΜ δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeDieythinsi,
        initialValue: _dieuthinsi,
        decoration: InputDecoration(
            labelText: 'Διεύθυνση Καταστήματος',
            labelStyle: TextStyle(color: myFocusNodeDieythinsi.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _dieuthinsi = value,
        validator: (value) => value.isNotEmpty ? null : 'Η διεύθυνση δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeTilefono,
        initialValue: _tilefono,
        decoration: InputDecoration(
            labelText: 'Τηλέφωνο Καταστήματος',
            labelStyle: TextStyle(color: myFocusNodeTilefono.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _tilefono = value,
        validator: (value) => value.isNotEmpty ? null : 'Το τηλέφωνο δεν μπορεί να είναι κενό',
        keyboardType: TextInputType.numberWithOptions( signed: false, decimal: false),
      )
    ];
  }
}
