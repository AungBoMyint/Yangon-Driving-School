import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/hive_reward_product.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/home_controller.dart';
import 'data/constant.dart';
import 'model/hive_item.dart';
import 'model/hive_purchase.dart';
import 'model/hive_purchase_item.dart';
import 'routes/routes.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<HiveItem>(HiveItemAdapter());
  Hive.registerAdapter<HivePurchase>(HivePurchaseAdapter());
  
  Hive.registerAdapter<HivePurchaseItem>(HivePurchaseItemAdapter());
  Hive.registerAdapter<HiveRewardProduct>(HiveRewardProductAdapter());
  await Hive.openBox<HiveItem>(boxName);
  await Hive.openBox<HivePurchase>(purchaseBox);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      initialRoute: introScreen,
      getPages: routes,
    );
  }
}
