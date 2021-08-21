// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(FlashChat());
}

//void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => WelcomeScreen(),
        //   '/login': (context) => LoginScreen(),
        //   '/register': (context) => RegistrationScreen(),
        //   '/chat': (context) => ChatScreen()
        // }

        //The reason the url is written as a static keyword, so that the if there is a typo
        // android studio will tell us whereas with string android studio will not able to detect typo
        initialRoute: WelcomeScreen.url,
        routes: {
          WelcomeScreen.url: (context) => WelcomeScreen(),
          LoginScreen.url: (context) => LoginScreen(),
          RegistrationScreen.url: (context) => RegistrationScreen(),
          ChatScreen.url: (context) => ChatScreen()
        });
  }
}
