import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:project2/models/course.dart';
import 'package:project2/models/lecture.dart';
import 'package:project2/utils/app_enums.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final void Function(Lecture) onLectureChosen;
  const CourseOptionsWidgets(
      {required this.courseOption,
      required this.course,
      required this.onLectureChosen,
      super.key});

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.Lecture:
        return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('courses')
                .doc(widget.course.id)
                .collection('Lectures')
                 .orderBy('sort' )
                .get(),
            builder: (ctx, snapshot) {
              print('course Id ${widget.course.id}');
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
                  child: Text('No Lectures found'),
                );
              }

              var lectures = List<Lecture>.from(snapshot.data?.docs
                      .map((e) => Lecture.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              return GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(lectures.length, (index) {
                  return InkWell(
                    onTap: () => widget.onLectureChosen(lectures[index]),
                    child: Container(
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
                                  'Lecture ${lectures[index].sort}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.file_download_outlined,
                                      size: 30,
                                    )),
                              ],
                            ),
                            Text(lectures[index].title!, style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                            Text(lectures[index].describtion!,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                    "Duration \n ${lectures[index].duration} min"),
                                Spacer(),
                                Icon(Icons.play_circle_outline_sharp,size: 45,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            });

      case CourseOptions.Download:
        return const SizedBox.shrink();

      case CourseOptions.Certificate:
        return const SizedBox.shrink();

      case CourseOptions.More:
        return const SizedBox.shrink();
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
