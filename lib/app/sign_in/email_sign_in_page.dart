import 'package:dexiheri/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Σύνδεση', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Color(0xFF35a8ab),
      resizeToAvoidBottomInset: false,
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
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 500,
                      //height: 700,
                      top: 70,
                      child: FadeAnimation(1, Container(
                        child: Text('Το dexi heri της εστίασης', style: TextStyle(color: Colors.white, fontSize: 16 ),),
                      )),
                    ),
                    Positioned(
                      left: 125,
                      width: 160,
                      height: 450,
                      child: FadeAnimation(1.6, Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png')
                              )
                          ),
                        )),
                      )),
                    )
                  ],
                ),
              ),
              /*//e-mail textfield
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  //controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),

              //password textfield
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  //controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),*/
              EmailSignInForm(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: (){
                      /*Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new ResetPasswordScreen()));*/
                    },
                    child: Text('Ξέχασα το κωδικό μου', style: TextStyle(color: Colors.white, fontSize: 14))
                ),
              ),

              //Sign in / Sign up button
              /*TextButton(
                onPressed: () {
                  if (signUp) {
                    //Provider sign up method
                    context.read<AuthenticationProvider>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  } else {
                    //Provider sign in method
                    context.read<AuthenticationProvider>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  }
                },
                child: signUp ? Text("Εγγραφή", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)) : Text("Σύνδεση", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),*/

              //Sign up / Sign In toggler
              /*TextButton(
                onPressed: () {
                  setState(() {
                    signUp = !signUp;
                  });
                },
                child: signUp ? Text("Έχετε ήδη λογαριασμό; Συνδεθείτε", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),) : Text("Δημιουργία λογαριασμού", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),*/
            ],

          ),
        ),
      ),
    );
  }

}

Widget _divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Divider(
              thickness: 1,
              color: Colors.white,
            ),
          ),
        ),
        Text('ή συνδεθείτε με',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Divider(
              thickness: 1,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
