import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/service/api.dart';

import '../../../../data/enum.dart';

class EnrollmentController extends GetxController{
  final HomeController _controller = Get.find();
  var selectedPaymentMethod = PaymentOptions.PrePay.obs;

  void setPaymentMethod(PaymentOptions value) => selectedPaymentMethod.value = value;
  Future<void> confirmEnrollment({
    required String collection,
   required String resourceId,
   required String userId,
   required int cost,
  }) async{
    FirebaseFirestore.instance
    .collection(collection)
    .doc(resourceId)
    .update({
      'isConfirmed': true,
    }).then((value) async{//Then we need to increase,enrolled user's point
      FirebaseFirestore.instance.runTransaction((transaction)async{
        final secureSnapshot = await FirebaseFirestore.instance
        .collection(normalUserCollection).doc(userId).get();
        final previousPoint = secureSnapshot.get("points") as int;
        transaction.update(secureSnapshot.reference, {
          "points": previousPoint + (cost/1000).round(),
          });
      });
      await Api.sendPushToUser(
        "သင်တန်းလက်ခံခြင်း", "You get ${(cost/20).round()} points",
        userId);
    });
  }
}