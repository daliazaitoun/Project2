import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:project2/widgets/cart_widget.dart';
import 'package:project2/widgets/custom_elevated_button.dart';

class CartPage extends StatefulWidget {
  static const String id = "cart_page";
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cart')),
      ),
      body: Column(
        children: [CartWidget(), CustomElevatedButton(  onPressed: () async {
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
                        amountInCents: "20000", // 200 EGP // need to edit
                      );

                      if (response != null) {
                        print('Response: ${response.transactionID}');
                        print('Response: ${response.success}');
                      }
                    },
                   text: "pay",)],
      ),
    );
  }
}
