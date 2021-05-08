import 'package:dexiheri/app/landing_page.dart';
import 'package:dexiheri/services/apple_sign_in_available.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:dexiheri/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {

  bool notification_setting = false;
  BuildContext m_context;

  @override
  Widget build(BuildContext context) {
    if(!notification_setting){
      notification_setting = true;
      m_context = context;
      var initializationSettingsAndroid = AndroidInitializationSettings('flutter_devs');
      var initializationSettingsIOs = IOSInitializationSettings();
      var initSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOs);
      NotificationService.flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);
    }
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Dexiheri',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: LandingPage(),
      ),
    );
  }

  Future onSelectNotification(String payload) {
    Navigator.of(m_context).push(MaterialPageRoute(builder: (_){
      return NewScreen(
        payload: payload
      );
    }));
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
