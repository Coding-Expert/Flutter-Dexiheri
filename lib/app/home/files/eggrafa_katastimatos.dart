import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EggrafaKatastimatos extends StatefulWidget {
  @override
  _EggrafaKatastimatosState createState() => _EggrafaKatastimatosState();
}

class _EggrafaKatastimatosState extends State<EggrafaKatastimatos> {
  String _value = 'aaa';
  List<String> job_name_list = new List<String>();
  String selected_job_name = "";
  bool job_checking = false;

  @override
  void initState() {
    super.initState();
    job_checking = true;
    getJobList();
  }

  Future<void> getJobList() {
    LoadsModule.getJobs().then((value){
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            print("-----${value[i].nameKatastimatos}");
            job_name_list.add(value[i].nameKatastimatos);
          }
          selected_job_name = job_name_list[0];
        }
        job_checking = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.lightBlueAccent
                ),
              ),
              child: DropdownButton(
                focusColor: Colors.white,
                dropdownColor: Colors.white,
                value: selected_job_name,
                onChanged: (newValue) {
                  setState(() {
                    selected_job_name = newValue;
                  });
                },
                items: job_name_list.map((name) {
                  return DropdownMenuItem(
                    child: new Text(name, style: TextStyle(color: Colors.black54)),
                    value: name,
                  );
                }).toList(),
              ),
            )
          ],
        )
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Text('1'),
              title: Text('ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ΓΝΩΣΤΟΠΟΙΗΣΗ'),
            ),

          ],
        )
      ),
    );

  }
}
