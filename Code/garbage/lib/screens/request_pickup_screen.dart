//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garbage/screens/pickup_done_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
//import 'package:mobile_popup/mobile_popup.dart';

class RequestPickupScreen extends StatefulWidget {
  static const routeName = '/request-pickup-screen';

  @override
  _RequestPickupScreenState createState() => _RequestPickupScreenState();
}

class _RequestPickupScreenState extends State<RequestPickupScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _isGettingLocation = true;
    getLocation();
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

  Geolocator geolocator = Geolocator();

  double _currentLatitude;
  double _currentLongitude;
  bool _isGettingLocation;

  getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
        _isGettingLocation = false;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isGettingLocation
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Request Pickup'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 400,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(_currentLatitude, _currentLongitude),
                      zoom: 5.0,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate: "https://api.mapbox.com/v4/"
                              "{id}/{z}/{x}/{y}@2x.png?access-token = pk.eyJ1Ijoic2lyc2hvMjkiLCJhIjoiY2s5a3djeWg5MDBxajNmcGdlbzdqa2JjayJ9.Z6bGrKh-cgCS7iPP_KSCgQ",
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1Ijoic2lyc2hvMjkiLCJhIjoiY2s5a3djeWg5MDBxajNmcGdlbzdqa2JjayJ9.Z6bGrKh-cgCS7iPP_KSCgQ',
                            'id': 'mapbox.streets',
                          }),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                              width: 80.0,
                              height: 80.0,
                              point:
                                  LatLng(_currentLatitude, _currentLongitude),
                              builder: (ctx) => Container(
                                    child: IconButton(
                                        icon: Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Colors.blue),
                                        onPressed: () {}),
                                  ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(0),
                  child: RaisedButton(
                      color: Colors.lightGreen,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Request Pickup',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Icon(FontAwesomeIcons.truck),
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      elevation: 0,
                      onPressed: () {
                        final dateTime = DateTime.now();
                        _firestore.collection('userLocation').add({
                          'user': loggedInUser.email,
                          'latitude': _currentLatitude,
                          'longitude': _currentLongitude,
                          'DateTime' : DateFormat.yMMMd()
                        .add_jm()
                        .format(dateTime).toString(),
                        });
                        Navigator.of(context).pushReplacementNamed(PickupDoneScreen.routeName);
                      }),
                )
              ],
            ));
  }
}


