import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_app1/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../routes.dart';
import '../widgets/rounded_Button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // void initState() {

  //   Firebase.initializeApp().whenComplete(() {
  //     print(" firebase completed");
  //     setState(() {});
  //   });
  // }

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(
                      hintText: 'Enter  your  email'),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFeildDecoration.copyWith(
                    hintText: 'Enter your password'),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonName: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      await Future.delayed(Duration(seconds: 1));
                      print(
                          '..........You registered Successfuly...................................................................');
                      Navigator.pushNamed(context, MyRoute.ChatScreen);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: Material(
              //     color: Colors.blueAccent,
              //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //     elevation: 5.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         //Implement registration functionality.
              //       },
              //       minWidth: 200.0,
              //       height: 42.0,
              //       child: Text(
              //         'Register',
              //         style: TextStyle(color: Colors.white),
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
