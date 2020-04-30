import 'welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   
    super.initState();
    Timer(Duration(seconds: 4),()=>Navigator.pushReplacementNamed(context,WelcomeScreen.routeName ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/1.jpg"), fit: BoxFit.cover),),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete_sweep,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  Text(
                    'Garbageo',style: TextStyle(fontFamily: 'CO',fontSize: 30,),
                    softWrap: true,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    CircularProgressIndicator(backgroundColor: Colors.black54,strokeWidth: 10,),
                    Text('Your Garbage Collector',style: TextStyle(fontFamily: 'CO',fontSize: 15,),)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
