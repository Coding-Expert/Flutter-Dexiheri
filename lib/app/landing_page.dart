import 'package:dexiheri/app/home/home_page.dart';
import 'package:dexiheri/app/home/jobs/jobs_page.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:dexiheri/services/database.dart';
import 'package:dexiheri/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage();
            }
            if(user != null){
              print("----userId:${user.uid}");
              DatabaseService.user_uid = user.uid;
              DatabaseService.initFirebase();
              checkCategoryTable();
            }
            return Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                child: HomePage());
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future<void> checkCategoryTable() async {
    final snapshot = await DatabaseService.userCategoryCollection.get();
    if(snapshot == null || !snapshot.exists){
      await LoadsModule.createStatus();
    }
  }
}
