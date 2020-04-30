import 'package:flutter/material.dart';
import 'package:garbage_truck/screens/pickup_details_screen.dart';
import 'package:garbage_truck/screens/pickups.dart';
import './screens/HomePage.dart';
import './screens/registration_screen.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Collection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      routes: {
        LoginScreen.routeName : (ctx) => LoginScreen(),
        RegistrationScreen.routeName : (ctx) => RegistrationScreen(),
        HomePage.routeName : (ctx) => HomePage(),
        Pickups.routeName : (ctx) => Pickups(),
        PickupDetailsScreen.routeName : (ctx) => PickupDetailsScreen(),
      },
    );
  }
}
