import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class SubscriptionPayment {

  void premiumPetPurchasePayment({

    ///
    // required double totalPrice,
    //
    // required String city,
    required String country,
    required String skey,

    required String sAppID,
    required String gSignClientId,
    required String phone,
    required String email,
    required String name,
    // required DateTime subscriptionDate,
    required String subscriptionPlanCategory,
    // required DateTime subscriptionExpireDate,
    required String petCount,
    required String recurrence,
    required String duration,
    required int price, required mainContext,
  }) async {
    // Generating an order ID kathaapp.tbmr@gmail.com
    final orderId = 'petpulzMorePets${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}';
    // 4916217501611292
    // Creating a payment object
    Map paymentObject = {
      "sandbox": true,                 // true if using Sandbox Merchant ID
      "merchant_id": "1223095",        // Replace your Merchant ID
      "merchant_secret": "MzM2NTk5NjI4NDM4NDk1MDQ5MzYxNjIxMTg0MTAzMjEyMjc4MjE0OQ==",        // See step 4e
      "notify_url": "",//
      "order_id": orderId,      //payment no
      "items": "Plan 2",//package number //plan
      "amount": "100",               // Recurring amount
      "recurrence": "1 Month",         // Recurring payment frequency
      "duration": "1 Year",            // Recurring payment duration
      "startup_fee": "0.00",          // Extra amount for first payment
      "currency": "LKR",
      "first_name": "Dasun",
      "last_name": '',
      "email": "tharindudasun0@gmail.com",
      "phone": "0770208268",
      "address": "",
      "city": "",
      "country": "Sri Lanka",
      "delivery_address": "",
      "delivery_city": "",
      "delivery_country": "Sri Lanka",
      "custom_1": gSignClientId,
      "custom_2": ""
    };

    // Initiating the payment process
    PayHere.startPayment(paymentObject, (paymentId) async {
      EasyLoading.showToast(
          "Payment Success! Payment Id: $paymentId\nOrder Id: $orderId  ",
          toastPosition: EasyLoadingToastPosition.bottom);

      // // Updating premium status in Firebase and restarting the app
      // await FirebaseManageRecurring().updateMorePets(gSignClientId:gSignClientId,subscriptionDate:subscriptionDate,subscriptionPlanCategory:subscriptionPlanCategory,subscriptionExpireDate:subscriptionExpireDate,petCount:petCount, orderId: orderId, paymentId: paymentId,price:price).then((value) {
      //
      //   FirebaseManageRecurring().updateMorePetsCollection(gSignClientId:gSignClientId,phone:phone,email:email,name:name,subscriptionDate:subscriptionDate,subscriptionPlanCategory:subscriptionPlanCategory,subscriptionExpireDate:subscriptionExpireDate,petCount:petCount,orderId:orderId,paymentId:paymentId,price:price).then((value) {
      //


        // });





      // });
      // // You can delay the navigation if you wish
      // Util().navigate(mainContext);


    }, (error) {
      EasyLoading.showToast("Payment Failed",
          toastPosition: EasyLoadingToastPosition.bottom);
    }, () {
      EasyLoading.showToast("Payment Dismissed",
          toastPosition: EasyLoadingToastPosition.bottom);
    });

  }


}