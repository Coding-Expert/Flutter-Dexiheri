import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static String user_uid;
  static FirebaseFirestore firestore;
  static CollectionReference firestoreJobsCollection;
  static CollectionReference firestoreServiceCollection;
  static CollectionReference firestoreEventSaveCollection;
  static CollectionReference documentCategoryCollection;
  static CollectionReference documentSaveCollection;
  static CollectionReference documentCollection;
  static CollectionReference musicDocumentCollection;
  static CollectionReference categoryCollection;
  static CollectionReference firestoreUserCollection;
  static DocumentReference userCategoryCollection;
  static CollectionReference shareCollection;


  static void initFirebase(){
    firestore = FirebaseFirestore.instance;
    firestore.settings = Settings(persistenceEnabled: false);
    firestore.settings = Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    firestoreJobsCollection = firestore.collection("jobs").doc(user_uid).collection("jobs");
    firestoreServiceCollection = firestore.collection("ypiresies");
    firestoreEventSaveCollection = firestore.collection("events").doc(user_uid).collection("eventsMagazion");
    documentCategoryCollection = firestore.collection("ypiresies");
    documentCollection = firestore.collection("eggrafa").doc(user_uid).collection("katastima");
    musicDocumentCollection = firestore.collection("eggrafaMousikis").doc(user_uid).collection("katastima");
    categoryCollection = firestore.collection("eggrafaKatigories");
    firestoreUserCollection = firestore.collection("users");
    userCategoryCollection = firestore.collection("usercategory").doc(user_uid);
    shareCollection = firestore.collection("categoryshare");

    Stream<QuerySnapshot> firestoreJobStream = firestoreJobsCollection.snapshots();
    firestoreJobStream.listen((event) {
      print("----new job----");
    });

  }

}
