import 'package:flutter/material.dart';

const Color scaffoldBackground = Colors.white;
const Color appBarColor = Colors.white;
const Color appBarTitleColor = Color.fromRGBO(19, 19, 19, 1);
const Color homeIndicatorColor = Colors.grey;
const Color detailBackgroundColor = Colors.white;
const Color detailTextBackgroundColor = Colors.white;
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.grey),
);

const String baseUrl = 'http://192.168.1.5:5000/api/v1/streaming/movie/';
const String profileUrl = 'profile/';
const String itemUrl = 'item/';
const rewardProductCollection = "rewardProducts";

const String userCollection = 'users';
const String profileCollection = 'profiles';
const productCollection = "products";
const String purchaseCollection = 'purchases';
const String brandCollection = 'brandProducts';
const String normalUserCollection = "normalUsers";
const String courseFormCollection = "courseFormCollection";
const String drivingLicenceCollection = "drivingLicenceCollection";
const String carLicenceCollection = "carLiecnceCollection";
const String mainQuestionCollection = "mainQuestions";
const String subQuestionCollection = "subQuestions";
const String coursePriceCollection = "coursePrices";
const String drivingLicenceCostCollection = "drivingLicenceCost";
const String carLicenceCostCollection = "carLicenceCost";
const String guideLineCategoryCollection = "guideLineCategories";
const String guideLineItemCollection = "guideLineItems";

const String userImage =
    "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png";
/*const List<String> priceList = [
  '၁ ထည် လက်လီ ဈေးနှုန်း',
  'လက်ကား ဈေးနှုန်း',
];*/

final dailyMapKey = DateTime.now().toString().split(" ").first;

const String boxName = "favouriteBOX";
const String purchaseBox = "purchasesBoxs";
const String fcmKey =
    "AAAAgv34qSI:APA91bF0z7u_cGAly6z8BYvbh_BfIn8FE-yLA_aHsgWkAJUoN3ZiH54q0DOLhdJmjlBgawF9mwJeIV89MC5tkBLdOF7yEzmU2_hiyTsfsu8KsCIBcJaokhIG3IyzdC6RLXYWczoNNpwX";


