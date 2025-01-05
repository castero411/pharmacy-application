import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/wide_button.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    int age = 21;

    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Page",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 100.0, right: 100.0, bottom: 25.0),
          child: WideButton(
              title: "Edit Account",
              onTap: () {
                Navigator.pushNamed(context, 'edit_account_page');
              })),
      body: userId == null
          ? Center(
              child: Text(
                'No user logged in',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : StreamBuilder<DocumentSnapshot>(
              //this part streams the data from firestore in case any changes happen!
              //especially soon when the image gets added instead of the icon
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(
                    child: Text(
                      'No data found for this user',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final username = userData['username'] ?? 'Unknown';
                final email = userData['email'] ?? 'Unknown';

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        //TODO: apply the image picker and use it to add a profile picture for the user
                        child: Icon(
                          Ionicons.person_circle_outline,
                          size: 130,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Center(
                        child: Text(
                          '$username',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 36.0, bottom: 10.0, left: 10.0),
                        child: Text(
                          'Email: $email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10.0, left: 10.0),
                        child: Text(
                          'Age: $age',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10.0, left: 10.0),
                        child: Text(
                          'Gender: Male',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
