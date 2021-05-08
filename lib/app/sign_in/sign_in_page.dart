import 'dart:io';

import 'package:dexiheri/Animation/FadeAnimation.dart';
import 'package:dexiheri/app/sign_in/sign_in_button.dart';
import 'package:dexiheri/app/sign_in/social_sign_in_button.dart';
import 'package:dexiheri/services/apple_sign_in_available.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.singInAnonymously();
      print('${user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.singInWithGoogle();
      print('${user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.signInWithFacebook();
      print('${user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await auth.signInWithApple(
        scopes: [Scope.email, Scope.fullName]
      );
      print('uid: ${user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _buildContent(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loginCover.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 500,
                      //height: 700,
                      top: 70,
                      child: FadeAnimation(
                          1,
                          Container(
                            child: Text(
                              'Το dexi heri της εστίασης',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                    ),
                    Positioned(
                      left: 125,
                      width: 160,
                      height: 450,
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: FadeAnimation(
                              1.3,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo.png'))),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              _buildContent(context),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF35a8ab),
    );
  }

  Widget _buildContent(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Σύνδεση με Email',
            textColor: Colors.white,
            color: Color(0xFF35a8ab),
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Σύνδεση με Google',
            textColor: Colors.white,
            color: Color(0xFF35a8ab),
            onPressed: () => _signInWithGoogle(context),
          ),
          /*SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Σύνδεση με Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () => _signInWithGoogle(context),
          ),*/
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Σύνδεση με Facebook',
            textColor: Colors.white,
            color: Color(0xFF35a8ab),
            onPressed: () => _signInWithFacebook(context),
          ),
          /*SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () => _signInWithFacebook(context),
          ),*/
          SizedBox(height: 8.0),
          if (appleSignInAvailable.isAvailable)
            Platform.isIOS
                ? SignInButton(
        text: 'Σύνδεση με Apple Id',
        textColor: Colors.white,
        color: Color(0xFF35a8ab),
    onPressed: () => _signInWithApple(context),
    )

    /*AppleSignInButton(onPressed: () => _signInWithApple(context),*/
              /*onPressed: () async {
                    final appleIdCredential =
                        await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    );
                  }*/
                : Text(''),
          /*SignInButton(
            text: 'Sign in with Apple',
            textColor: Colors.white,
            color: Colors.black87,
            onPressed: () {},
          ),*/
          /*SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),*/
          /*SizedBox(height: 8.0),
          SignInButton(
            text: 'Anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: () => _signInAnonymously(context),
          ),*/
        ],
      ),
    );
  }
}
