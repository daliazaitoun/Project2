import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/widgets/Custom_text_button.dart';
import 'package:project2/widgets/card_widget.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data != null) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                //   backgroundImage: AssetImage('assets/profile_picture.png'),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${FirebaseAuth.instance.currentUser?.displayName}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${FirebaseAuth.instance.currentUser?.email}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CardWidget(title: "Edit", onPressed: () {}),
                        CardWidget(title: "Settings", onPressed: () {}),
                        CardWidget(title: "Achievements", onPressed: () {}),
                        CardWidget(title: "About us", onPressed: () {}),
                        CustomTextButton(label: "logout", onPressed: () {}),
                       
                      ],
                    );
                  } else {
                    return Text('Not Logged In');
                  }
                }),
         
            
          ],
        ),
      ),
    );
  }
}
