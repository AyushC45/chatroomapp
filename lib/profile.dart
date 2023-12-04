import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _displayNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();

    // Load the current user's information
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Get the user's data from Firestore
      DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();

      print(userData.data().toString());
      setState(() {
        _emailController.text = userData['email'] ?? '';
        _displayNameController.text = userData['displayName'] ?? '';
      });
    }
  }

  void _saveChanges() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Update the user's data in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'displayName': _displayNameController.text,
      });

      // Show a success message or perform any other actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Changes saved successfully'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: 'Display Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
