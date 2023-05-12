import 'package:flash_chat_app1/routes.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../widgets/rounded_Button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.addStatusListener((status) {
      print(status);
    });
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                DefaultTextStyle(
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                        speed: Duration(milliseconds: 200))
                  ]),
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              buttonName: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, MyRoute.LoginScreen);
              },
            ),
            RoundedButton(
              buttonName: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, MyRoute.RegistrationScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}



 // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            //   child: Material(
            //     elevation: 5.0,
            //     color: Colors.lightBlueAccent,
            //     borderRadius: BorderRadius.circular(30.0),
            //     child: MaterialButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, MyRoute.LoginScreen);
            //         //Go to login screen.
            //       },
            //       minWidth: 200.0,
            //       height: 42.0,
            //       child: Text(
            //         'Log In',
            //       ),
            //     ),
            //   ),
            // ),