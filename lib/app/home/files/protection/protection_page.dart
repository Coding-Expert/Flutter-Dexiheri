import 'package:dexiheri/app/home/files/certification/certification_result.dart';
import 'package:dexiheri/app/home/files/protection/protection_result.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class ProtectionPage extends StatefulWidget {
  String title;
  int category_number;
  Job job;

  ProtectionPage({ 
    Key key,
    this.title,
    this.category_number,
    this.job
  }) : super(key: key);

  ProtectionPageState createState ()=> ProtectionPageState();
}

class ProtectionPageState extends State<ProtectionPage> {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
                maxLines: 2,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProtectionResultPage(
                        category: widget.title,
                        category2: "ΠΙΣΤΟΠΟΙΗΤΙΚΟ  Ή / ΚΑΙ ΜΕΛΕΤΗ ΠΥΡΟΠΡΟΣΤΑΣΙΑΣ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".1 " + 'ΠΙΣΤΟΠΟΙΗΤΙΚΟ  Ή / ΚΑΙ ΜΕΛΕΤΗ ΠΥΡΟΠΡΟΣΤΑΣΙΑΣ',
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProtectionResultPage(
                        category: widget.title,
                        category2: "ΚΑΤΟΨΗ ΠΥΡΟΣΒΕΣΤΙΚΗΣ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".2 " + 'ΚΑΤΟΨΗ ΠΥΡΟΣΒΕΣΤΙΚΗΣ',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}