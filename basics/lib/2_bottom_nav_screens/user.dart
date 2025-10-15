import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../authentication/phone.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "USER PROFILE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber.shade700,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }
          
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final username = userData['username'] ?? userData['name'] ?? 'User';
          final email = userData['email'] ?? 'N/A';
          final uid = userData['uid'] ?? 'N/A';
          
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.amber.shade300, Colors.amber.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 50,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'User Information',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildUserInfoRow('Username:', username),
                            const SizedBox(height: 15),
                            buildUserInfoRow('Email:', email),
                            const SizedBox(height: 15),
                            buildUserInfoRow('User ID:', uid),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          border: Border.all(color: Colors.blue.shade300, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 Your data is stored in:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Firestore Database',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            Text(
                              '↓',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade600,
                              ),
                            ),
                            Text(
                              'Collection: users',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade800,
                                fontFamily: 'Courier',
                              ),
                            ),
                            Text(
                              'Document ID: $uid',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Log Out'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                              child: const Text('Log Out'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUserInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}