import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:katha/Screens/Paymentgateway/payhereServices.dart';
import 'package:http/http.dart' as http;
import '../../Provider/user_model.dart';
import '../ScreenTest/HomeScreen.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    DateTime today = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:        Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 28,
                          color: Color.fromARGB(255, 12, 63, 112) ,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.04),
                      child: Text(
                        "Price Plan",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  SubscriptionPayment().premiumPetPurchasePayment(

                      mainContext:context,
                      gSignClientId: '${user?.uid}',
                      sAppID:'sAppID',
                      skey:'skey',
                      phone: '',
                      email:' ${user?.email}',
                      name: '${user?.email}',
                      country:'Sri Lanka',
                      subscriptionDate:today,
                      subscriptionPlanCategory:'Premium',
                      subscriptionExpireDate:   today.add(Duration(days: 30)),
                      recurrence:'1 Month',
                      duration:'10 Years',
                      price:2500,
                  );
                },
                child:  SubscriptionCard(
                  title:  "Premium",
                  currency: 'LKR',
                  price:  "2500.0",
                  additionalText: 'Per Package/month, Billed monthly',
                  additionalText1: "Features you'll love",
                  features:
                  const [
                    "Word Error Detection",
                    "Letter by letter show error ",
                     "Therapeutic gaming activities "
                  ],
                  cardColor: Colors.blueAccent,
                ),
              ),
              GestureDetector(
                onTap: (){
                  SubscriptionPayment().premiumPetPurchasePayment(

                    mainContext:context,
                    gSignClientId: '${user?.uid}',
                    sAppID:'sAppID',
                    skey:'skey',
                    phone: '',
                    email:' ${user?.email}',
                    name: '${user?.email}',
                    country:'Sri Lanka',
                    subscriptionDate:today,
                    subscriptionPlanCategory:'Advanced',
                    subscriptionExpireDate:   today.add(Duration(days: 30)),
                    recurrence:'1 Month',
                    duration:'10 Years',
                    price:1500,
                  );
                },
                child:  SubscriptionCard(
                  title:  "Advanced",
                  currency: 'LKR',
                  price:  "1500.0",
                  additionalText: 'Per Package/month, Billed monthly',
                  additionalText1: "Features you'll love",
                  features:
                  [
                    "Word Error Detection",
                    "Therapeutic gaming activities "
                  ],
                  cardColor: Colors.teal,
                ),
              ),
              GestureDetector(
                onTap: (){
                  SubscriptionPayment().premiumPetPurchasePayment(
                    mainContext:context,
                    gSignClientId: '${user?.uid}',
                    sAppID:'sAppID',
                    skey:'skey',
                    phone: '',
                    email:' ${user?.email}',
                    name: '${user?.email}',
                    country:'Sri Lanka',
                    subscriptionDate:today,
                    subscriptionPlanCategory:'Standard',
                    subscriptionExpireDate:   today.add(Duration(days: 30)),
                    recurrence:'1 Month',
                    duration:'10 Years',
                    price:500,
                  );
                },
                child:  SubscriptionCard(
                  title:  "Standard",
                  currency: 'LKR',
                  price:  "500.0",
                  additionalText: 'Per Package/month, Billed monthly',
                  additionalText1: "Features you'll love",
                  features:
                  [
                    "Therapeutic gaming activities "
                  ],
                  cardColor: Colors.cyan,
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
Future<void> accessToken(String reasonToSave,BuildContext context) async {
  // Sandbox - https://sandbox.payhere.lk/merchant/v1/oauth/token

  if (kDebugMode) {
    print('payHereCancel() payHereCancel()');
  }
  String url = 'http://www.payhere.lk/merchant/v1/oauth/token';

// test -  'Authorization': 'Basic NE9WeE1kYkZqZEk0SkREU1dxQjJpWDNMSjo0a21mTXc5OUFPbzREc0FZdUJseTMzNEpFV3g4eGpVYWo4Z2R1Q29TSzBnYQ==',


  // The headers for the API call
  Map<String, String> headers = {
    'Authorization': 'Basic NE9WeE1kYkZqZEk0SkREU1dxQjJpWDNMSjo0a21mTXc5OUFPbzREc0FZdUJseTMzNEpFV3g4eGpVYWo4Z2R1Q29TSzBnYQ==',

  };

  // The body for the API call
  Map<String, String> body = {
    'grant_type': 'client_credentials'
  };
  // Making the POST request
  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );


  // Checking the status of the response
  if (response.statusCode == 200) {
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    String accessToken = decodedResponse['access_token']; // Extract access_token
    print('Access Token: $accessToken'); // Print access_token

    payHereCancel(reasonToSave:reasonToSave,accessToken:accessToken,mainContext:context);  // Assuming this function is defined elsewhere

    if (kDebugMode) {
      print('Successfully accessToken');
    }
  } else {
    if (kDebugMode) {
      print('Failed to get access token: ${response.statusCode}');
    }
  }
}


Future<void> payHereCancel({required String reasonToSave,required String accessToken, required BuildContext mainContext}) async {

  if (kDebugMode) {
    print('payHereCancel() payHereCancel() $accessToken');
  }
  // Sandbox - https://sandbox.payhere.lk/merchant/v1/subscription/cancel


  String url = 'http://www.payhere.lk/merchant/v1/subscription/cancel';

  // The headers for the API call
  Map<String, String> headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  // The body for the API call
  Map<String, String> body = {
    'subscription_id': "121313"
  };

  // Making the POST request
  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );

  // Decoding the response
  Map<String, dynamic> decodedResponse = jsonDecode(response.body);

  // Checking the status of the response
  if (decodedResponse['status'] == 1) {
    // saveReasonToFirestore(reasonToSave);

    if (kDebugMode) {
      print('Successfully cancelled the subscription');
    }

    // You can delay the navigation if you wish
    // navigateCancelComplete(context);
    // showSnackBar("Successfully cancelled the subscription", Duration(milliseconds: 800));
  } else if (decodedResponse['status'] == -1) {
    if (kDebugMode) {
      print('Error: ${decodedResponse['msg']}');
      // saveReasonToFirestore(reasonToSave);
      // // You can delay the navigation if you wish
      // navigateCancelComplete(context);
      // showSnackBar("${decodedResponse['msg']}", Duration(milliseconds: 800));
    }
  } else {
    if (kDebugMode) {
      print('An unknown error occurred');
    }
  }
}
class SubscriptionCard extends StatelessWidget {
  final String title;
  final String currency;
  final String price;
  final String additionalText;
  final String additionalText1;
  final List<String> features;
  final Color cardColor;

  SubscriptionCard({
    required this.title,
    required this.currency,
    required this.price,
    required this.additionalText,
    required this.additionalText1,
    required this.features,
    required this.cardColor, // Add a parameter for card color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 8,
        color: cardColor, // Set the background color for the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          // Remove the border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$currency $price',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      additionalText,
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), // Set text color to white
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      additionalText1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white, // Set the color for the divider line
              height: 1,
              child: const Divider(),
            ),
            Column(
              children: features.map((feature) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    radius: 15.0,
                  ),
                  title: Text(
                    feature,
                    style: feature.contains('SOS Feature')
                        ? const TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontWeight: FontWeight.bold) // Set text color to white
                        : const TextStyle(color: Colors.white), // Set text color to white
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}