import 'package:flash_chat_app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../routes.dart';
import '../widgets/rounded_Button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFeildDecoration.copyWith(hintText: 'Enter your email'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFeildDecoration
                    .copyWith(hintText: 'Enter your password')
                    .copyWith(),
                // style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonName: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  print(email);
                  print(password);

                  try {
                    var newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (newUser != null) {
                      await Future.delayed(new Duration(seconds: 1));
                      Navigator.pushNamed(context, MyRoute.ChatScreen);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Colors.lightBlueAccent,
              //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //Implement login functionality.
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: Text(
              //         'Log In',
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
