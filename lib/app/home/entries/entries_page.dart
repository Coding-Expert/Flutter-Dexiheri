import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/global.dart';
import 'package:dexiheri/services/database.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EntriesPage extends StatefulWidget {
  EntriesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  EntriesPageState createState() => EntriesPageState();
}

class EntriesPageState extends State<EntriesPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(DatabaseService.user_uid)
      ),
    );
  }
}