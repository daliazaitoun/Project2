import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/category.dart';

class ExpansionWidget extends StatefulWidget {
  final String title;

  ExpansionWidget({super.key, required this.title});

  @override
  State<ExpansionWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<ExpansionWidget> {
 // List<Category> data = [];
  var _data = [
    Item(header: "business", body: "Budiness "),
    Item(header: "finance", body: "finance"),
    Item(header: "education", body: "education"),
  ];


  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    futureCall = FirebaseFirestore.instance.collection('categories').get();
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
                    body: Column(
                      children: [
                        ListTile(
                          title: Text(categories[index].id!),
                        ),
                      ],
                    ),
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
