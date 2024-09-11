import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/category.dart';
import 'package:project2/models/course.dart';
import 'package:project2/pages/course_details_page.dart';
import 'package:project2/utils/color_utilis.dart';

class ExpansionWidget extends StatefulWidget {

  ExpansionWidget({    
    super.key,
  });

  @override
  State<ExpansionWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<ExpansionWidget> {
  // List<Category> data = [];
  var _data = [
    Item(header: "business", body: "Business "),
    Item(header: "finance", body: "finance"),
    Item(header: "education", body: "education"),
  ];

  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall2;

  @override
  void initState() {
    futureCall = FirebaseFirestore.instance.collection('categories').get();
    futureCall2 = FirebaseFirestore.instance.collection('courses').get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCall,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            child: Text('No Categories found'),
          );
        }

        var categories = List<Category>.from(snapshot.data?.docs
                .map((e) => Category.fromJson({'id': e.id, ...e.data()}))
                .toList() ??
            []);

        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 500),
                //  expandIconColor:
                //   expandedHeaderPadding: EdgeInsets.all(25),
                expansionCallback: (index, value) {
                  setState(() {
                    for (var item in _data) {
                      item.isExpanded = false;
                    }
                    _data[index].isExpanded = value;
                  });
                },
                children: List.generate(categories.length, (index) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Color(0xffEBEBEB),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        height: 40,
                        child: ListTile(
                          title: Text(categories[index].name!),
                        ),
                      );
                    },
                    body: FutureBuilder(
                        future: futureCall2,
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error occurred'),
                            );
                          }

                          if (!snapshot.hasData ||
                              (snapshot.data?.docs.isEmpty ?? false)) {
                            return const Center(
                              child: Text('No Courses found'),
                            );
                          }

                          var courses = List<Course>.from(snapshot.data?.docs
                                  .map((e) => Course.fromJson(
                                      {'id': e.id, ...e.data()}))
                                  .toList() ??
                              []);

                          return Column(
                            children: [
                              // Text("${categories[index].id}"),
                              GridView.count(
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                children:
                                    List.generate(courses.length, (index) {
                                  return SingleChildScrollView(
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (ctx) => CoursePage()));
                                        Navigator.pushNamed(
                                            context, CourseDetailsPage.id,
                                            arguments: courses[index]);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 180,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.asset(
                                                    'assets/images/test.jpg',
                                                    fit: BoxFit.contain,
                                                  ))),

                                          //  Image.network(courses[index].image ?? 'No image'),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  courses[index].title ??
                                                      'No Name',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons
                                                        .person_outline_sharp),
                                                    Text(
                                                      courses[index]
                                                              .instructor!
                                                              .name ??
                                                          'No Author',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\$  ${courses[index].price.toString()}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: ColorUtility
                                                              .main),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        }),
                    isExpanded: _data[index].isExpanded,
                  );
                })),
          ),
        ));
      },
    );
  }
}

class Item {
  Item({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });

  String header;
  String body;
  bool isExpanded;
}
