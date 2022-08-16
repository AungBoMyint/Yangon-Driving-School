import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/purchase_item.dart';
import 'package:uuid/uuid.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../model/purchase.dart';
import 'api.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> watch(String collectionPath) =>
      _firebaseFirestore.collection(collectionPath).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> watchWithDateTime(String collectionPath) =>
      _firebaseFirestore.collection(collectionPath)
      .orderBy('dateTime', descending: true).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> watchOrder(
          String collectionPath) =>
      _firebaseFirestore
          .collection(collectionPath)
          .orderBy('dateTime', descending: true)
          .snapshots();

  Future<DocumentSnapshot<Map<String, dynamic>>> read(
    String collectionPath, {
    String? path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).get();

       Future<QuerySnapshot<Map<String, dynamic>>> readCollection(
    String collectionPath, {
    String? path,
  }) =>
      _firebaseFirestore.collection(collectionPath).get();

      Future<QuerySnapshot<Map<String, dynamic>>> readCollectionFilter(
    String collectionPath, {
    String? path,
    required String filterID,
  }) =>
      _firebaseFirestore.collection(collectionPath)
      .where('parentId', isEqualTo: filterID)
      .orderBy("dateTime")
      .get();

      Future<QuerySnapshot<Map<String, dynamic>>> readSubCollection({
    required String mainCollectionPath, 
    required String mainPath,
    required String subCollectionPath,
  }) =>
      _firebaseFirestore.collection(mainCollectionPath)
      .doc(mainPath).collection(subCollectionPath).get();


  Future<void> write(
    String collectionPath, {
    String? path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).set(data);

      Future<void> writeSubCollection({
    required String mainCollection, 
    required String mainPath,
    required String subCollection,
     required String subPath,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(mainCollection).doc(mainPath)
      .collection(subCollection).doc(subPath).set(data);

  //Write PurchaseData
  Future<void> writePurchaseData(PurchaseModel model) async {
    if (!(model.bankSlipImage == null)) {
      final file = File(model.bankSlipImage!);
      debugPrint("**************${model.bankSlipImage!}");
      try {
        await _firebaseStorage
            .ref()
            .child("bankSlip/${Uuid().v1()}")
            .putFile(file)
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final purchaseModel = model.copyWith(bankSlipImage: value).toJson();
            //Then we set this user into Firestore
            await _firebaseFirestore
                .collection(purchaseCollection)
                .doc()
                .set(purchaseModel)
                .then((value) async {
              
              if (!(model.rewardProductList == null)) {
                int totalPoints = 0;
                for (var item in model.rewardProductList!) {
                  totalPoints += item.requirePoint * item.count!;
                }
                try {
                  await reduceCurrentUserPoint(totalPoints);
                } catch (e) {
                  debugPrint("*****ReduceFailed: $e");
                }
              }
              Api.sendPushToAdmin(
                    "အော်ဒါတင်ခြင်း",
                    "🧑အမည်:${model.name}\n"
                        "🏠လိပ်စာ: ${model.address}\n"
                        "✍အီးမေးလ်: ${model.email}");
                 });
            }); 
        });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    } else {
      try {
        await _firebaseFirestore
            .collection(purchaseCollection)
            .doc()
            .set(model.toJson())
            .then((value) async {
          
          if (!(model.rewardProductList == null)) {
            int totalPoints = 0;
            for (var item in model.rewardProductList!) {
              totalPoints += item.requirePoint * item.count!;
            }
            try {
              await reduceCurrentUserPoint(totalPoints);
            } catch (e) {
              debugPrint("*****ReduceFailed: $e");
            }
            Api.sendPushToAdmin(
                    "အော်ဒါတင်ခြင်း",
                    "🧑အမည်:${model.name}\n"
                        "🏠လိပ်စာ: ${model.address}\n"
                        "✍အီးမေးလ်: ${model.email}");
          }
        });
      } catch (e) {
        debugPrint("****************PurchseSubmitError $e*************");
      }
    }
  }

  Future<void> update(
    String collectionPath, {
    required String path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).update(data);

  Future<void> delete(
    String collectionPath, {
    required String path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).delete();

    

  //Give Point Depend on Order Product Count
  Future<void> increaseCurrentUserPoint(int increasePoint) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(_firebaseFirestore
            .collection(normalUserCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;

        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint + increasePoint,
          },
        );
      },
    );
  }

  //Reduce Point Depend on Order Product Count
  Future<void> reduceCurrentUserPoint(int reducePoint) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(_firebaseFirestore
            .collection(normalUserCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;

        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint - reducePoint,
          },
        );
      },
    );
  }

  /**BELOW ARE FUNCTIONS FOR POS USER*/
  //Subtract Remain Product
  Future<void> updateRemainQuantity(PurchaseItem product) async {
    //debugPrint("******${product.snapshot}*****");
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(
          _firebaseFirestore.collection(productCollection).doc(product.id));

      final int remainQuan = secureSnapshot.get("remainQuantity") as int;

      transaction.update(secureSnapshot.reference, {
        "remainQuantity": remainQuan - product.count,
      });
    });
    log("*****Success Update Remain Quantity****");
  }

  //Update TotalOrder and TotalPrice in today Map
  Future<void> updateTotalForDaily(PurchaseItem product) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firebaseFirestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));

      try {
        final map = secureSnapshot.get("dateTime") as Map<String, dynamic>;
        final todayMap = map[dailyMapKey] as Map<String, dynamic>;
        final int totalOrder = todayMap["totalOrder"];
        final int totalPrice = todayMap["totalRevenue"];
        final int totalOriginalPrice = todayMap["originalTotalRevenue"];
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "totalOrder": totalOrder + 1,
                  "totalRevenue": totalPrice + product.price * product.count,
                  "originalTotalRevenue": totalOriginalPrice +
                      _controller.getItem(product.id).originalPrice *
                          product.count,
                },
              },
            },
            SetOptions(merge: true));
        log("*****Success Update Total For Today****");
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "totalOrder": 1,
                  "totalRevenue": product.price * product.count,
                  "originalTotalRevenue":
                      _controller.getItem(product.id).originalPrice *
                          product.count,
                }
              },
            },
            SetOptions(merge: true));
      }
    });
  }

  //Update TotalOrder and TotalPrice in today Map
  Future<void> updateTotalForMonthly(PurchaseItem product) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firebaseFirestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));
      debugPrint("*******Monthly:$secureSnapshot****");

      try {
        final int totalOrder = secureSnapshot.get("totalOrder");
        final int totalPrice = secureSnapshot.get("totalRevenue");
        final int totalOriginalPrice =
            secureSnapshot.get("originalTotalRevenue");
        transaction.set(
            secureSnapshot.reference,
            {
              "totalOrder": totalOrder + 1,
              "totalRevenue": totalPrice + product.price * product.count,
              "originalTotalRevenue": totalOriginalPrice +
                  _controller.getItem(product.id).originalPrice * product.count,
              "dateTimeMonth": DateTime.now(),
            },
            SetOptions(merge: true));
        log("*****Success Update Total For Monthly****");
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "totalOrder": 1,
              "totalRevenue": product.price * product.count,
              "originalTotalRevenue":
                  _controller.getItem(product.id).originalPrice * product.count,
              "dateTimeMonth": DateTime.now(),
            },
            SetOptions(merge: true));
      }
    });
  }

  //FOR EXPEND ************************ //
  //Update Expend in today Map
  Future<void> updateExpendForDaily(int cost) async {
    HomeController _controller = Get.find();
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firebaseFirestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));

      try {
        final map = secureSnapshot.get("dateTime") as Map<String, dynamic>;
        final todayMap = map[dailyMapKey] as Map<String, dynamic>;
        final int totalExpend = todayMap["expend"];
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "expend": totalExpend + cost,
                },
              },
            },
            SetOptions(merge: true));
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "dateTime": {
                dailyMapKey: {
                  "expend": cost,
                }
              },
            },
            SetOptions(merge: true));
      }
    });
  }

  //Update Expend in today Map
  Future<void> updateExpendForMonthly(int cost) async {
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction.get(_firebaseFirestore
          .collection("${DateTime.now().year}Collection")
          .doc("${DateTime.now().year},${DateTime.now().month}"));
      debugPrint("*******Monthly:$secureSnapshot****");

      try {
        final int totalExpend = secureSnapshot.get("expend");
        transaction.set(
            secureSnapshot.reference,
            {
              "expend": totalExpend + cost,
            },
            SetOptions(merge: true));
      } catch (e) {
        debugPrint("*********Error get totalOrder and Price $e**");
        transaction.set(
            secureSnapshot.reference,
            {
              "expend": cost,
            },
            SetOptions(merge: true));
      }
    });
  }
}
