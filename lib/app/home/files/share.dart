
import 'dart:io';

import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/models/sharedata.dart';
import 'package:dexiheri/app/models/user.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SharePage extends StatefulWidget {
  
  SharePage({
    Key key
  }) : super(key: key);

  SharePageState createState() => SharePageState();
}

class SharePageState extends State<SharePage> {

  bool job_loading = true;
  List<Job> job_list = [];
  List<bool> job_status = [];
  Job selected_job;
  List<Xristis> user_list = [];
  List<bool> user_status = [];
  bool user_loading = true;
  // List<String> category_list = [];
  // List<bool> category_status = [];
  // List<String> current_category = [];
  bool category_loading = true;
  List<ShareData> share_data_list = [];
  List<Job> accessed_job_array = [];

  @override
  void initState() {
    super.initState();
    getJobList();
    // getUserList();
    // getCategoryList();
    
  }
  Future<void> getUserAccessStatus() async {
    user_status = [];
    await LoadsModule.getUserAccessStatus().then((value){
      if(value.length > 0){
        for(int i = 0; i < value.length; i++){
          user_status.add(value[i]);
        }
      }
    });
  }

  Future<void> getUserList() async {
    await LoadsModule.getUsers().then((value) async {
      if(value.length > 0){
        for(int i = 0; i < value.length; i++){
          user_list.add(value[i]);
          ShareData data = ShareData(
            user_id: user_list[i].id
          );
          share_data_list.add(data);
          
        }
        await getUserAccessStatus();
      }
      setState(() {
        user_loading = false;
      });
    });
  }
  Future<void> getJobList() async {
    await LoadsModule.getJobs().then((value) async {
      if(value.length > 0){
        for(int i = 0; i < value.length; i++){
          if(value[i].user_id == DatabaseService.user_uid){
            job_list.add(value[i]);
            job_status.add(false);
          }
        }
        selected_job = null;
        await getUserList();
      }
      setState(() {
        job_loading = false;
      });
    });
    
  }

  // Future<void> getCategoryList() async {
  //   category_loading = true;
  //   category_list = [];
  //   category_status = [];
  //   current_category = [];
  //   await LoadsModule.getUserCategoryInfo().then((value){
  //     setState(() {
  //       if(value.length > 0){
  //         for(int i =0; i < LoadsModule.user_category_status.length; i++){
  //           List<String> data = LoadsModule.user_category_status[i].split(':');
  //           category_list.add(data[0]);
  //           category_status.add(false);
  //         }
  //       }
  //       category_loading = false;
  //     });
      
  //   });
  // }

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
        // job_loading == true ? CircularProgressIndicator() : 
        //   job_list.length > 0 ?
        //     DropdownButton(
        //       focusColor: Colors.white,
        //       dropdownColor: Colors.white,
        //       value: selected_job,
        //       hint: Text('Επιλογή καταστήματος'),
        //       onChanged: (newValue) {
        //         setState(() {
        //           selected_job = newValue;
        //         });
        //       },
        //       items: job_list.map((job) {
        //         return DropdownMenuItem(
        //           child: new Text(job.nameKatastimatos, style: TextStyle(color: Colors.blue),),
        //           value: job,
        //         );
        //       }).toList(), 
        //     ) : Container(),
        ]
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: Platform.isAndroid ? kBottomNavigationBarHeight : 60),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Column(
            children: [
              user_loading == true && job_loading == true ? CircularProgressIndicator()
                : user_list.length > 0 ?
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: user_list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new CheckboxListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: new Text(user_list[index].onoma),
                              ),
                              new IconButton(
                                icon: Icon(
                                  Icons.redo,
                                  color: user_status[index] == true ? Colors.black : Colors.grey,
                                ),
                                onPressed: () {
                                  onShare(index);
                                }
                              ),
                              new IconButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: user_status[index] == true ? Colors.black : Colors.grey,
                                ),
                                onPressed: () {
                                  showCategoryDialog(context, index);
                                }
                              ),
                            ],
                          ),
                          value: user_status[index],
                          // controlAffinity: ListTileControlAffinity.trailing,
                          // dense: true,
                          onChanged: (bool value) {
                            setState(() {
                              user_status[index] = value;
                            });
                          },
                        );
                      }
                    )
                  ) ,
                ): Container(child: Text('no users')),
              // Container(
              //   width: double.infinity,
              //   child: RaisedButton(
              //     onPressed: (){
              //       // onShare();
              //     },
              //     child: Text('SHARE', style: TextStyle(fontSize: 20),),
              //     color: Colors.blue,
              //     textColor: Colors.white,
              //   )
              // ),
            ]
          ),
        ),
      ),
    );
  }

  void showCategoryDialog(BuildContext context, int user_index) {
    if(user_status[user_index] == false){
      Toast.show("select user", context);
    }
    else{
      // category_status = [];
      // for(int i =0; i < category_list.length; i++){
      //   category_status.add(false);
      // }
      showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(builder: (context, setState){
            return AlertDialog(
              title: Text('job select'),
              content: Container(
                width: 300,
                height: 300,
                child: ListView.builder(
                  itemCount: job_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new CheckboxListTile(
                      title: new Text(job_list[index].nameKatastimatos),
                      value: job_status[index],
                      onChanged: (bool value) {
                        setState(() {
                          job_status[index] = value;
                        });
                      },
                    );
                  }
                )
              ),
              actions: [
                new FlatButton(
                  onPressed: (){
                    if(!job_status.contains(true)){
                      Toast.show("select at least 1 job", context);
                    }
                    else{
                      Navigator.pop(context);
                      setShareData(user_index);
                    }
                  },
                  child: new Text('save'),
                )
              ],
            );
        });
      });
    }
     
  }

  void setShareData(int user_index){
    accessed_job_array = [];
    for(int i = 0; i < job_list.length; i++){
      if(job_status[i] == true){
        accessed_job_array.add(job_list[i]);
      }
    }
    // share_data_list[user_index].category_list = category_array;
  }

  Future<void> onShare(int index) async {
    List<String> category_array = [];
    if(user_status[index] == false){
      Toast.show("select user", context);
      return;
    }
    if(accessed_job_array.length < 1){
      Toast.show("select job", context);
      return;
    }
    if(!job_status.contains(true)){
      Toast.show("select at least 1 job", context);
      return;
    }
    
    await LoadsModule.onShare(DatabaseService.user_uid, accessed_job_array, user_list[index]).then((value){
      if(value == "access success"){
        Toast.show("access success", context);
      }
    });
  }
  
}