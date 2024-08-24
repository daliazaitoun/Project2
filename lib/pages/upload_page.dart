import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFileScreen extends StatefulWidget {
  static const  String id = "upload";
  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? _file;

  // Function to pick a file
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    } else {
      print('No file selected');
    }
  }

  // Function to upload the file
  Future<void> uploadFile() async {
    if (_file == null) return;

    try {
      // Reference to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef =
          storageRef.child('uploads/${_file!.path.split('/').last}');

      // Upload the file
      final uploadTask = fileRef.putFile(_file!);

      // Listen for progress and completion
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      // Get the download URL once the upload is complete
      await uploadTask.whenComplete(() async {
        final downloadURL = await fileRef.getDownloadURL();
        print('File available at: $downloadURL');
      });
    } catch (e) {
      print('Upload failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_file != null)
            Text('Selected file: ${_file!.path.split('/').last}'),
          ElevatedButton(
            onPressed: pickFile,
            child: Text('Pick File'),
          ),
          ElevatedButton(
            onPressed: uploadFile,
            child: Text('Upload File'),
          ),
        ],
      ),
    );
  }
}
