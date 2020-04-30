import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pickups extends StatefulWidget {
  static const routeName = '/pickup-screen';

  @override
  _PickupsState createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickups'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('userLocation').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              CircularProgressIndicator();
            }
            final garbages = snapshot.data.documents;
            final List<ListTile> finalUserData = [];
            for (var garbage in garbages) {
              final latitude = garbage.data['latitude'];
              final longitude = garbage.data['longitude'];
              final userEmail = garbage.data['user'];
              final time = garbage.data['DateTime'];

              final fUserData = ListTile(
                  title: Text('User: ' + userEmail),
                  subtitle: Text('longitude: ' +
                      longitude.toString() +
                      ' ' +
                      'latitude: ' +
                      latitude.toString() + '\n' + time),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {},
                  ),
                  onTap: (){
                   // PickupDetailsScreen(latitude: latitude, longitude: longitude, user: userEmail);
                   // Navigator.of(context).pushNamed(PickupDetailsScreen.routeName);
                  },
                  );
                  Divider(
                    color: Colors.green,
                    thickness: 2,
                  );
              finalUserData.add(fUserData);
              
            }
            return ListView.builder(
                itemCount: finalUserData.length,
                itemBuilder: (context, index) {
                  return finalUserData[index];
                });
          }),
    );
  }
}
