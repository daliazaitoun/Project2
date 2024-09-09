import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:project2/pages/categories_page.dart';
import 'package:project2/pages/upload_page.dart';
import 'package:project2/widgets/categories_widget.dart';
import 'package:project2/widgets/courses_widget.dart';
import 'package:project2/widgets/label_widget.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LabelWidget(
                  name: 'Categories',
                  onSeeAllClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => CategoriesPage()));
                  },
                ),
                CategoriesWidget(),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Seller Courses',
                  onSeeAllClicked: () {},
                ),
                const CoursesWidget(
                  rankValue: 'top_rated',
                ),
                LabelWidget(
                  name: 'Top Rated Courses',
                  onSeeAllClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => UploadFileScreen()));
                  },
                ),
                const CoursesWidget(
                  rankValue: 'top_seller',
                ),
  
                ElevatedButton(
                    onPressed: () async {
                      PaymobPayment.instance.initialize(
                        apiKey: dotenv.env[
                            'apiKey']!, // from dashboard Select Settings -> Account Info -> API Key
                        integrationID: int.parse(dotenv.env[
                            'integrationID']!), // from dashboard Select Developers -> Payment Integrations -> Online Card ID
                        iFrameID: int.parse(dotenv.env[
                            'iFrameID']!), // from paymob Select Developers -> iframes
                      );
            
                      final PaymobResponse? response =
                          await PaymobPayment.instance.pay(
                        context: context,
                        currency: "EGP",
                        amountInCents: "20000", // 200 EGP
                      );
            
                      if (response != null) {
                        print('Response: ${response.transactionID}');
                        print('Response: ${response.success}');
                      }
                    },
                    child: Text('paymob pay'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
