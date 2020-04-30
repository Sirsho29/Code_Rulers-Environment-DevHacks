import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/waste_items.dart';
import '../widgets/chart.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:barcode_scan/barcode_scan.dart';

import './full_history.dart';
import './request_pickup_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) loggedInUser = user;
      print(loggedInUser.email);
    } catch (e) {
      print(e);
    }
  }

  /*List<String> qrValue;
  String title;
  int countWasteItems;
  String date;
  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
        qrValue = qrResult.rawContent.split('.');
        title = qrValue.toString().substring(1,3);
        countWasteItems = qrValue.toString().substring(4,6) as int;
        date = qrValue.toString().substring(7,13);
    } on FormatException catch (_) {
      setState(() {
        return SnackBar(content: Text('Nothing Scanned!!'));
      });
    }
  }*/

  void dataStream() async {
    await for (var snapshot
        in _firestore.collection('garbageData').snapshots()) {
      for (var garbageData in snapshot.documents) print(garbageData.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pop();
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: Text('Garbage Collection'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StreamBuilder(
                stream: _firestore.collection('garbageDataOW').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    CircularProgressIndicator();
                  }
                  final garbages = snapshot.data.documents;
                  final List<WasteItems> finalOWData = [];
                  for (var garbage in garbages) {
                    final owGarbageCount = garbage.data['OWgarbageCount'];
                    final owGarbageDateTime = garbage.data['OWgarbageDate'];
                    //final owUser = garbage.data['userEmail'];
                    
                    final fOWData = WasteItems(
                        countWasteItems: owGarbageCount,
                        date: owGarbageDateTime);
                    finalOWData.add(fOWData);
                  }
                  return HomeChart(
                    data: finalOWData,
                    title: 'Organic Wastes History',
                  );
                }),
            SizedBox(height: 5),
            StreamBuilder(
                stream: _firestore.collection('garbageDataRW').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    CircularProgressIndicator();
                  }
                  final garbages = snapshot.data.documents;
                  final List<WasteItems> finalRWData = [];
                  for (var garbage in garbages) {
                    final rwGarbageCount = garbage.data['RWgarbageCount'];
                    final rwGarbageDateTime = garbage.data['RWgarbageDate'];
                    

                    final fRWData = WasteItems(
                        countWasteItems: rwGarbageCount,
                        date: rwGarbageDateTime);
                    finalRWData.add(fRWData);
                  }
                  return HomeChart(
                    data: finalRWData,
                    title: 'Recyclable Wastes History',
                  );
                  
                }),
            SizedBox(height: 10),
             Material(
                elevation: 5.0,
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                   Navigator.of(context).pushNamed(FullHistory.routeName);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Check Full History',style: TextStyle(
                      fontSize: 20,
                  fontFamily: 'CO'
                ),
                  ),
                ),
            ),
            /*SizedBox(height: 10),
            RaisedButton(
              child: Text('Scan QR Code'),
              onPressed: _scanQR,
            ),*/
            SizedBox(height: 10),
            Material(
                elevation: 5.0,
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RequestPickupScreen.routeName);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Request Pickup',style: TextStyle(
                      fontSize: 20,
                  fontFamily: 'CO'
                ),
                  ),
                ),
            )],
        ),
      ),
    );
  }
}
