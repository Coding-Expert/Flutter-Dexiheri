import 'package:flutter/material.dart';

class Misthotirio extends StatefulWidget {
  @override
  _MisthotirioState createState() => _MisthotirioState();
}

class _MisthotirioState extends State<Misthotirio> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Μισθωτήριο'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text('Νέο',
                style: TextStyle(fontSize: 18.0, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  void _getCurrentUser() {
    print('hi');
  }
}
