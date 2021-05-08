
import 'dart:io';

import 'package:dexiheri/app/home/files/detail_category.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DetailSearchPage extends StatefulWidget {

  int category_number;
  String category_title;
  List<Document> document_list;
  Job job;

  DetailSearchPage({
    Key key,
    this.category_number,
    this.category_title,
    this.document_list,
    this.job
  }) : super(key: key);

  DetailSearchPageState createState() => DetailSearchPageState();
}

class DetailSearchPageState extends State<DetailSearchPage> {

  List<Job> job_list = [];
  Job selected_job;
  bool job_loading = true;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController categoryController = TextEditingController();
  final FocusNode categoryFocusNode = FocusNode();
  String get category => searchController.text;
  List<String> doc_category_list = [];
  String selected_category = "";
  bool category_loading = true;
  String get search => searchController.text;
  List<String> current_list = [];

  @override
  void initState() {
    super.initState();
    getJobList();
  }

  Future<void> getJobList() async {
    await LoadsModule.getJobs().then((value){
      setState(() {
        if(value.length > 0){
          for(int i = 0; i < value.length; i++){
            job_list.add(value[i]);
          }
          selected_job = job_list[0];
        }
        job_loading = false;
        LoadsModule.getDocumentCategory().then((value){
          setState(() {
            if(value.length > 0){
              for(int i = 0; i < value.length; i++){
                doc_category_list.add(value[i]);
                current_list.add(value[i]);
              }
              selected_category = null;
            }
            category_loading = false;
          });
        });
      });
    });
    
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
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
          // job_loading == true ? CircularProgressIndicator() : 
          //   DropdownButton(
          //     focusColor: Colors.white,
          //     dropdownColor: Colors.white,
          //     value: selected_job,
          //     onChanged: (newValue) {
          //       setState(() {
          //         selected_job = newValue;
          //       });
          //     },
          //     items: job_list.map((job) {
          //       return DropdownMenuItem(
          //         child: new Text(job.nameKatastimatos, style: TextStyle(color: Colors.blue),),
          //         value: job,
          //       );
          //     }).toList(), 
          //   )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(widget.category_number.toString() + ". "+ widget.category_title, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
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
                      hintText: "Αναζήτηση",
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
            category_loading == true ? CircularProgressIndicator() :
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          for(var element in current_list)
                            DetailCategoryWidget(
                              index: current_list.indexOf(element) + 1,
                              category: widget.category_title,
                              category2: element,
                              job: widget.job
                            ),
                          // GestureDetector(
                          //   onTap: (){
                          //     // showCategoryDialog();
                          //     showCustomDialog(context);
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Text('Προσθήκη κατηγορίας', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          //       new IconButton(
                          //         icon: Icon(
                          //           Icons.add,
                          //           color: Colors.blue,
                          //         ),
                          //         onPressed: () {
                          //         }
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ]
                      )
                      
                    )
                  ),
                )
              )
          ],
        ),
      ),
    );
  }
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Όνομα Κατηγορίας'),
        content: TextFormField(
              controller: categoryController,
              focusNode: categoryFocusNode,
              keyboardType: TextInputType.text,
            ),
        actions: [
          new FlatButton(
            onPressed: (){
              if(invalidate()){
                Navigator.pop(context);
                saveDocumentCategory();
              }
              
            },
            child: new Text('Προσθήκη'),
          )
        ],
      )
    );
  }

  bool invalidate() {
    if(categoryController.text.isEmpty){
      Toast.show('please input name', context);
      return false;
    }
    if(doc_category_list.length > 0){
      int count = 0;
      for(int i = 0; i < doc_category_list.length; i++){
        if(doc_category_list[i] == categoryController.text){
          count ++;
          break;
        }
      }
      if(count > 0){
        Toast.show('namve is already exist', context);
        return false;
      }
      else{
        return true;
      }
      
    }
    else{
      return true;
    }
  }
  void saveDocumentCategory() {
    LoadsModule.saveDocumentCategory(categoryController.text).then((value){
      if(value == "success"){
        if(!category_loading){
          setState(() {
            category_loading = true;
          });
        }
        LoadsModule.getDocumentCategory().then((value){
          setState(() {
            if(value.length > 0){
              doc_category_list = [];
              for(int i = 0; i < value.length; i++){
                doc_category_list.add(value[i]);
                current_list.add(value[i]);
              }
              selected_category = null;
            }
            category_loading = false;
          });
        });
      }
      
    });
  }
  void _updateState() {
    print('search: $search');
    if(!category_loading){
      setState(() {
        category_loading = true;
      });
    }
    if(search != null && search.isNotEmpty){
      if(doc_category_list.length > 0){
        current_list = [];
        for(int i = 0; i < doc_category_list.length; i++) {
          if(doc_category_list[i].contains(search.toUpperCase()) || doc_category_list[i].contains(search.toLowerCase())){
            current_list.add(doc_category_list[i]);
          }
        }
      }
      setState(() {
        category_loading = false;
      });
    } 
    else {
      current_list = [];
      if(doc_category_list.length > 0) {
        for(int i = 0; i < doc_category_list.length; i++){
          current_list.add(doc_category_list[i]);
        }
      }
      setState(() {
        category_loading = false;
      });
    }
  }
  
}