
import 'dart:io';

import 'package:dexiheri/app/home/files/music/music_detail.dart';
// import 'package:dexiheri/app/home/files/music/new_music.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/models/music_document.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:flutter/material.dart';

class MusicResultPage extends StatefulWidget{

  String category;
  String category2;
  String category3;
  Job job;

  MusicResultPage({
    Key key,
    this.category,
    this.category2,
    this.category3,
    this.job
  }) : super(key: key);

  MusicResultPageState createState ()=> MusicResultPageState();
}

class MusicResultPageState extends State<MusicResultPage> {


  bool job_loading = true;
  List<Job> job_list = [];
  Job selected_job;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  String get search => searchController.text;
  bool music_loading = false;
  List<Document> docList = [];
  List<Document> current_list = [];
  List<String> year_list = [];
  String selected_year = "";

  @override
  void initState() {
    super.initState();
    initYearList();
    getJobList();
    
  }

  void initYearList(){
    year_list.add('2021');
    year_list.add('2022');
    year_list.add('2023');
    year_list.add('2024');
    year_list.add('2025');
    year_list.add('2026');
    year_list.add('2027');
    year_list.add('2028');
    selected_year = year_list[0];
  }

  Future<void> getMusicDocumentList() async {
    docList = [];
    current_list = [];
    if(!music_loading){
      setState(() {
        music_loading = true;
      });
    }
    await LoadsModule.getDocumentList(widget.category, widget.category2, widget.category3, widget.job).then((value) {
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            docList.add(value[i]);
            current_list.add(value[i]);
          }
        }
        music_loading = false;
      });
    });
  }

  Future<void> getJobList() async {
    await LoadsModule.getJobs().then((value){
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            job_list.add(value[i]);
          }
          selected_job = null;
        }
        job_loading = false;
        getMusicDocumentList();
      });
    });
    
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
        actions: [
          // new IconButton(
          //   icon: Icon(
          //     Icons.add,
          //     color: Colors.blue,
          //   ),
          //   onPressed: () {
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewMusicPage(
          //       subcategory1: widget.subcategory1,
          //       subcategory2: widget.subcategory2,
          //       shop: selected_job.nameKatastimatos
          //     )));
          //   }
          // ),
          // job_loading == true ? CircularProgressIndicator() : 
          //   job_list.length > 0 ?
          //     DropdownButton(
          //       focusColor: Colors.white,
          //       dropdownColor: Colors.white,
          //       value: selected_job,
          //       hint: Text('?????????????? ????????????????????????'),
          //       onChanged: (newValue) {
          //         setState(() {
          //           selected_job = newValue;
          //           getMusicDocumentListByJob();
          //         });
          //       },
          //       items: job_list.map((job) {
          //         return DropdownMenuItem(
          //           child: new Text(job.nameKatastimatos, style: TextStyle(color: Colors.blue),),
          //           value: job,
          //         );
          //       }).toList(), 
          //     ) : Container(),
          
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("2. ???????????? ????????????????", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            // widget.subcategory1 != "?????????? ????????????????" ?
            DropdownButton(
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              value: selected_year,
              onChanged: (newValue) {
                setState(() {
                  selected_year = newValue;
                  getMusicDocumentListByDate();
                });
              },
              items: year_list.map((year) {
                return DropdownMenuItem(
                  child: new Text(year, style: TextStyle(color: Colors.blue),),
                  value: year,
                );
              }).toList(), 
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              margin: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 8,
                child: Container(
                  child: TextFormField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    cursorColor: Colors.orange[200],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon:
                      Icon(Icons.search, color: Colors.orange[200], size: 30),
                      hintText: "??????????????????",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (email) => _updateState(),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
              music_loading == true ? CircularProgressIndicator() :
                docList.length > 0 ?
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
                      child: ListView.builder(
                        itemCount: current_list.length,
                        itemBuilder: (context, index){
                          return Dismissible(
                            background: stackBehindDismiss(),
                            key: ObjectKey(current_list[index]),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicDetailPage(
                                  document: current_list[index],
                                )));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(current_list[index].title, style: TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            fontSize: 22.0,
                                            color: Colors.black,)
                                          )
                                        ),
                                        Icon(Icons.arrow_right)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              )
                            ),
                            onDismissed: (direction){
                              Document item = current_list.elementAt(index);
                              deleteItem(item, index);
                            },
                          );
                        }
                      ),
                    ),
                  ) : 
                  Container(
                    child: Text('?????? ???????????????? ????????????'),
                  ),
          ],
        ),
      ),
    );
  }

  void _updateState() {
    print('search: $search');
    if(!music_loading){
      setState(() {
        music_loading = true;
      });
    }
    if(search != null && search.isNotEmpty){
      if(docList.length > 0){
        current_list = [];
        for(int i = 0; i < docList.length; i++) {
          if(docList[i].title.contains(search.toUpperCase()) || docList[i].title.contains(search.toLowerCase())){
            current_list.add(docList[i]);
          }
        }
      }
      setState(() {
        music_loading = false;
      });
    } 
    else {
      current_list = [];
      if(docList.length > 0) {
        for(int i = 0; i < docList.length; i++){
          current_list.add(docList[i]);
        }
      }
      setState(() {
        music_loading = false;
      });
    }
  }
  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
  void deleteItem(Document item, int index) {
    current_list.removeAt(index);
    setState(() {
      LoadsModule.deleteMusicDocument(item.id).then((value){
        if(value == "success"){
          getMusicDocumentList();
        }
      });
    });
  }
  void getMusicDocumentListByJob(){
    if(!music_loading){
      setState(() {
        music_loading = true;
      });
    }
    if(docList.length > 0){
      current_list = [];
      for(int i = 0; i < docList.length; i++) {
        if(docList[i].shop.contains(selected_job.nameKatastimatos.toUpperCase()) || docList[i].shop.contains(selected_job.nameKatastimatos.toLowerCase())){
          current_list.add(docList[i]);
        }
      }
        setState(() {
        music_loading = false;
      });
    }
    else{
      setState(() {
        music_loading = false;
      });
    }
    
  }
  void getMusicDocumentListByDate() {
    if(!music_loading){
      setState(() {
        music_loading = true;
      });
    }
    if(docList.length > 0){
      current_list = [];
      for(int i = 0; i < docList.length; i++) {
        if(docList[i].date.contains(selected_year.toUpperCase()) || docList[i].date.contains(selected_year.toLowerCase())){
          current_list.add(docList[i]);
        }
      }
        setState(() {
        music_loading = false;
      });
    }
    else{
      setState(() {
        music_loading = false;
      });
    }
  }
  
}