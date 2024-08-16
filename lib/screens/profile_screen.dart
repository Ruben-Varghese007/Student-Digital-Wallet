import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    _user = FirebaseAuth.instance.currentUser;
    // Fetch additional user details (Roll No, username, etc.) from your data source
    // For example, you might use Firebase Firestore or any other backend service
    // Update the state with the user details once fetched
    setState(() {
      // Set user details here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: _user != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text(
              'Roll No',
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              'XXXXX',
                style: TextStyle(fontSize: 20)
            ), // Replace with the actual Roll No
          ),
          ListTile(
            title: const Text(
              'Email ID',
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              _user!.email ?? 'N/A',
                style: TextStyle(fontSize: 20),
            ),
          ),
          const ListTile(
            title: Text(
              'Username',
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              'XXXXX',
                style: TextStyle(fontSize: 20)
            ), // Replace with the actual username
          ),
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
