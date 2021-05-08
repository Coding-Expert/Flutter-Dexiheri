import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/event.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/models/music_document.dart';
import 'package:dexiheri/app/models/sharedata.dart';
import 'package:dexiheri/app/models/user.dart';
import 'package:dexiheri/services/database_service.dart';

class LoadsModule {
  static List<Job> job_list;
  static List<Xristis> xristis_list;
  static List<String> job_name_list;
  static List<String> service_list = [];
  static List<String> eggrafa_list = [];
  static List<Event> event_list;
  static List<String> doc_category_list = [];
  static List<Document> document_list = [];
  static List<MusicDocument> music_doc_list = [];
  static List<String> category_list = [];
  static List<String> user_category_list = [];
  static List<String> user_category_status = [];
  static List<Xristis> user_list = [];
  static List<bool> access_status = [];

  static Future<List<Job>> getJobs() async {
    job_list = [];
    await DatabaseService.firestoreJobsCollection.get().then((QuerySnapshot snapshot){
      snapshot.docs.asMap().forEach((index, data) { 
        Job job = Job(
          user_id: DatabaseService.user_uid,
          id: snapshot.docs[index].reference.id, 
          nameKatastimatos: snapshot.docs[index]["nameKatastimatos"], 
          afm: snapshot.docs[index]["afm"], 
          dieuthinsiKatastimatos: snapshot.docs[index]["dieuthinsiKatastimatos"], 
          tilephono: snapshot.docs[index]["tilephono"]
        );
        
        job_list.add(job);
      });
    });
    await DatabaseService.shareCollection.doc(DatabaseService.user_uid).collection("access").get().then((QuerySnapshot value){
      if(value != null && value.size > 0){
        value.docs.asMap().forEach((index, data) { 
          List<dynamic> map_data = value.docs[index]["status"];
          for(int i = 0; i < map_data.length; i++){
            Job job = Job(
              user_id: map_data[i]["user_id"],
              nameKatastimatos: map_data[i]["nameKatastimatos"], 
              afm: map_data[i]["afm"], 
              dieuthinsiKatastimatos: map_data[i]["dieuthinsiKatastimatos"], 
              tilephono: map_data[i]["tilephono"]
            );
          
            job_list.add(job);
          }
          
        });
      }
    });
    return job_list;
  }

  static Future<List<Xristis>> getXristis() async {
    xristis_list = [];
    await DatabaseService.firestoreUserCollection.get().then((QuerySnapshot snapshot){

      snapshot.docs.asMap().forEach((index, data) {
        Xristis xristis = Xristis(
            id: snapshot.docs[index].reference.id,
            eponymo: snapshot.docs[index]["eponymo"],
            onoma: snapshot.docs[index]["onoma"],
            dieuthinsi: snapshot.docs[index]["dieuthinsi"],
            tilephono: snapshot.docs[index]["tilephono"],
          fylo: snapshot.docs[index]["fylo"]
        );

        xristis_list.add(xristis);
      });
    });
    return xristis_list;
  }

  static Future<List<Event>> getEvents() async {
    event_list = [];
    await DatabaseService.firestoreEventSaveCollection.get().then((QuerySnapshot snapshot){
      snapshot.docs.asMap().forEach((index, data) { 
        Event event = Event(
          id: snapshot.docs[index]["shop_id"],
          date: snapshot.docs[index]["date"], 
          title: snapshot.docs[index]["title"], 
          description: snapshot.docs[index]["description"], 
          service: snapshot.docs[index]["service"],
          courts_date : snapshot.docs[index]["courts_date"],
          license_date : snapshot.docs[index]["license_date"],
          category: snapshot.docs[index]["category"],
          image: snapshot.docs[index]["image"]
        );
        print("----image path:${snapshot.docs[0].data().toString()}");
        event_list.add(event);
      });
    });
    // print("---event count:${event_list.length}");
    return event_list;
  }

  static Future<List<String>> getService() async {
     await DatabaseService.firestoreServiceCollection.get().then((QuerySnapshot value){
      List<dynamic> list = value.docs[0]["ypiresiesList"];
      service_list.clear();
      if(list.length > 0){
        for(int i = 0; i < list.length; i++){
          service_list.add(list[i]);
        }
        
      }
    //  print("---doc length:${value.docs.length}");
    });
    
    return service_list;
  }

  static Future<List<String>> getAllCategory() async {
    await DatabaseService.categoryCollection.get().then((QuerySnapshot value){
      List<dynamic> list = value.docs[0]["katigories"];
      category_list.clear();
      if(list.length > 0){
        for(int i = 0; i < list.length; i++){
          category_list.add(list[i]);
        }
        
      }
    });
    return category_list;
  }

  static Future<String> saveEvent(Event event) async {
    String response = "";
    await DatabaseService.firestoreEventSaveCollection.doc(event.id + "-" + DateTime.now().toIso8601String()).set(
      {
        "shop_id" : event.id,
        "date" : event.date,
        "title" : event.title,
        "description" : event.description,
        "service" : event.service,
        "courts_date" : event.courts_date,
        "license_date" : event.license_date,
        "category" : event.category, 
        "image" : event.image
      }
    ).then((value){
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<List<String>> getDocumentCategory() async {
    await DatabaseService.firestoreServiceCollection.get().then((QuerySnapshot value){
      List<dynamic> list = value.docs[0]["ypiresiesList"];
      doc_category_list.clear();
      if(list.length > 0){
        for(int i = 0; i < list.length; i++){
          doc_category_list.add(list[i]);
        }
        
      }
    //  print("---doc_category length:${value.docs.length}");
      
    });
    return doc_category_list;
  }
  static Future<String> saveDocumentCategory(String name) async {
    String response = "";
    await DatabaseService.firestoreServiceCollection.doc("WSENWGOYpQIyU6DJ53No").update({'ypiresiesList' :FieldValue.arrayUnion([name])}).then((value){
      print("----document saved----");
      response = "success";
    });
    return response;
  }

  static Future<String> saveDocument(String shop_id, String category, String category2, String category3, String image_url, String expire_date, String date, String title) async {
    String response = "";
    await DatabaseService.documentCollection.doc(shop_id + "-" + DateTime.now().toIso8601String()).set(
      {
        "category" : category,
        "category2" : category2,
        "category3" : category3,
        "url" : image_url,
        "shop" : shop_id,
        "date" : date,
        "expire_date" : expire_date,
        "title" : title
      }
    ).then((value){
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<List<Document>> getDocumentList(String category, String category2, String category3, Job job) async {
    document_list = [];
    // await DatabaseService.documentCollection.get().then((QuerySnapshot snapshot){
    
    await DatabaseService.firestore.collection("eggrafa").doc(job.user_id).collection("katastima").get().then((QuerySnapshot snapshot){
      
      snapshot.docs.asMap().forEach((index, data) {
        Document doc = Document(
          title: snapshot.docs[index]["title"], 
          shop: snapshot.docs[index]["shop"], 
          category: snapshot.docs[index]["category"], 
          date: snapshot.docs[index]["date"], 
          image: snapshot.docs[index]["url"],
          id: snapshot.docs[index].reference.id,
          category2: snapshot.docs[index]["category2"],
          category3: snapshot.docs[index]["category3"],
          expire_date: snapshot.docs[index]["expire_date"]
        );
        if(category2 != null && category3 != null){
          if(category == snapshot.docs[index]["category"] && category2 == snapshot.docs[index]["category2"] && job.nameKatastimatos == snapshot.docs[index]["shop"] && category3 == snapshot.docs[index]["category3"]){
            document_list.add(doc);
          }
        }
        if(category2 == null) {
          if(category == snapshot.docs[index]["category"] && job.nameKatastimatos == snapshot.docs[index]["shop"]){
            document_list.add(doc);
          }
        }
        else if(category3 == null){
          if(category == snapshot.docs[index]["category"] && category2 == snapshot.docs[index]["category2"] && job.nameKatastimatos == snapshot.docs[index]["shop"]){
            document_list.add(doc);
          }
        }
        
      });
    });
    
    return document_list;
  }
  static Future<String> deleteDocument(String document_id) async {
    String response = "";
    await DatabaseService.documentCollection.doc(document_id).delete().then((value){
      response = "success";
    });
    return response;
  }

  static Future<String> saveMusicDocument(String shop_id, String title,String year, String subcategory1,String subcategory2, String image_url) async {
    String response = "";
    await DatabaseService.musicDocumentCollection.doc(shop_id + "-" + DateTime.now().toIso8601String()).set(
      {
        "shop": shop_id,
        "title" : title,
        "date" : year,
        "subcategory1" : subcategory1,
        "subcategory2" : subcategory2,
        "url" : image_url,
        
      }
    ).then((value){
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<List<MusicDocument>> getMusicDocument(String shop_id, String subcategory1, String subcategory2) async {
    music_doc_list = [];
    await DatabaseService.musicDocumentCollection.get().then((QuerySnapshot snapshot){
      snapshot.docs.asMap().forEach((index, data) {
        if(snapshot.docs[index]["subcategory1"] == subcategory1 && snapshot.docs[index]["subcategory2"] == subcategory2){
          MusicDocument music_doc = MusicDocument(
            title: snapshot.docs[index]["title"], 
            shop: snapshot.docs[index]["shop"], 
            date: snapshot.docs[index]["date"],
            subcategory1: snapshot.docs[index]["subcategory1"], 
            subcategory2: snapshot.docs[index]["subcategory2"], 
            image: snapshot.docs[index]["url"],
            id: snapshot.docs[index].reference.id
          );
          music_doc_list.add(music_doc);
        }
      });
    });
    return music_doc_list;
  }

  static Future<String> deleteMusicDocument(String document_id) async {
    String response = "";
    await DatabaseService.musicDocumentCollection.doc(document_id).delete().then((value){
      response = "success";
    });
    return response;
  }

  static Future<List<String>> getUserCategoryInfo() async {
    user_category_status = [];
    var doc = await DatabaseService.userCategoryCollection.get();
    if(!doc.exists){
      await createStatus().then((value) async {
        await DatabaseService.userCategoryCollection.get().then<dynamic>((DocumentSnapshot value){
          List<dynamic> status_list = value["status"];
          if(status_list.length > 0){
            for(int i = 0; i < status_list.length; i++){
              user_category_status.add(status_list[i]);
            }
            
          }
        
        });
      });
    }
    else{
      if(!doc.data().containsKey("status")){
        await createStatus().then((value) async {
          await DatabaseService.userCategoryCollection.get().then<dynamic>((DocumentSnapshot value){
            List<dynamic> status_list = value["status"];
            if(status_list.length > 0){
              for(int i = 0; i < status_list.length; i++){
                user_category_status.add(status_list[i]);
              }
              
            }
          
          });
        });
      }
      else{
        await DatabaseService.userCategoryCollection.get().then<dynamic>((DocumentSnapshot value){
          List<dynamic> status_list = value["status"];
          if(status_list.length > 0){
            for(int i = 0; i < status_list.length; i++){
              user_category_status.add(status_list[i]);
            }
            
          }
        
        });
      }
      
    }
    
    return user_category_status;
  }

  static Future<String> saveStatus(List<String> status_array) async {
    String response = "";
    var doc = await DatabaseService.userCategoryCollection.get();
    if(doc.exists){
      if(doc.data().containsKey("status")){
        
        await DatabaseService.userCategoryCollection.update({'status' :FieldValue.delete()}).then((value){
        });
        await DatabaseService.userCategoryCollection.update({'status' :FieldValue.arrayUnion(status_array)}).then((value){
        });
      }
      else{
        await DatabaseService.userCategoryCollection.update({'status' :FieldValue.arrayUnion(status_array)}).then((value){
        });
      }
    }
    else{
      await DatabaseService.userCategoryCollection.update({'status' :FieldValue.arrayUnion(status_array)}).then((value){
      });
    }
    // await DatabaseService.userCategoryCollection.update({'status' :FieldValue.arrayRemove(status_array)});
    // await DatabaseService.userCategoryCollection.set({'status' :FieldValue.arrayUnion(status_array)}).then((value){
      
    // });
    response = "success";
    print("----status saved----");
    return response;
  }
  static Future<bool> createStatus() async {
    List<String> status_data = [];
    await DatabaseService.categoryCollection.get().then((QuerySnapshot value) async {
      List<dynamic> list = value.docs[0]["katigories"];
      status_data.clear();
      if(list.length > 0){
        for(int i = 0; i < list.length; i++){
          status_data.add(list[i] + ":true");
        }
        await DatabaseService.userCategoryCollection.set({'status' :FieldValue.arrayUnion(status_data)}).then((value){
          print("----status saved----");
        });
      }
    });
    return true;
  }

  static Future<List<Xristis>> getUsers() async {
    user_list = [];
    access_status = [];
    await DatabaseService.firestoreUserCollection.get().then((QuerySnapshot snapshot){
      snapshot.docs.asMap().forEach((index, data) {
        // if(snapshot.docs[index].reference.id != DatabaseService.user_uid){
          Xristis xristis = Xristis(
            id: snapshot.docs[index].reference.id,
            eponymo: snapshot.docs[index]["eponymo"],
            onoma: snapshot.docs[index]["onoma"],
            dieuthinsi: snapshot.docs[index]["dieuthinsi"],
            tilephono: snapshot.docs[index]["tilephono"],
            fylo: snapshot.docs[index]["fylo"]
          );
          user_list.add(xristis);
          access_status.add(false);
        // }
      });
    });
    return user_list;
  }

  static Future<String> onShare(String user_id, List<Job> job_list, Xristis user) async {
    String response = "";
    for(int i = 0; i < job_list.length; i++){
      var doc = await DatabaseService.shareCollection.doc(user.id).collection("access").doc(user_id).get();
      if(doc.exists){
        await DatabaseService.shareCollection.doc(user.id).collection("access").doc(user_id).update(
          {'status' :FieldValue.arrayUnion([job_list[i].toJson()])}
        );
      }
      else{
        await DatabaseService.shareCollection.doc(user.id).collection("access").doc(user_id).set(
          {'status' :FieldValue.arrayUnion([job_list[i].toJson()])}
        );
      }
      
    }
    var access_doc = await DatabaseService.userCategoryCollection.get();
    if(access_doc.exists){
      if(access_doc.data().containsKey("access")){
        List<String> temp = [];
        temp.add("sfsdf");
        await DatabaseService.userCategoryCollection.update({'access' :FieldValue.delete()}).then((value){
        });
        await DatabaseService.userCategoryCollection.update({'access' :FieldValue.arrayUnion([user.id])}).then((value){
        });
      }
      else{
        await DatabaseService.userCategoryCollection.update({'access' :FieldValue.arrayUnion([user.id])}).then((value){
        });
      }
    }
    else{
      await DatabaseService.userCategoryCollection.update({'access' :FieldValue.arrayUnion([user.id])}).then((value){
      });
    }
    
    // await DatabaseService.userCategoryCollection.update({'access' :FieldValue.arrayRemove([user_id])}).then((value){
    // });
    print("-----access success----");
    response = "access success";
    return response;
  }

  static Future<List<bool>> getUserAccessStatus() async {
    List<dynamic> list = [];
    var doc = await DatabaseService.userCategoryCollection.get();
    if(doc.exists){
      if(doc.data().containsKey("access")){
        await DatabaseService.userCategoryCollection.get().then<dynamic>((DocumentSnapshot value){
          if(value["access"].length > 0){
            for(int i = 0; i < value["access"].length; i++){
              list.add(value["access"][i]);
            }
          }
        
        });
      }
    }
    if(list.length > 0){
      for(int i = 0; i < user_list.length; i++){
        for(int j = 0; j < list.length; j++){
          if(user_list[i].id == list[j]){
            access_status[i] = true;
            break;
          }
        }
      }
    }
    return access_status;
    
  }

}