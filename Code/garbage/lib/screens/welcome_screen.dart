import 'package:flutter/material.dart';

import './login_screen.dart';
import './registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName='welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/1.jpg'), fit: BoxFit.cover)),
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              trailing: Hero(
                tag: 'Logo',
                child: CircleAvatar(backgroundColor: Colors.white,radius:50,child: Icon(Icons.delete_sweep,size: 40,color: Color.fromRGBO(34, 139, 34, 1),))),
              title: Text(
                'Garbageo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'CO'
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        LoginScreen.routeName); //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',style: TextStyle(
                      fontSize: 20,
                  fontFamily: 'CO'
                ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Color.fromRGBO(34, 139, 34, 1),
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        RegistrationScreen
                            .routeName); //Go to registration screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',style: TextStyle(
                  fontFamily: 'CO',fontSize: 20,
                ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
