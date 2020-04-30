import 'package:flutter/material.dart';

class PickupDetailsScreen extends StatelessWidget {
  static const routeName = '/pickup-detail';
  final latitude;
  final longitude;
  final String user;
  PickupDetailsScreen({this.latitude, this.longitude, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Details'),
      ),
      body: Center(child: Text(user)),
    );
  }
}
