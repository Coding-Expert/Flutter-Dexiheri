

import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/music_document.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';

class MusicDetailPage extends StatefulWidget {

  Document document;

  MusicDetailPage({ 
    Key key,
    this.document,
    
  }) : super(key: key);
  MusicDetailPageState createState ()=> MusicDetailPageState();
}

class MusicDetailPageState extends State<MusicDetailPage> {


  String url;
  String file_extension;
  PDFDocument doc;
  File file;
  bool pdf_loading = false;

  @override
  void initState(){
    super.initState();
    if(widget.document.image != null){
      url = widget.document.image;
      file_extension = url.substring(url.lastIndexOf('.') + 1, url.lastIndexOf('.') + 4);
      print("---fiel extension:${file_extension}");
      if(file_extension == "pdf") {
        setState(() {
          pdf_loading = true;
        });
        getPdfFile(url);
      }
    }
  }

  Future<void> getPdfFile(String httpPath) async {
    String uri = Uri.decodeFull(httpPath);
    final RegExp regex = RegExp('([^?/]*\.(pdf))');
    final String fileName = regex.stringMatch(uri);

    print("-----file name:${fileName}");
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$fileName');
    final Reference ref = FirebaseStorage.instance.ref().child(DatabaseService.user_uid).child(fileName);
    final DownloadTask downloadTask = ref.writeToFile(file);
    await downloadTask.then((value) async {
      print("------byte:${value.totalBytes}");
      doc = await PDFDocument.fromFile(file);
      setState(()  {
        pdf_loading = false;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Στοιχεία Αρχείου'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.document.shop, style: TextStyle(color: Colors.blue, fontSize: 16), textAlign: TextAlign.center)
              ]
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Text("Τίτλος: ${widget.document.title == null ? "" : widget.document.title}", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),maxLines: 2,),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text("Κατηγορία: ${widget.document.category2 == null ? "" : widget.document.category2}", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),maxLines: 2, textAlign: TextAlign.center,),
              Padding(padding: EdgeInsets.only(top: 10)),
              /*Text("Υποκατηγορία: ${widget.document.category3 == null ? "" : widget.document.category3}", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),maxLines: 2, textAlign: TextAlign.center,),
              Padding(padding: EdgeInsets.only(top: 10)),*/
              Text("${widget.document.date == null ? "" : widget.document.date}", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,)),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    ),
                  ),
                  ),
                  Image.asset('assets/images/eikonidio.jpeg', width: 48, height: 48, fit: BoxFit.fill),
                  Expanded(child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 30.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              pdf_loading == true ? CircularProgressIndicator() :
                file_extension == "pdf" ?
                  Container(
                        height: 400,
                        child: PDFViewer(
                          document: doc,
                          
                        )
                  ):
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
                            image: url == null ? AssetImage('assets/images/photo.png') :  NetworkImage(widget.document.image),
                            fit: BoxFit.fill
                          ),
                        ),
                      )
                    )
                  ),
               
            ],
          )
        ),
      ),
    );
  }
  
}