import 'package:cached_network_image/cached_network_image.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/utils/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: appBarColor,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("YANGON DRIVING SCHOOL",

                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    wordSpacing: 2,
                    letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),
            //User Profile Image
            Obx(() {
              return CachedNetworkImage(
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: imageProvider,
                  );
                },
                progressIndicatorBuilder: (context, url, status) {
                  return Shimmer.fromColors(
                    child: Container(
                      color: Colors.white,
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  );
                },
                errorWidget: (context, url, whatever) {
                  return const Text("Image not available");
                },
                imageUrl: _homeController.currentUser.value?.image ?? userImage,
                //fit: BoxFit.fill,
              );
            }),

            const SizedBox(height: 5),
            //Point
            Container(
              height: 50,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Point Text
                  Obx(() {
                    return Text(
                      "${_homeController.currentUser.value?.points}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: homeIndicatorColor,
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  //Icon
                  Icon(
                    FontAwesomeIcons.coins,
                    color: Colours.goldenRod,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //User Name
            Obx(() {
              return Text(
                        _homeController.currentUser.value?.userName.toUpperCase() ?? "",
                        style: textStyleBold.copyWith(
                          fontSize: 16,
                ),
              );
            }),
            const SizedBox(height: 20),
            //User Email
            Obx(() {
              return Text(
                        _homeController.currentUser.value?.emailAddress ?? "",
                        style: textStyleBold.copyWith(
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
              );
            }),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    _homeController.logOut();
                  },
                  child: Text("Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.white,
                      ))),
            ),
            //Delete

                SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    _homeController.deleteAccount();
                  },
                  child: Text("Delete Account",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                  ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
