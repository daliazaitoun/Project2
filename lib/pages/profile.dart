import 'dart:ffi';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project2/pages/login_page.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Stack(children: [
                                CircleAvatar(
                                  radius: 60,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            onPressed: () async {
                      var imageResult = await FilePicker.platform
                          .pickFiles(type: FileType.image, withData: true);
                      if (imageResult != null) {
                        var storageRef = FirebaseStorage.instance
                            .ref('images/${imageResult.files.first.name}');
                        var uploadResult = await storageRef.putData(
                            imageResult.files.first.bytes!,
                            SettableMetadata(
                              contentType:
                                  'image/${imageResult.files.first.name.split('.').last}',
                            ));
            
                        if (uploadResult.state == TaskState.success) {
                          var downloadUrl =
                              await uploadResult.ref.getDownloadURL();
                          print('>>>>>Image upload${downloadUrl}');
                        }
                      } else {
                        print('No file selected');
                      }
                    },
                                            icon: Icon(
                                              Icons.image,
                                              size: 30,
                                             
                                            ))))
                              ]),
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
                        CardWidget(title: "About us", onPressed: () {}),
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()));
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text('Not Logged In'),
                        CustomTextButton(
                            label: "Login",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()));
                            }),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
