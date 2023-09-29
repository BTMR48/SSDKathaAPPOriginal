import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Provider/user_model.dart';
import '../ScreenTest/HomeScreen.dart';

class CancelSubscriptionScreen extends StatefulWidget {
  const CancelSubscriptionScreen({super.key});

  @override
  State<CancelSubscriptionScreen> createState() => _CancelSubscriptionScreenState();
}

class _CancelSubscriptionScreenState extends State<CancelSubscriptionScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late double width, height;
  TextEditingController customReasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    child: const Text(
                      "Cancel Subscription ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 10,right: 16,left: 16 ),
                    child: TextField(
                      controller: customReasonController,
                      decoration: InputDecoration(
                        labelText: 'Additional Reason',
                        hintText: 'Enter your reason here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF8D72DE),
                            width: 4,

                          ),
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (customReasonController.text.isNotEmpty) {
                            String reasonToSave =
                           customReasonController.text ;
                            accessToken(reasonToSave,context);


                          } else {
                            // Handle the case where no reason is selected or entered
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: customReasonController.text.isNotEmpty
                              ? Colors.red // Color when a reason is selected or entered
                              : const Color(0xFF8D72DE), // Default color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Cancel Subscription',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Future<void> accessToken(String reasonToSave,BuildContext context) async {
    // Sandbox - https://sandbox.payhere.lk/merchant/v1/oauth/token
// API APP ID - 4OVxMdcNa3U4JDDSWqB2iX3LJ
//API App Secret - 49Y1GKEPhAs4pG55s7TTYk4KH01I1k7tc8Qh88NjaE8w

    if (kDebugMode) {
      print('payHereCancel() payHereCancel()');
    }
    String url = ' https://sandbox.payhere.lk/merchant/v1/oauth/token';

// test -  'Authorization': 'Basic NE9WeE1kY05hM1U0SkREU1dxQjJpWDNMSjo0OVkxR0tFUGhBczRwRzU1czdUVFlrNEtIMDFJMWs3dGM4UWg4OE5qYUU4dw==',


    // The headers for the API call
    Map<String, String> headers = {
      'Authorization': 'Basic NE9WeE1kY05hM1U0SkREU1dxQjJpWDNMSjo0OVkxR0tFUGhBczRwRzU1czdUVFlrNEtIMDFJMWs3dGM4UWg4OE5qYUU4dw==',

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



    String url = 'https://sandbox.payhere.lk/merchant/v1/oauth/token';

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
}
