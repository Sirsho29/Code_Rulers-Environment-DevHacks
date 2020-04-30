import 'package:flutter/material.dart';

class FullHistory extends StatelessWidget {
  
  static const routeName = '/full-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full History'),
      ),
      body: Center(
        child: Text('Full History'),
      ),
      
    );
  }
}