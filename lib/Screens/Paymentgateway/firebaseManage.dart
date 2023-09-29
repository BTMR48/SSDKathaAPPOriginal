import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseManage {
  Future<void> subcriptionSuccessSave(
      {required String gSignClientId,
      required DateTime subscriptionDate,
      required String subscriptionPlanCategory,
      required DateTime subscriptionExpireDate,
      required String orderId,
      required String paymentId,
      required int price}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(gSignClientId)
        .collection('subscription')
        .doc(gSignClientId)
        .set({
      'price': price,
      'subscriptionPlanCategory': subscriptionPlanCategory,
      'subscriptionDate': subscriptionDate,
      'subscriptionExpireDate': subscriptionExpireDate,
      'paymentId': paymentId,
      'orderId': orderId,
      'subscription_id': ''
    });
  }
}
