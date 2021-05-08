import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/home/files/emptyFilesTimologisis_content.dart';
import 'package:dexiheri/app/home/files/fileTimologisis_list_tile.dart';
import 'package:dexiheri/app/home/files/list_items_files_timologisis_builder.dart';
import 'package:dexiheri/app/models/eggrafaTimologisis.dart';
import 'package:dexiheri/common_widgets/show_exception_alert_dialog.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_stoixeiaTimologisis_page.dart';

class StoixeiaTimologisis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Temporary code: delete me
    final database = Provider.of<Database>(context, listen: false);
    database.eggrafaTimologisisStream();
    return Scaffold(
      appBar: AppBar(
        title: Text('Στοιχεία τιμολόγησης'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditStoixeiaTimologisis.show(context),
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<EggrafoTimologisis>>(
      stream: database.eggrafaTimologisisStream(),
      builder: (context, snapshot) {
        return ListFilesTimologisisItemsBuilder<EggrafoTimologisis>(
          snapshot: snapshot,
          itemBuilder: (context, eggrafo) => Dismissible(
            key: Key('eggrafoTimologisis-${eggrafo.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, eggrafo),
            child: FileTimologisisListFile(
                eggrafo: eggrafo,
                onTap: () =>
                    EditStoixeiaTimologisis.show(
                        context, eggrafo: eggrafo)),
          ),
        );/*
        if (snapshot.hasData) {
          final eggrafa = snapshot.data;
          if(eggrafa.isNotEmpty) {
            final children = eggrafa
                .map((eggrafo) =>
                FileTimologisisListFile(
                    eggrafo: eggrafo,
                    onTap: () =>
                        EditStoixeiaTimologisis.show(
                            context, eggrafo: eggrafo)))
                .toList();
            return ListView(children: children);
          }
          return EmptyFilesTimologisisContent();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Δεν λήφθηκαν δεδομένα'),
          );
        }
        return Center(child: CircularProgressIndicator());*/
      },
    );
  }

  Future<void> _delete(BuildContext context, EggrafoTimologisis eggrafo) async{
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJEggrafoTimologisis(eggrafo);
    } on FirebaseException catch (e){
      showExceptionAlertDialog(context, title: 'Μήνυμα λάθους', exception: e);
    }
  }
}
