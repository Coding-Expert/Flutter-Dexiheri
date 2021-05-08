import 'package:dexiheri/app/home/files/certification/certification_result.dart';
import 'package:dexiheri/app/home/files/diagram/diagram_result.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class DiagramPage extends StatefulWidget {
  String title;
  int category_number;
  Job job;

  DiagramPage({ 
    Key key,
    this.title,
    this.category_number,
    this.job
  }) : super(key: key);

  DiagramPageState createState ()=> DiagramPageState();
}

class DiagramPageState extends State<DiagramPage> {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DiagramResultPage(
                        category: widget.title,
                        category2: "ΤΕΧΝΙΚΗ ΕΚΘΕΣΗ ΚΑΙ ΔΙΑΓΡΑΜΜΑ ΡΟΗΣ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".1 " + 'ΤΕΧΝΙΚΗ ΕΚΘΕΣΗ ΚΑΙ ΔΙΑΓΡΑΜΜΑ ΡΟΗΣ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DiagramResultPage(
                        category: widget.title,
                        category2: "ΚΑΤΟΨΕΙΣ ΥΓΕΙΟΝΟΜΙΚΟΥ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".2 " + 'ΚΑΤΟΨΕΙΣ ΥΓΕΙΟΝΟΜΙΚΟΥ',
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