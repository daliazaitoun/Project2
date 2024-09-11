import 'package:flutter/material.dart';
import 'package:project2/pages/payment_page.dart';
import 'package:project2/widgets/expansion_widget.dart';

class CategoriesPage extends StatefulWidget {
     static const String id = 'categories';

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Center(child: Text('Categories')),
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to cart page // need edit
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: ExpansionWidget(),
             ),
             
            
            ],
          ),
        ));
  }
}
