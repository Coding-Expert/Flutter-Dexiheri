
import 'package:dexiheri/app/home/files/Notification/notification_result.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  String title;
  int category_number;
  Job job;
  NotificationPage({ 
    Key key,
    this.title,
    this.category_number,
    this.job
  }) : super(key: key);

  NotificationPageState createState ()=> NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationResultPage(
                        category: widget.title,
                        category2: "ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ΓΝΩΣΤΟΠΟΙΗΣΗ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".1 " + 'ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ΓΝΩΣΤΟΠΟΙΗΣΗ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationResultPage(
                        category: widget.title,
                        category2: "ΒΕΒΑΙΩΣΗ ΕΓΚΑΤΑΣΤΑΣΗΣ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".2 " + 'ΒΕΒΑΙΩΣΗ ΕΓΚΑΤΑΣΤΑΣΗΣ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationResultPage(
                        category: widget.title,
                        category2: "ΠΑΡΑΒΟΛΟ ΑΔΕΙΑΣ ΛΕΙΤΟΥΡΓΙΑΣ/ ΓΝΩΣΤΟΠΟΙΗΣΗΣ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".3 " + 'ΠΑΡΑΒΟΛΟ ΑΔΕΙΑΣ ΛΕΙΤΟΥΡΓΙΑΣ/ ΓΝΩΣΤΟΠΟΙΗΣΗΣ',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationResultPage(
                        category: widget.title,
                        category2: "ΒΕΒΑΙΩΣΗ ΜΗ ΟΦΕΙΛΗΣ/ ΔΗΜΟΤΙΚΗ ΕΝΗΜΕΡΟΤΗΤΑ",
                        category3: null,
                        job: widget.job
                      )));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.category_number.toString() + ".4 " + 'ΒΕΒΑΙΩΣΗ ΜΗ ΟΦΕΙΛΗΣ/ ΔΗΜΟΤΙΚΗ ΕΝΗΜΕΡΟΤΗΤΑ',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}