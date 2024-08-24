import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/course.dart';

class LecturesWidget extends StatefulWidget {
  const LecturesWidget({super.key});

  @override
  State<LecturesWidget> createState() => _LecturesWidgetState();
}

class _LecturesWidgetState extends State<LecturesWidget> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  @override
  void initState() {
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .orderBy('created_date', descending: true)
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCall,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred'),
            );
          }

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
            return const Center(
              child: Text('No Courses found'),
            );
          }
          var courses = List<Course>.from(snapshot.data?.docs
                  .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                  .toList() ??
              []);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GridView.count(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 25,
                      childAspectRatio : 0.9,
                    shrinkWrap: true,
                    crossAxisCount:2,
                    children: List.generate(8, (index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                  BoxShadow(
                    color: Colors.black26, 
                    blurRadius: 10, 
                    offset: Offset(5, 5),
                  ),
                ],
                          color: const Color(0xffE0E0E0),
                          borderRadius: BorderRadius.circular(30),
                       
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Lecture 1",
                                    style: TextStyle(),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.file_download_outlined)),
                                ],
                              ),
                              Text("Lecture name"),
            
                              Text("Lecture description 00000000000000"),
                              const Spacer(),
                               Row(
                                children: [
                                  Text("Duration: \n 10 min"),
                                  Spacer(),
                                  Icon(Icons.play_circle_outline_sharp),
                                ],
                              ),
            
                              // Text(courses[index].duration?? 'No Duration'),
                              // Text(courses[index].description?? 'No description'),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
