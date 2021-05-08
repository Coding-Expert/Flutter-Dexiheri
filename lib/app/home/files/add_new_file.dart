import 'dart:convert';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dexiheri/app/models/eggrafo.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/services/database.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:dexiheri/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dexiheri/common_widgets/Dialog.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewFile extends StatefulWidget {
  const NewFile({Key key, @required this.database}) : super(key: key);
  final Database database;

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);

    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => NewFile(database: database),
        fullscreenDialog: true),
    );
  }

  @override
  _NewFileState createState() => _NewFileState();
}

class _NewFileState extends State<NewFile> {
  String _epilogiKatastimatos;
  String _syndesiMeAntistoixoFakelo;
  String _titlosEggrafou;
  String _eisagogiStoImerologio;
  List<String> idCardPaths=new List<String>();
  String image_file; 
  String selected_job_name = "";
  List<String> job_name_list = [];
  List<String> doc_category_list = [];
  List<String> category_list = [];
  List<String> category_list2 = [];
  List<String> category_list3 = [];
  List<String> sub_category = [];
  String selected_category = "";
  String selected_category2 = "";
  String selected_category3 = "";
  bool job_checking = false;
  bool doc_category = false;
  String document_date = "Εισαγωγή στο ημερολόγιο";
  String expire_date = "Εισαγωγή στο ημερολόγιο";
  String upload_imageUrl;
  bool upload_flag = false;
  String file_extention = "";
  TextEditingController titleController = new TextEditingController();
  final FocusNode myFocusNodeTitle = FocusNode();
  final _formKey = GlobalKey<FormState>();
  PDFDocument doc;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String device_token = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid = AndroidInitializationSettings('flutter_devs');
    // var initializationSettingsIOs = IOSInitializationSettings();
    // var initSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOs);

    // flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);
    job_checking = true;
    doc_category = true;
    /*_firebaseMessaging.getToken().then((token){
      device_token = token;
      print("----token:${token}");
    });*/
    // getMessage();
    intiCategorList();
    initSubCategoryList();
    // initCategoryList2();
    // initCategoryList3();
    getJobList();
  }
  void getMessage() {
    // _firebaseMessaging.onTokenRefresh.listen((event) { 
      /*_firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        // setState(() => _message = message["notification"]["title"]);
      }, onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        // setState(() => _message = message["notification"]["title"]);
      }, onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        // setState(() => _message = message["notification"]["title"]);
      });*/
      //_firebaseMessaging.requestNotificationPermissions(
        //const IosNotificationSettings(sound: true, badge: true, alert: true)
     // );
      //_firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        //print("Settings registered: $settings");
      //});
    // });
  }

  Future<void> getJobList() async {
     await LoadsModule.getJobs().then((value){
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            print("-----${value[i].nameKatastimatos}");
            job_name_list.add(value[i].nameKatastimatos);
          }
          selected_job_name = null;
        }
        job_checking = false;
        
      });
    });
    await LoadsModule.getDocumentCategory().then((value){
      setState(() {
        doc_category = false;
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            doc_category_list.add(value[i]);
          }
          // selected_category = null;
        }
      });
    });
  }
  void intiCategorList() {
    category_list = [];
    category_list.add("ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ ΓΝΩΣΤΟΠΟΙΗΣΗ"); //1
    category_list.add("ΘΕΜΑΤΑ ΜΟΥΣΙΚΗΣ"); //2
    category_list.add("ΑΔΕΙΑ ΚΑΤΑΛΗΨΗΣ ΚΟΙΝΟΧΡΗΣΤΟΥ ΧΩΡΟΥ ΤΡΑΠΕΖΟΚΑΘΙΣΜΑΤΩΝ");    //3
    category_list.add("ΠΙΣΤΟΠΟΙΗΤΙΚΑ ΥΓΕΙΑΣ / ΑΔΕΙΕΣ ΕΡΓΑΣΙΑΣ ΕΡΓΑΖΟΜΕΝΩΝ / ΠΙΝΑΚΑΣ ΠΡΟΣΩΠΙΚΟΥ");   //4
    category_list.add("ΠΥΡΟΠΡΟΣΤΑΣΙΑ");   //5
    category_list.add("ΚΑΤΟΨΗ ΥΓΕΙΟΝΟΜΙΚΟΥ - ΔΙΑΓΡΑΜΜΑ ΡΟΗΣ");      //6
    category_list.add("ΕΤΑΙΡΙΚΟ");      //7
    category_list.add("ΜΙΣΘΩΤΗΡΙΟ");      //8
    category_list.add("ΠΟΛΕΟΔΟΜΙΚΑ ΑΚΙΝΗΤΟΥ");      //9
    category_list.add("ΚΑΝΟΝΙΣΜΟΣ ΠΟΛΥΚΑΤΟΙΚΙΑΣ");      //10
    category_list.add("ΑΔΕΙΑ/ΜΙΣΘΩΣΗ ΠΑΡΑΛΙΑΣ ΑΙΓΙΑΛΟΥ");     //11
    category_list.add("ΑΔΕΙΑ ΠΛΩΤΗΣ ΕΞΕΔΡΑΣ");        //12
    category_list.add("ΕΜΠΟΡΙΚΟ ΣΗΜΑ");       //13
    category_list.add("ΔΙΚΑΣΤΗΡΙΑ");          //14
    category_list.add("ΕΓΓΡΑΦΑ ΑΠΟ ΥΠΗΡΕΣΙΕΣ");       //15
    category_list.add("ΠΡΟΣΩΠΙΚΟΣ ΦΑΚΕΛΟΣ ΧΡΗΣΤΗ");     //16
    selected_category = null;
    
  }
  void initSubCategoryList() {
    sub_category = [];
    sub_category.add("ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ΓΝΩΣΤΟΠΟΙΗΣΗ");     //1.1
    sub_category.add("ΒΕΒΑΙΩΣΗ ΕΓΚΑΤΑΣΤΑΣΗΣ");
    sub_category.add("ΠΑΡΑΒΟΛΟ ΑΔΕΙΑΣ ΛΕΙΤΟΥΡΓΙΑΣ/ ΓΝΩΣΤΟΠΟΙΗΣΗΣ");
    sub_category.add("ΒΕΒΑΙΩΣΗ ΜΗ ΟΦΕΙΛΗΣ/ ΔΗΜΟΤΙΚΗ ΕΝΗΜΕΡΟΤΗΤΑ");
    sub_category.add("ΑΔΕΙΑ ΜΟΥΣΙΚΗΣ");                     //2.1
    sub_category.add("ΠΑΡΑΤΑΣΗ ΩΡΑΡΙΟΥ ΜΟΥΣΙΚΗΣ");
    sub_category.add("ΠΝΕΥΜΑΤΙΚΑ ΚΑΙ  ΣΥΓΓΕΝΙΚΑ ΔΙΚΑΙΩΜΑΤΑ");
    sub_category.add("ΕΔΕΜ (ΠΡΩΗΝ ΕΥΕΔ/ ΑΕΠΙ)");            //2.3.1
    sub_category.add("ΑΥΤΟΔΙΑΧΕΙΡΙΣΗ");
    sub_category.add("GEA");
    sub_category.add("GRAMMO");
    sub_category.add("ΑΔΕΙΕΣ ΕΡΓΑΣΙΑΣ ΕΡΓΑΖΟΜΕΝΩΝ");        //4.1
    sub_category.add("ΠΙΣΤΟΠΟΙΗΤΙΚΑ ΥΓΕΙΑΣ ΕΡΓΑΖΟΜΕΝΩΝ");
    sub_category.add("ΠΙΝΑΚΑΣ ΠΡΟΣΩΠΙΚΟΥ");
    sub_category.add("ΠΙΣΤΟΠΟΙΗΤΙΚΟ  Ή/ΚΑΙ ΜΕΛΕΤΗ ΠΥΡΟΠΡΟΣΤΑΣΙΑΣ");                 //5.1
    sub_category.add("ΚΑΤΟΨΗ ΠΥΡΟΣΒΕΣΤΙΚΗΣ");
    sub_category.add("ΤΕΧΝΙΚΗ ΕΚΘΕΣΗ ΚΑΙ ΔΙΑΓΡΑΜΜΑ ΡΟΗΣ");  //6.1
    sub_category.add("ΚΑΤΟΨΕΙΣ ΥΓΕΙΟΝΟΜΙΚΟΥ");
    sub_category.add("ΚΑΤΑΣΤΑΤΙΚΟ ΚΑΙ ΤΡΟΠΟΠΟΙΗΣΕΙΣ");      //7.1              
    sub_category.add("ΑΠΟΦΑΣΕΙΣ ΣΥΝΕΛΕΥΣΗΣ");
    sub_category.add("ΤΑΥΤΟΤΗΤΕΣ ΕΤΑΙΡΩΝ");
    sub_category.add("ΟΙΚΟΔΟΜΙΚΕΣ ΑΔΕΙΕΣ");                 //9.1
    sub_category.add("ΚΑΤΟΨΕΙΣ  ΠΟΛΕΟΔΟΜΙΑΣ");
    sub_category.add("ΤΑΚΤΟΠΟΙΗΣΕΙΣ");
    sub_category.add("ΠΟΙΝΙΚΑ ΔΙΚΑΣΤΗΡΙΑ");                 //14.1
    sub_category.add("ΔΙΟΙΚΗΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ");
    sub_category.add("ΑΣΤΙΚΑ ΔΙΚΑΣΤΗΡΙΑ");
  
    category_list2 = [];
    category_list2.add(sub_category[0]);
    category_list2.add(sub_category[1]);
    category_list2.add(sub_category[2]);
    category_list2.add(sub_category[3]);
    selected_category2 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Καταχώρηση νέου εγγράφου'),
      ),
      body: job_checking == true && doc_category == true || upload_flag == true ? loadingWidget() : _buildContents(),
    );
  }
  Widget loadingWidget() {
    return Container(
      child: new Stack(
        children: [
          _buildContents(),
          new Positioned(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
            top: MediaQuery.of(context).size.height / 2 - 100,
            left: MediaQuery.of(context).size.width / 2,
          )
          
        ],
      ),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child:
                Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
          ),
        )
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      Container(
        // height: 200,
        width: 400,
        color: Color(0xFFfeeeca),
        child: Center(
          child: Column(
            children: [
              file_extention == "pdf" ? 
                GestureDetector(
                  onTap: () => displayBottomSheet(context),
                  child: Container(
                        height: 400,
                        child: PDFViewer(
                          document: doc,
                        )
                    )
                ) : 
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 16.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image_file == null ? AssetImage('assets/images/plus.png') : FileImage(new File(image_file)),
                          fit: BoxFit.contain
                        ),
                      ),
                    )
                  ),
                  onTap: () => displayBottomSheet(context),
                ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(
                'Εισαγωγή νέου εγγράφου',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
      SizedBox(height: 8),
      Text('Βήματα',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/katastima.png'),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: DropdownButton(
                isExpanded: true,
                focusColor: Colors.white,
                dropdownColor: Colors.white,
                value: selected_job_name,
                hint: Text('Επιλογή καταστήματος'),
                onChanged: (newValue) {
                  setState(() {
                    selected_job_name = newValue;
                  });
                },
                items: job_name_list.map((name) {
                  return DropdownMenuItem(
                    child: new Text(name, style: TextStyle(color: Colors.blue)),
                    value: name,
                  );
                }).toList(), 
              )
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/SundesiMeTonAntistoixoFakelo.png'),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: DropdownButton(
                isExpanded: true,
                focusColor: Colors.white,
                dropdownColor: Colors.white,
                hint: Text('Σύνδεση με τον αντίστοιχο φάκελο'),
                value: selected_category,
                onChanged: (newValue) {
                  setState(() {
                    selected_category = newValue;
                    if(selected_category == "ΕΜΠΟΡΙΚΟ ΣΗΜΑ"){
                      category_list2 = [];
                      selected_category2 = null;
                      category_list3 = [];
                      selected_category3 = null;
                      expire_date = null;
                    }
                    getCategory2(newValue);
                  });
                },
                items: category_list.map((name) {
                  return DropdownMenuItem(
                    child: new Text(name, style: TextStyle(color: Colors.blue)),
                    value: name,
                  );
                }).toList(), 
              )
            ),
          ),
        ],
      ),
      selected_category == "ΕΜΠΟΡΙΚΟ ΣΗΜΑ" ? 
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                DateTime newDateTime = await showRoundedDatePicker(
                  context: context,
                  initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                  firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                  onTapDay: (DateTime dateTime, bool available) {
                    if (!available) {
                      showDialog(
                        context: context,
                        builder: (c) => CupertinoAlertDialog(title: Text("This date cannot be selected."),actions: <Widget>[
                          CupertinoDialogAction(child: Text("OK"),onPressed: (){
                            Navigator.pop(context);
                          },)
                        ],)
                      );
                    }
                    return available;
                  },
                  borderRadius: 2,
                  );
                  if (newDateTime != null) {
                    if(mounted){
                      setState(() {
                        expire_date = newDateTime.year.toString() + "-" + newDateTime.month.toString() + "-" + newDateTime.day.toString();
                      });
                    }
                  }
              },
              child: Image.asset(
                'assets/images/imerologio.png',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(expire_date ,style: TextStyle(color: Colors.grey, fontSize: 18,),)),
          ],
        ): 
        category_list2.length > 0 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/SundesiMeTonAntistoixoFakelo.png'),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: DropdownButton(
                    isExpanded: true,
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    hint: Text('Επιλογή φακέλου'),
                    value: selected_category2,
                    onChanged: (newValue) {
                      setState(() {
                        selected_category2 = newValue;
                        getCategory3(newValue);
                        
                      });
                    },
                    items: category_list2.map((name) {
                      return DropdownMenuItem(
                        child: new Text(name, style: TextStyle(color: Colors.blue)),
                        value: name,
                      );
                    }).toList(), 
                  )
                ),
              ),
            ],
          ) : Container(),
      category_list3.length > 0 ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/SundesiMeTonAntistoixoFakelo.png'),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: DropdownButton(
                  isExpanded: true,
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  hint: Text('Επιλογη υποφακέλου'),
                  value: selected_category3,
                  onChanged: (newValue) {
                    setState(() {
                      selected_category3 = newValue;
                    });
                  },
                  items: category_list3.map((name) {
                    return DropdownMenuItem(
                      child: new Text(name, style: TextStyle(color: Colors.blue)),
                      value: name,
                    );
                  }).toList(), 
                )
              ),
            ),
          ],
        ) : Container(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/titlosEggrafou.png'),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: titleController,
              focusNode: myFocusNodeTitle,
              decoration: InputDecoration(labelText: 'Τίτλος εγγράφου'),
              onSaved: (value) => _titlosEggrafou = value,
              validator: (value) => value.isNotEmpty ? null : 'Εισάγετε Τίτλο',
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              DateTime newDateTime = await showRoundedDatePicker(
                context: context,
                initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
                lastDate: DateTime(DateTime.now().year + 1),
                onTapDay: (DateTime dateTime, bool available) {
                  if (!available) {
                    showDialog(
                      context: context,
                      builder: (c) => CupertinoAlertDialog(title: Text("This date cannot be selected."),actions: <Widget>[
                        CupertinoDialogAction(child: Text("OK"),onPressed: (){
                          Navigator.pop(context);
                        },)
                      ],)
                    );
                  }
                  return available;
                },
                borderRadius: 2,
                );
                if (newDateTime != null) {
                  if(mounted){
                    setState(() {
                      document_date = newDateTime.year.toString() + "-" + newDateTime.month.toString() + "-" + newDateTime.day.toString();
                    });
                  }
                }
            },
            child: Image.asset(
              'assets/images/imerologio.png',
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(document_date ,style: TextStyle(color: Colors.grey, fontSize: 18,),)),
        ],
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        onPressed: ()=>{
          onSave()
        },
        child: Text('Αποθήκευση'),
      ),
      SizedBox(height: 8.0),
      // ElevatedButton(
      //   onPressed: ()=>{
      //     // showNotification()
      //     // NotificationService.showNotification()
      //   },
      //   child: Text('Push Notification'),
      // )
    ];
  }
  Future<void> onNotification() async {
    print("----device token:${device_token}");
    var body = jsonEncode({
      "notification": {"title": "dfs", "body": "sdf"},
      "to": "${device_token}",
      // "registration_ids": ["f6kTTMPSSzuvH2hYy5gSPe:APA91bFN9yiZ_k1OsvHu8M3w5c4xfrgzqpNruTrNFO_WTmidnIMBWrVGtJ4Q-FsLTPu4rgXWIZFIS2MEJexKocJQmHdwSUeFuC5xkoAnCqPTQ2RaNmjpkqjX6Y7J7G-cr3gwCcRPpgv_"]  /// broadcast
      "priority": "high",
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"},
    });
    var response = await http.post(
      "https://fcm.googleapis.com/fcm/send",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=AAAA_NAUQa0:APA91bEoV_MBWlZWlYWZ8fYEuYLYZOtWw4LBMvxSe3MG3-sWlQJGR7bq8uqVPiSk-yxT_UNxCiPvcCJlrjM7wvKN-uqqxuxHY6pqpEkeffx3U8zALCBgdHPE8BKzly_J3Bz31OwKhd80"
      },
      body: body,
    );
    print("---response:${response.body}");
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
  Future<void> onUploadUserImage(String imageId, File imageFile){
    
    Reference ref = FirebaseStorage.instance.ref().child(imageId).child(DateTime.now().toString() + "." + file_extention);
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

  Future<void> save() async {
    upload_flag = true;
    if(document_date == "Εισαγωγή στο ημερολόγιο"){
      document_date = null;
    }
    if(expire_date == "Εισαγωγή στο ημερολόγιο"){
      document_date = null;
    }
    if(selected_job_name == null){
      Toast.show("please selecte shop", context);
      return;
    }
    await LoadsModule.saveDocument(selected_job_name, selected_category, selected_category2, selected_category3, upload_imageUrl, expire_date, document_date, titleController.text).then((value){
      if(value == "success"){
        Toast.show("new document had saved successfully", context);
        setState(() {
          selected_job_name = null;
          selected_category = null;
          titleController.text = "";
          document_date = "Εισαγωγή στο ημερολόγιο";
          image_file = null;
          upload_flag = false;
        });
      }
    });
  }

 
  Future<void> getImageFromGallery() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null){
      PlatformFile file = result.files.first;
      file_extention = file.extension;
      image_file = file.path;
      if(file_extention == "pdf"){
        doc = await PDFDocument.fromFile(new File(file.path));
      }
      setState(() {
      });
    }
  }
  Future<void> getImageFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file_extention = pickedFile.path.substring(pickedFile.path.lastIndexOf('.'), pickedFile.path.length);
      image_file = pickedFile.path;
    });
    
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
          height: Platform.isAndroid ? MediaQuery.of(context).size.width  * 0.4 : MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Photo Library'),
                onTap: () {
                  getImageFromGallery();
                  Navigator.of(context).pop();
                }
              ),
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Camera'),
                onTap: () {
                  getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        );
      }
    );
  }

  void getCategory2(String category){
    if(category == category_list[0]){
      category_list2 = [];
      category_list2.add(sub_category[0]);
      category_list2.add(sub_category[1]);
      category_list2.add(sub_category[2]);
      category_list2.add(sub_category[3]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[1]){
      category_list2 = [];
      category_list2.add(sub_category[4]);
      category_list2.add(sub_category[5]);
      category_list2.add(sub_category[6]);
      selected_category2 = null;
      expire_date = null;
    }
    if(category == category_list[3]){
      category_list2 = [];
      category_list2.add(sub_category[11]);
      category_list2.add(sub_category[12]);
      category_list2.add(sub_category[13]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[4]){
      category_list2 = [];
      category_list2.add(sub_category[14]);
      category_list2.add(sub_category[15]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[5]){
      category_list2 = [];
      category_list2.add(sub_category[16]);
      category_list2.add(sub_category[17]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[6]){
      category_list2 = [];
      category_list2.add(sub_category[18]);
      category_list2.add(sub_category[19]);
      category_list2.add(sub_category[20]);
      selected_category2 = category_list2[0];
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[8]){
      category_list2 = [];
      category_list2.add(sub_category[21]);
      category_list2.add(sub_category[22]);
      category_list2.add(sub_category[23]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[13]){
      category_list2 = [];
      category_list2.add(sub_category[24]);
      category_list2.add(sub_category[25]);
      category_list2.add(sub_category[26]);
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
    }
    if(category == category_list[14]){
      category_list2 = [];
      if(doc_category_list.length > 0){
        for(int i = 0; i < doc_category_list.length; i++){
          category_list2.add(doc_category_list[i]);
        }
        selected_category2 = null;
      }
      else{
        selected_category2 = null;
      }
      category_list3 = [];
      selected_category3 = null;
    }
    if(category == category_list[2]){
      category_list2 = [];
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[7]){
      category_list2 = [];
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[9]){
      category_list2 = [];
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[10]){
      category_list2 = [];
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    if(category == category_list[11]){
      category_list2 = [];
      selected_category2 = null;
      category_list3 = [];
      selected_category3 = null;
      expire_date = null;
    }
    
  }
  void getCategory3(String category) {
    if(category == sub_category[6]){
      category_list3 = [];
      category_list3.add(sub_category[7]);
      category_list3.add(sub_category[8]);
      category_list3.add(sub_category[9]);
      category_list3.add(sub_category[10]);
      selected_category3 = null;
    }
    else{
      category_list3 = [];
      selected_category3 = null;
    }
  }

}


class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}
