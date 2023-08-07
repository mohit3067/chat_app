import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/extras/button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset('images/logo.png'),
                          height: 60.0,
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 239, 161, 5),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [WavyAnimatedText('Flash Chat')],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              button(
                  color: Colors.lightBlueAccent,
                  label: 'Log In',
                  ontap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
              button(
                  color: Colors.blueAccent,
                  label: 'Register',
                  ontap: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  }),
            ]),
      ),
    );
  }
}
