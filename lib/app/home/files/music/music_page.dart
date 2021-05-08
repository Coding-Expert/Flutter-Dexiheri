

import 'dart:io';

import 'package:dexiheri/app/home/files/music/music_result.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  
  String title;
  int category_number;
  Job job;
  MusicPage({ 
    Key key,
    this.title,
    this.category_number,
    this.job
  }) : super(key: key);

  MusicPageState createState ()=> MusicPageState();
}

class MusicPageState extends State<MusicPage> {

  List<Job> job_list = [];
  Job selected_job;
  bool job_loading = true;
  
  List<String> music_category_list = [];
  List<String> current_list = [];
  bool category_loading = false;

  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(widget.category_number.toString() + ". " + widget.title, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                      category: widget.title,
                      category2: "ΑΔΕΙΑ ΜΟΥΣΙΚΗΣ",
                      category3: null,
                      job: widget.job
                    )));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.category_number.toString() + ".1 " + 'ΑΔΕΙΑ ΜΟΥΣΙΚΗΣ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                        )
                      ),
                      Icon(Icons.arrow_right)
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                      category: widget.title,
                      category2: "ΠΑΡΑΤΑΣΗ ΩΡΑΡΙΟΥ ΜΟΥΣΙΚΗΣ",
                      category3: null,
                      job: widget.job
                    )));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.category_number.toString() + ".2 " + 'ΠΑΡΑΤΑΣΗ ΩΡΑΡΙΟΥ ΜΟΥΣΙΚΗΣ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                        )
                      ),
                      Icon(Icons.arrow_right)
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                      widget.category_number.toString() + ".3 " + "ΠΝΕΥΜΑΤΙΚΑ ΚΑΙ ΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      maxLines: 1,
                  ),
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                          category: widget.title,
                          category2: "ΠΝΕΥΜΑΤΙΚΑ ΚΑΙΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ",
                          category3: "ΕΔΕΜ (ΠΡΩΗΝ ΕΥΕΔ/ΑΕΠΙ)",
                          job: widget.job
                        )));
                      },
                      child: new Align(alignment: Alignment.centerLeft, child: new Text("2.3.1 ΕΔΕΜ (ΠΡΩΗΝ ΕΥΕΔ/ΑΕΠΙ)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                          category: widget.title,
                          category2: "ΠΝΕΥΜΑΤΙΚΑ ΚΑΙΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ",
                          category3: "ΑΥΤΟΔΙΑΧΕΙΡΙΣΗ",
                          job: widget.job
                        )));
                      },
                      child: new Align(alignment: Alignment.centerLeft, child: new Text("2.3.2 ΑΥΤΟΔΙΑΧΕΙΡΙΣΗ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                          category: widget.title,
                          category2: "ΠΝΕΥΜΑΤΙΚΑ ΚΑΙΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ",
                          category3: "GEA",
                          job: widget.job
                        )));
                      },
                      child: new Align(alignment: Alignment.centerLeft, child: new Text("2.3.3 GEA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MusicResultPage(
                          category: widget.title,
                          category2: "ΠΝΕΥΜΑΤΙΚΑ ΚΑΙΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ",
                          category3: "GRAMMO",
                          job: widget.job
                        )));
                      },
                      child: new Align(alignment: Alignment.centerLeft, child: new Text("2.3.4 GRAMMO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    )
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
              ]
            ),
          )
          ],
        ),
      ),
    );
  }

  
  
}