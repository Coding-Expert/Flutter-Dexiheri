import 'package:dexiheri/app/home/files/certification/certification_result.dart';
import 'package:dexiheri/app/home/files/courts/courts_result.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class CourtsPage extends StatefulWidget {
  String title;
  int category_number;
  Job job;

  CourtsPage({ 
    Key key,
    this.title,
    this.category_number,
    this.job
  }) : super(key: key);

  CourtsPageState createState ()=> CourtsPageState();
}

class CourtsPageState extends State<CourtsPage> {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourtsResultPage(
                        category: widget.title,
                        category2: "ΠΟΙΝΙΚΑ ΔΙΚΑΣΤΗΡΙΑ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".1 " + 'ΠΟΙΝΙΚΑ ΔΙΚΑΣΤΗΡΙΑ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourtsResultPage(
                        category: widget.title,
                        category2: "ΔΙΟΙΚΗΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".2 " + 'ΔΙΟΙΚΗΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourtsResultPage(
                        category: widget.title,
                        category2: "ΑΣΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".3 " + 'ΑΣΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ',
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