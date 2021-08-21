import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const String url = "/welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.deepPurpleAccent, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(
      () {
        //print(animation.value);
        setState(() {});
        //Empty SetState is written so that we can use the controller.value in
        // various place with changing controller.value flutter need to know so that it can rebuild the ui
        //i.e we have put empty setState
      },
    );
  }

  //Disposing the controller as if not disposed then even we do the page change the aniamtion will
  //run in the background
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              children: <Widget>[
                Hero(
                  tag: 'appLogo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value * 60,
                  ),
                ),
                SizedBox(
                  //width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Flash Chat',
                          speed: Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                key: UniqueKey(),
                buttonColor: Colors.lightBlueAccent,
                title: "Log In",
                handleOnPressed: () {
                  Navigator.pushNamed(context, LoginScreen.url);
                }),
            RoundedButton(
                key: UniqueKey(),
                buttonColor: Colors.blueAccent,
                title: "Register",
                handleOnPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.url);
                }),
          ],
        ),
      ),
    );
  }
}
