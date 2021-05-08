
import 'dart:io';

import 'package:dexiheri/app/models/event.dart';
import 'package:flutter/material.dart';

class DetailEvent extends StatefulWidget {

  final Event event;

  DetailEvent({Key key, this.event}) : super(key: key);

  DetailEventState createState ()=> DetailEventState();
}

class DetailEventState extends State<DetailEvent> {
  
  @override
  Widget build(BuildContext context) {
    print("---image path:${widget.event.image}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Πληροφορίες'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Ημερομηνία Υπενθύμισης: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.date, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Τίτλος: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.title, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Κατάστημα: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.id, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Κατηγορία: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.category, style: TextStyle(fontSize: 22), maxLines: 2, textAlign: TextAlign.center)
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                /*Row(
                  children: [
                    Text('Service: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.id, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),*/
                Row(
                  children: [
                    Text('Περιγραφή: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.description, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Ημερομηνία Δικάσιμων: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.courts_date, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Text('Ημερομηνία λήξης άδειας: ', style: TextStyle(fontSize: 22),),
                    Text(widget.event.license_date, style: TextStyle(fontSize: 22))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () { },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: widget.event.image == null ? AssetImage('assets/images/noImage.jpg') : NetworkImage(widget.event.image),
                          fit: BoxFit.fill
                        ),
                      ),
                    )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}