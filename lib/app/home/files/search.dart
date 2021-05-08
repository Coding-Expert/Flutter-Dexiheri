
import 'dart:io';

import 'package:dexiheri/app/home/files/category_widget.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  
  SearchPage({ Key key}) : super(key: key);
  SearchPageState createState ()=> SearchPageState();

}

class SearchPageState extends State<SearchPage> {

  List<Job> job_list = [];
  Job selected_job;
  bool job_loading = true;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  String get search => searchController.text;
  List<String> category_list = [];
  List<bool> category_status = [];
  List<String> current_category = [];
  List<bool> update_status = [];
  bool category_loading = false;
  List<String> temp_list = [];
  bool _value = true;

  @override
  void initState() {
    super.initState();
    initCategoryList();
    getJobList();
  }

  void initCategoryList() {
    category_loading = true;
    category_list = [];
    category_status = [];
    current_category = [];
    LoadsModule.getUserCategoryInfo().then((value){
      
      setState(() {
        if(value.length > 0){
          for(int i =0; i < LoadsModule.user_category_status.length; i++){
            List<String> data = LoadsModule.user_category_status[i].split(':');
            category_list.add(data[0]);
            if(data[1] == "true"){
              category_status.add(true);
              current_category.add(data[0]);
            }
            else{
              category_status.add(false);
            }
            
          }
        }
        category_loading = false;
      });
      
    });
  }

  void getUserCategoryList() {

  }

  // Future<void> getAllCategoryList() async {
  //   if(!category_loading){
  //     category_loading = true;
  //   }
  //   await LoadsModule.getAllCategory().then((value){
  //     if(value.length > 0){
  //       for(int i = 0; i < value.length; i++){
  //         category_list.add(value[i]);
  //       }
  //     }
  //     setState(() {
  //       category_loading = false;
  //     });
  //   });
  // }

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
          new IconButton(
            icon: Icon(
              Icons.update,
              color: Colors.blue,
            ),
            onPressed: () {
              update_status = [];
              for(int i =0; i < category_list.length; i++){
                update_status.add(category_status[i]);
              }
              showCustomDialog(context);
            }
          ),
          job_loading == true ? CircularProgressIndicator() : 
            DropdownButton(
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              value: selected_job,
              onChanged: (newValue) {
                setState(() {
                  selected_job = newValue;
                });
              },
              items: job_list.map((job) {
                return DropdownMenuItem(
                  child: new Text(job.nameKatastimatos, style: TextStyle(color: Colors.blue),),
                  value: job,
                );
              }).toList(), 
            )
        ],
      ),
      body: Center(
        child: Column(
          children: [
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
            category_loading == true ? CircularProgressIndicator() :
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 80),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          for(var category in current_category)
                            CategoryWidget(
                              index: current_category.indexOf(category),
                              title: category,
                              job: selected_job,
                              document_list: LoadsModule.document_list,
                            ),
                            
                        ]
                      )
                      
                    )
                  ),
                )
              )
          ]
        ),
      )
    );
  }

  void _updateState() {
    
    category_loading = true;
    setState(() {
      if(search != null && search.isNotEmpty){
        
        if(category_list.length > 0){
          temp_list = [];
          for(int i = 0; i < category_list.length; i++) {
            if(category_list[i].contains(search.toUpperCase()) || category_list[i].contains(search.toLowerCase())){
              temp_list.add(category_list[i]);
              print('search: $search');
            }
          }
          category_list = temp_list;
        }
      }
      else{
        initCategoryList();
      }
      category_loading = false;
    });
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            title: Text('category status'),
            content: Container(
              width: 300,
              height: 300,
              child: ListView.builder(
                itemCount: category_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return new CheckboxListTile(
                    title: new Text(category_list[index]),
                    value: update_status[index],
                    onChanged: (bool value) {
                      setState(() {
                        update_status[index] = value;
                      });
                    },
                  );
                }
              )
            ),
            actions: [
              new FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  saveCategoryStatus();
                },
                child: new Text('save'),
              )
            ],
          );
      });
    });
  }

  void saveCategoryStatus() {
    List<String> data_list = [];
    for(int i = 0; i < category_list.length; i++){
      String save_data = category_list[i];
      if(update_status[i]){
        save_data = save_data + ":" + "true";
      }
      else{
        save_data = save_data + ":" + "false";
      }
      data_list.add(save_data);
    }
    LoadsModule.saveStatus(data_list).then((value){
      if(value == "success"){
        setState(() {
          initCategoryList();
        });
        
      }
    });
  }

}