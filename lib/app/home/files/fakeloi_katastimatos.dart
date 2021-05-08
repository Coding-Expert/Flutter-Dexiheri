
import 'package:dexiheri/app/home/calendar/calendar_page.dart';
import 'package:dexiheri/app/home/files/search.dart';
import 'package:dexiheri/app/home/files/share.dart';
import 'package:dexiheri/app/home/files/stoixeiaTimologisis.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_new_file.dart';
import 'eggrafa_katastimatos.dart';

class FakeloiKatastimatos extends StatelessWidget {
  List<String> job_name_list = new List<String>();
  String dropdownValue = 'Επιλογή Καταστήματος';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ΦΑΚΕΛΟΙ ΚΑΤΑΣΤΗΜΑΤΟΣ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 450,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/white_fakeloi.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    /*Positioned(
                      left: 80,
                      width: 500,
                      //height: 700,
                      top: 70,
                      child: Container(
                        child: Column(
                          children: [
                            Text('Κατάστημα Α', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                          ],
                        ),
                        *//*Text(
                          'Επιλογή Καταστήματος',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),*//*
                      ),
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //_buildFakeloiKatigories(),
                        GestureDetector(
                          // onTap: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => EggrafaKatastimatos()));
                          // }
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'A. Έγγραφα Καταστήματος',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
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
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewFile()));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    'B. Καταχώρηση νέου εγγράφου που παραλήφθηκε',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StoixeiaTimologisis()));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    'Γ. Στοιχεία τιμολόγησης / Τραπ. Λογαριασμοί',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    'Δ. Ημερολόγιο ελέγχων / προθεσμιών / δικάσιμων',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SharePage()));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    'Στ. Δικαιώματα κοινής χρήσης',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                              Icon(Icons.arrow_right)
                            ],
                          )
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildLogo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFakeloiKatigories() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'A. Έγγραφα Καταστήματος',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Icon(Icons.arrow_right)
          ],
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
                child: Text(
              'B. Καταχώρηση νέου εγγράφου που παραλήφθηκε',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Icon(Icons.arrow_right)
          ],
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: (){
            print('hi');
                },
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Γ. Στοιχεία τιμολόγησης / Τραπ. Λογαριασμοί',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Icon(Icons.arrow_right)
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
                child: Text(
              'Δ. Ημερολόγιο ελέγχων / προθεσμιών / δικάσιμων',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Icon(Icons.arrow_right)
          ],
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
                child: Text(
              'Στ. Δικαιώματα κοινής χρήσης',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Icon(Icons.arrow_right)
          ],
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      height: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png', scale: 1.3),
        ],
      ),
    );
    //return Image.asset('assets/images/logo.png');
  }
}
