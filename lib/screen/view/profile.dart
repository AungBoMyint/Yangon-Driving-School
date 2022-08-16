import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/routes/routes.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return _LoginUser();
  }
}

class _LoginUser extends StatelessWidget {
  const _LoginUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 20),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        _controller.currentUser.value!.image,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  //   ),
                  // ),
                  Obx(
                    () => Text(
                      _controller.currentUser.value?.emailAddress ?? '',//-Email Address Will be Phone Number beacause
                      //--I didn't change it,TODO: need to change emailAddress to phone number
                      //--instance variable of AuthUser Object
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  //-----Point For Admin To Test On Their Own----//
                  Obx(
                    () => Text(
                      "My Reward : ${_controller.currentUser.value?.points ?? 0} Points",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          (_controller.currentUser.value!.status! > 0) ? 
          _AdminPanel() : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Center(
              child: GestureDetector(
                onTap: _controller.logout,
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    color: homeIndicatorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),


              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  _controller.deleteAccount();
                },
                child: Text("Delete Account",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2,
                      wordSpacing: 2,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),
    );
  }
}

class _AdminPanel extends StatelessWidget {
  const _AdminPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
          child: Text(
            "Admin Features",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.changeCat("");
            Get.toNamed(uploadItemScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upload Reward or Advertisement"),
                    Icon(Icons.upload),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(mangeItemScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Reward or Advertisement"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
           Get.toNamed(questionFormScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Questions"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
           Get.toNamed(guideLineManagementScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage GuideLine Categories"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
           Get.toNamed(guideLineItemManagementScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage GuideLine Items"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Get.toNamed(categoriesUrl);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Categories"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(coursePriceScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Course Price"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ),
         GestureDetector(
          onTap: () {
           Get.toNamed(drivingLicenceManagementScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Driving Licence Price"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ), 
        GestureDetector(
          onTap: () {
           Get.toNamed(carLicenceManagementScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manage Car Licence Price"),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
          ),
        ), 
        GestureDetector(
          onTap: () {
           Get.toNamed(enrollmentScreen);
          },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Enrollment Data  🎁"),
                    CircleAvatar(
                        backgroundColor: Colors.orange,
                        minRadius: 20,
                        maxRadius: 20,
                        child: Text(
                          "${controller.enrollList.length + controller.carLicenceFormList.length + controller.drivingLicenceFormList.length
                          + controller.purchaseModelList.length}",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
