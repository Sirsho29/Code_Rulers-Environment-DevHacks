import 'package:flutter/material.dart';
import 'package:garbage/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupDoneScreen extends StatelessWidget {

  static const routeName = '/pickup-done';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text('Pickup Successful!!',style: GoogleFonts.sacramento(color: Colors.lightGreen,fontSize: 50,fontWeight: FontWeight.bold),
            ),),
            Container(
              width: 300,
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                }, 
                child: ListTile(
                  title: Text('Go to Home...',style: GoogleFonts.aclonica(color:Colors.blue,fontSize: 20),),
                  trailing: Icon(Icons.home,size: 40,),
                  )),
            )
          ],
        ),
      ),
      
    );
  }
}