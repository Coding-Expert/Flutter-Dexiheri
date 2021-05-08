

import 'package:dexiheri/app/home/calendar/calendar_page.dart';
import 'package:dexiheri/app/models/event.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventPage extends StatefulWidget {

  String job;
  String category;
  EventPage({this.job, this.category});

  EventPageState createState ()=> EventPageState();
}

class EventPageState extends State<EventPage> {

  final FocusNode myFocusNodeTitle = FocusNode();
  TextEditingController titleController = new TextEditingController();
  final FocusNode myFocusNodeDescription = FocusNode();
  TextEditingController descriptionController = new TextEditingController();
  List<String> service_list = [];
  String selected_service = "";
  String courts_date = "";
  String event_date = "";
  String license_date = "";
  String image_file; 
  String upload_imageUrl;
  bool service_loading_flag = true;
  bool upload_flag = false;


  @override
  void initState() {
    super.initState();
    initServiceList();
    
  }

  Future<void> initServiceList() async {
    await LoadsModule.getService().then((value){
      setState(() {
        service_loading_flag = false;
        service_list = value;
        if(service_list.length > 0){
          selected_service = service_list[0];
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   myFocusNodeTitle.dispose();
  //   myFocusNodeDescription.dispose();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Νέα υπενθύμιση', style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          new IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.blue,
          ),
          onPressed: () {
            onSave();
          }),
        ],
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CalendarPage() ));
          }),
      ),
      body: SingleChildScrollView(
        child: upload_flag == true ? loadingWidget() : body(),
      ),
    );
  }
  Widget loadingWidget() {
    return Container(
      child: new Stack(
        children: [
          body(),
          new Positioned(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
            top: MediaQuery.of(context).size.height / 2,
            left: MediaQuery.of(context).size.width / 2,
          )
          
        ],
      ),
    );
  }

  Widget body() {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          event_date = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      'Επιλογή Ημερομηνίας',
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                  )
                ),
                Text(event_date, style: TextStyle(fontSize: 22),)
              ]
            ),
            service_loading_flag == false ?
            DropdownButton(
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              value: selected_service,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selected_service = newValue;
                });
              },
              items: service_list.map((name) {
                return DropdownMenuItem(
                  child: new Text(name, style: TextStyle(color: Colors.blue, fontSize: 22)),
                  value: name,
                );
              }).toList(),
            ) : CircularProgressIndicator(),
            TextField(
              focusNode: myFocusNodeTitle,
              controller: titleController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 22.0,
                  color: Colors.black),
              decoration: InputDecoration(hintText: "Τίτλος", hintStyle: TextStyle(color: Colors.black)),
            ),
            Row(
              children: [
                Text('Κατάστημα: ', style: TextStyle(fontSize: 22)),
                Text(widget.job, style: TextStyle(fontSize: 22)),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Κατηγορία: ', style: TextStyle(fontSize: 22)),
                Text(widget.category, style: TextStyle(fontSize: 22), maxLines: 2,),
              ],
            ),
            TextField(
              focusNode: myFocusNodeDescription,
              controller: descriptionController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              maxLines: 4,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 22.0,
                  color: Colors.black),
              decoration: InputDecoration(hintText: "Περιγραφή", hintStyle: TextStyle(color: Colors.black)),
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          courts_date = date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      'Ημερομηνία δικάσιμων',
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                  )
                ),
                Text(courts_date, style: TextStyle(fontSize: 22),)
              ]
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          license_date = date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      'Ημερομηνία λήξης άδειας',
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                  )
                ),
                Text(license_date, style: TextStyle(fontSize: 22),)
              ]
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () { getPhotoImage();},
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: image_file == null ? AssetImage('assets/images/noImage.jpg') : FileImage(new File(image_file)),
                      fit: BoxFit.fill
                    ),
                  ),
                )
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new IconButton(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: 36,
                  ),
                  onPressed: () {
                    launchURL();
                  }),
                  new IconButton(
                  icon: Icon(
                    Icons.print_sharp,
                    color: Colors.black,
                    size: 36,
                  ),
                  onPressed: () {
                    
                  }),
                  new IconButton(
                  icon: Icon(
                    Icons.mark_email_read_sharp,
                    color: Colors.black,
                    size: 36,
                  ),
                  onPressed: () {
                    send();
                  }),
                  new IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 36,
                  ),
                  onPressed: () {
                    Share.shareFiles([image_file], text: "New event about Dexiheri" + "\n" + 
                    "Title: ${titleController.text}" + "\n"
                    + "Date: ${event_date}" + "\n"
                    + "Description: ${descriptionController.text}" + "\n"
                    + "Shop: ${widget.job}" + "\n"
                    + "Service: ${selected_service}" + "\n"
                    + "courts_date: ${courts_date}" + "\n"
                    + "license_date: ${license_date}" + "\n"
                    );
                    // displayBottomSheet(context);
                  }),
                ],
              ),
            )
            // Container(
            //   margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
            //   child:RaisedButton(
            //     onPressed: () => {
            //       displayBottomSheet(context),
            //     },
            //     color: Colors.blue,
            //     padding: EdgeInsets.all(10.0),
            //     child: Row(
            //       children: [
            //         Icon(Icons.share, color: Colors.white, size: 32),
            //         Expanded(
            //           child: Container(
            //             child: new Align(alignment:Alignment.center, child:Text('share', style: TextStyle(color: Colors.white, fontSize: 24),))
            //           )
            //         )
            //       ]
            //     )
            //   )
            // )
          ]
        ),
      )
    );
  }

  Future<void> getPhotoImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image_file = pickedFile.path;
    });
    
  }
  void launchURL() async {
    var url = 'mailto:jinfo@dexiheri.gr?subject=new subject&body=new body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> send() async {
    final Email email = Email(
      body: descriptionController.text,
      subject: titleController.text,
      recipients: ["info@dexiheri.gr"],
      // attachmentPath: attachment,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      print("----${platformResponse}");
    } catch (error) {
      platformResponse = error.toString();
      print("----${platformResponse}");
    }

    if (!mounted) return;
  }

  Future<void> onSave() {
    if(image_file == null){
      upload_imageUrl = null;
      save();
    }
    else{
      onUploadUserImage(DatabaseService.user_uid, new File(image_file));
    }
    
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: MediaQuery.of(context).size.width  * 0.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(ctx).pop();
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(top: Platform.isAndroid ? ((MediaQuery.of(context).size.width  * 0.4) - kBottomNavigationBarHeight) / 2 : ((MediaQuery.of(context).size.width  * 0.4) - 80) / 2),
              //     child: Image.asset('assets/images/email.png', width: 40, height: 40, fit: BoxFit.cover),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: Platform.isAndroid ? ((MediaQuery.of(context).size.width  * 0.4) - kBottomNavigationBarHeight) / 2 : ((MediaQuery.of(context).size.width  * 0.4) - 80) / 2),
                  child: Image.asset('assets/images/whatsapp.png', width: 40, height: 40, fit: BoxFit.cover),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: Platform.isAndroid ? ((MediaQuery.of(context).size.width  * 0.4) - kBottomNavigationBarHeight) / 2 : ((MediaQuery.of(context).size.width  * 0.4) - 80) / 2),
                  child: Image.asset('assets/images/viber.png', width: 40, height: 40, fit: BoxFit.cover),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: Platform.isAndroid ? ((MediaQuery.of(context).size.width  * 0.4) - kBottomNavigationBarHeight) / 2 : ((MediaQuery.of(context).size.width  * 0.4) - 80) / 2),
                  child: Image.asset('assets/images/messanger.png', width: 40, height: 40, fit: BoxFit.cover),
                ),
              )
            ],
          )
        );
      }
    );
  }

  Future<void> onUploadUserImage(String imageId, File imageFile){
    Reference ref = FirebaseStorage.instance.ref().child(imageId).child(DateTime.now().toString() + " image.jpg");
    UploadTask uploadTask = ref.putFile(imageFile);
    setState(() {
      upload_flag = true;
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((url){
          upload_imageUrl = url;
          print("----uploadImageUrl---:${upload_imageUrl}");
          save();
        });
      });
    });
  }

  void save(){
    Event event = Event(
      id: widget.job,
      date: event_date,
      title: titleController.text,
      service: selected_service,
      description: descriptionController.text,
      courts_date: courts_date,
      license_date: license_date,
      category: widget.category,
      image: upload_imageUrl
    );
    LoadsModule.saveEvent(event).then((value){
      if(value == "success"){
        Toast.show("new event had saved successfully", context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CalendarPage() ));
      }
    });
  }
  
}