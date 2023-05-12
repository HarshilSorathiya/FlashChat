import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_app1/routes.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(primarySwatch: Colors.lightBlue),
      // theme: ThemeData.dark().copyWith(
      //   // primaryTextTheme: Typography.material2021().black,
      //   // typography: Typography(black: TextTheme()),
      //   textTheme: TextTheme(
      //     displayMedium: TextStyle(color: Colors.black54),
      //   ),
      // ),
      // home: WelcomeScreen(),
      initialRoute: MyRoute.WelcomeScreen,
      routes: {
        MyRoute.WelcomeScreen: (context) => WelcomeScreen(),
        MyRoute.ChatScreen: (context) => ChatScreen(),
        MyRoute.LoginScreen: (context) => LoginScreen(),
        MyRoute.RegistrationScreen: (context) => RegistrationScreen(),
      },
    );
  }
}
