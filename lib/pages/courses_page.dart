import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/course.dart';
import 'package:project2/widgets/lectures_widget.dart';
import 'package:project2/widgets/text_button_widget.dart';

class CoursePage extends StatefulWidget {
  static const String id = 'CoursePage';
 final Map<String, dynamic>? course;
   CoursePage({super.key,   this.course});

  @override
  State<CoursePage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursePage> {
    late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
    @override
  void initState() {
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .get();
        
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: 400,
                height: 200,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // Round the top-left corner
                    topRight: Radius.circular(30), // Round the top-right corner
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Course instructor Name',
                        style: TextStyle(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButtonWidget(
                              text: 'Lecture',
                              onPressed: () {},
                            ),
                            TextButtonWidget(
                              text: 'Download',
                              onPressed: () {},
                            ),
                            TextButtonWidget(
                              text: 'Certificate',
                              onPressed: () {},
                            ),
                            TextButtonWidget(
                              text: 'More',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LecturesWidget(),
            ],
          ),
        ),
      )),
    );
  }
}
