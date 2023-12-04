import 'package:chatroomapp/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _dobController = TextEditingController();

    // Load the current user's information
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Get the user's data from Firestore
      DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();

      setState(() {
        _emailController.text = user.email ?? '';
        _dobController.text = userData['dob'] ?? '';
      });
    }
  }

  void _logout() async {
    await _auth.signOut();

    // Navigate to the sign-up screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }


  void _updateEmailAndPassword() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Update email
      await user.updateEmail(_emailController.text);

      // Update password
      await user.updatePassword(_passwordController.text);

      // Show a success message or perform any other actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login information updated successfully'),
      ));
    }
  }

  void _updateDOB() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Update the user's data in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'dob': _dobController.text,
      });

      // Show a success message or perform any other actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Date of Birth updated successfully'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateEmailAndPassword();
              },
              child: Text('Update Login Information'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _updateDOB();
              },
              child: Text('Update Date of Birth'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
