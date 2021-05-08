import 'package:dexiheri/app/models/user.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/common_widgets/show_alert_dialog.dart';
import 'package:dexiheri/common_widgets/show_exception_alert_dialog.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:dexiheri/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key, @required this.database, this.xristis}) : super(key: key);
  final Database database;
  final Xristis xristis;

  static Future<void> show(BuildContext context, {Xristis xristis}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => AccountPage(database: database, xristis: xristis),
        fullscreenDialog: true),
    );
  }

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _eponymoController = TextEditingController();
  final TextEditingController _onomaController = TextEditingController();
  final TextEditingController _fyloController = TextEditingController();
  final TextEditingController _dieuthinsiController = TextEditingController();
  final TextEditingController _kinitoController = TextEditingController();
  /*String get _eponymo => _eponymoController.text;
  String get _onoma => _onomaController.text;
  String get _kinito => _kinitoController.text;
  String get _fylo => _kinitoController.text;
  String get _dieuthinsi => _dieuthinsiController.text;*/
  List<String> fylo = [];
  String selected_fylo = "";
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _fylo;
  String _dieuthinsi;
  String _tilefono;
  String _eponimo;
  FocusNode myFocusNodeEponymo = new FocusNode();
  FocusNode myFocusNodeName = new FocusNode();
  FocusNode myFocusNodeFylo = new FocusNode();
  FocusNode myFocusNodeTilefono = new FocusNode();
  FocusNode myFocusNodeDieythinsi = new FocusNode();

  @override
  void initState(){
    super.initState();
    initFyloList();
    getUserInfo();
    //if(widget.xristis !=null){
      //_eponimo = widget.xristis.eponymo;
      //_onoma = widget.xristis.onoma;
      //_kinito = widget.xristis.tilephono;
      //_dieuthinsi = widget.xristis.dieuthinsi;
      //_fylo = widget.xristis.fylo;
    //}
  }

  Future<void> getUserInfo() async {
    await LoadsModule.getXristis().then((value){
      setState(() {
        if(value.length > 0){
          _eponimo = widget.xristis.eponymo;
          _name = widget.xristis.onoma;
          _tilefono = widget.xristis.tilephono;
          _dieuthinsi = widget.xristis.dieuthinsi;
          _fylo = widget.xristis.fylo;
        }
      });
    });
  }

  void initFyloList() {
    fylo.add("Άνδρας");
    fylo.add("Γυναίκα");
    selected_fylo = fylo[0];
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Αποσύνδεση',
      content: 'Είστε βέβαιος ότι θέλετε να αποσυνδεθείτε;',
      cancelActionText: 'Ακύρωση',
      defaultActionText: 'Αποσύνδεση',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        //if(user.displayName != null)
          Text(user.displayName != null ? user.displayName : '', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Text(user.email != null ? user.email : '', style: TextStyle(color: Color(0xFF77c3ff), fontWeight: FontWeight.w500, fontSize: 16)),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildProfileInfo(User user) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildForm(),

        /*Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Στοιχεία Χρήστη', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              //_buildEponymoTextField(),
              //_buildOnomaTextField(),
              //_buildFyloTextField(),
              //_buildDieythinsiTextField(),
              //_buildKinitoTextField(),
              _buildFormChildren(),
              SizedBox(height: 8.0),
              ElevatedButton(
                  onPressed: _submit,
                  child: Text('Αποθήκευση'),
              )
            ],
          ),
        ),*/
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

  TextField _buildEponymoTextField() {
    //bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _eponymoController,
      //focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Επώνυμο",
        //hintText: 'Εισαγωγή email...',
        //errorText: showErrorText ? widget.invalidEmailErrorText : null,
        //enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      autocorrect: false,
      onChanged: (email) => _updateState(),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildOnomaTextField() {
    //bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _onomaController,
      //focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Όνομα",
        //hintText: 'Εισαγωγή email...',
        //errorText: showErrorText ? widget.invalidEmailErrorText : null,
        //enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      autocorrect: false,
      onChanged: (onoma) => _updateState(),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildKinitoTextField() {
    //bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _kinitoController,
      //focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Κινητό",
        //hintText: 'Εισαγωγή email...',
        //errorText: showErrorText ? widget.invalidEmailErrorText : null,
        //enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      autocorrect: false,
      onChanged: (kinito) => _updateState(),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildFyloTextField() {
    //bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _fyloController,
      //focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Φύλο",
        //hintText: 'Εισαγωγή email...',
        //errorText: showErrorText ? widget.invalidEmailErrorText : null,
        //enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      autocorrect: false,
      onChanged: (fylo) => _updateState(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildDieythinsiTextField() {
    //bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _dieuthinsiController,
      //focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Διεύθυνση",
        //hintText: 'Εισαγωγή email...',
        //errorText: showErrorText ? widget.invalidEmailErrorText : null,
        //enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
        border:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      autocorrect: false,
      onChanged: (dieuthinsi) => _updateState(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //onEditingComplete: _emailEditingComplete,
    );
  }

  void _updateState() {
    print('email: $_eponimo , onoma: $_name, kinito: $_tilefono, fylo: $_fylo, dieuthinsi: $_dieuthinsi');
  }


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Προφίλ'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Έξοδος',
                style: TextStyle(fontSize: 18.0, color: Colors.black87)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(auth.currentUser),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: _buildProfileInfo(auth.currentUser),
        ),
      ),
    );
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
        final id = widget.xristis?.id ?? documentIdFromCurrentDate();
        final database = Provider.of<Database>(context, listen: false);
        await database.createUser(Xristis(
            id: id,
            eponymo: _eponimo,
            onoma: _name,
            fylo: _fylo,
            dieuthinsi: _dieuthinsi,
            tilephono: _tilefono
        ));
        print('email: $_eponimo , onoma: $_name, kinito: $_tilefono, fylo: $_fylo, dieuthinsi: $_dieuthinsi');
          //TODO:submit data to FIrestore
      } on FirebaseException catch (e){
        showExceptionAlertDialog(context, title: 'Μήνυμα λάθους', exception: e);
      }
    }
  }

  List<Widget>_buildFormChildren() {
    return [
      Center(child: Text('Στοιχεία Χρήστη', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))),
      TextFormField(
        focusNode: myFocusNodeEponymo,
        initialValue: _eponimo,
        decoration: InputDecoration(
            labelText: 'Επώνυμο',
            labelStyle: TextStyle(color: myFocusNodeEponymo.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _eponimo = value,
        //validator: (value) => value.isNotEmpty ? null : 'Το όνομα δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeName,
        initialValue: _name,
        decoration: InputDecoration(
            labelText: 'Όνομα',
            labelStyle: TextStyle(color: myFocusNodeName.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _name = value,
        //validator: (value) => value.isNotEmpty ? null : 'Το ΑΦΜ δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeFylo,
        initialValue: _fylo,
        decoration: InputDecoration(
            labelText: 'Φύλο',
            labelStyle: TextStyle(color: myFocusNodeFylo.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _fylo = value,
        //validator: (value) => value.isNotEmpty ? null : 'Η διεύθυνση δεν μπορεί να είναι κενό',
      ),
      TextFormField(
        focusNode: myFocusNodeDieythinsi,
        initialValue: _dieuthinsi,
        decoration: InputDecoration(
            labelText: 'Διεύθυνση',
            labelStyle: TextStyle(color: myFocusNodeDieythinsi.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _dieuthinsi = value,
        //validator: (value) => value.isNotEmpty ? null : 'Το τηλέφωνο δεν μπορεί να είναι κενό',
        //keyboardType: TextInputType.numberWithOptions( signed: false, decimal: false),
      ),
      TextFormField(
        focusNode: myFocusNodeTilefono,
        initialValue: _tilefono,
        decoration: InputDecoration(
            labelText: 'Κινητό',
            labelStyle: TextStyle(color: myFocusNodeTilefono.hasFocus ? Colors.grey : Colors.grey)
        ),
        onSaved: (value) => _tilefono = value,
        //validator: (value) => value.isNotEmpty ? null : 'Το τηλέφωνο δεν μπορεί να είναι κενό',
        keyboardType: TextInputType.numberWithOptions( signed: false, decimal: false),
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        onPressed: _submit,
        child: Text('Αποθήκευση'),
      )
    ];
  }
    /*final database = Provider.of<Database>(context, listen: false);
    await database.createUser(Xristis(
        id: '1',
        eponymo: _eponymo,
        onoma: _onoma,
        fylo: _fylo,
        dieuthinsi: _dieuthinsi,
        tilephono: _kinito
    ));
    print('email: $_eponymo , onoma: $_onoma, kinito: $_kinito, fylo: $_fylo, dieuthinsi: $_dieuthinsi');
  }*/
}