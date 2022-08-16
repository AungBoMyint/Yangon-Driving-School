import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/user_history/controller/user_history_controller.dart';
import 'package:hammies_user/screen/user_history/detail/cfh_detail.dart';
import 'package:hammies_user/screen/user_history/detail/clh_detail.dart';
import 'package:hammies_user/screen/user_history/detail/dlh_detail.dart';
import 'package:hammies_user/screen/user_history/detail/pm_detail.dart';

import '../../../data/constant.dart';
import '../../../utils/utils.dart';

class UserHistoryView extends StatelessWidget {
  const UserHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHistoryController _controller = Get.find();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: appBarColor,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0,
              title: Text("လုပ်ဆောင်မှု မှတ်တမ်း",
                        style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Colors.black,
                            fontSize: 16,),
                      ),
                      bottom: TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        labelStyle: TextStyle(fontSize: 12),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: "သင်တန်း",
                          ),
                          Tab(
                            text: "ကားလိုင်စင်",
                          ),
                          Tab(
                            text: "ယာဥ်မောင်းလိုင်စင်",
                          ),
                          Tab(
                            text: "ဆုလာဘ်",
                          ),
                        ],
                        ),
        ),
         body: TabBarView(
          children: [
            //Course
            CourseFormList(),
            //CarLicence
            CarLicenceFormList(),
            //DrivingLicence
            DrivingLicenceFormList(),
            //Reward Product Orders
            RewardProductOrders(),
          ],
        ),
      ),
    );
  }
}

class CourseFormList extends StatelessWidget {
  const CourseFormList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHistoryController _controller = Get.find();
    return Obx((){
      if(_controller.isCourseLoading.value){
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if(_controller.courseFormList.isEmpty){
        return const Center(child: Text("No Courses yet!."),);
      }
      return ListView.builder(
        itemCount: _controller.courseFormList.length,
        itemBuilder: (context,index){
          final course = _controller.courseFormList[index];
          return Card(
            child: ListTile(
              onTap: () => Get.to(() => CFHDetail(courseForm: course)),
              title: Text(
                "သင်တန်းအမျိုးအစား => ${course.courseType}",
              ),
              subtitle: Text(
                "စတက်သည့်ရက် => ${getDate(course.initialDay)}"
              ),
              trailing: Text(
                "${getDate(course.dateTime)}"
              ),
            ),
          );
        },
      );
    });
  }
}

class CarLicenceFormList extends StatelessWidget {
  const CarLicenceFormList ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHistoryController _controller = Get.find();
    return Obx((){
      if(_controller.isCarLoading.value){
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if(_controller.carLicenceFormList.isEmpty){
        return const Center(child: Text("No car licence yet!."),);
      }
      return ListView.builder(
        itemCount: _controller.carLicenceFormList.length,
        itemBuilder: (context,index){
          final course = _controller.carLicenceFormList[index];
          return Card(
            child: ListTile(
              onTap: () => Get.to(() => CLHDetail(carLicenceForm: course)),
              title: Text(
                "ကားအင်ဂျင်ပါဝါ => ${course.enginPowerType}",
              ),
              trailing: Text(
                "${getDate(course.dateTime)}"
              ),
            ),
          );
        },
      );
    });
  }
}

class DrivingLicenceFormList extends StatelessWidget {
  const DrivingLicenceFormList ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHistoryController _controller = Get.find();
    return Obx((){
      if(_controller.isDrivingLoading.value){
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if(_controller.drivingLicenceFormList.isEmpty){
        return const Center(child: Text("No driving licence yet!."),);
      }
      return Obx(
         () {
          return ListView.builder(
            itemCount: _controller.drivingLicenceFormList.length,
            itemBuilder: (context,index){
              final course = _controller.drivingLicenceFormList[index];
              return Card(
                child: ListTile(
                  onTap: () => Get.to(() => DLHDetail(drivingLicenceForm: course)),
                  title: Text(
                    "လိုင်စင် => ${course.licenceType}",
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                  subtitle: Text(
                    "ဝန်ဆောင်မှု => ${course.serviceType}",
                  ),
                  trailing: Text(
                    "${getDate(course.dateTime)}"
                  ),
                ),
              );
            },
          );
        }
      );
    });
  }
}

class RewardProductOrders extends StatelessWidget {
  const RewardProductOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserHistoryController _controller = Get.find();
    return Obx((){
      if(_controller.isPurchaseLoading.value){
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
      if(_controller.purchaseModelList.isEmpty){
        return const Center(child: Text("No order yet!."),);
      }
      return Obx(
         () {
          return ListView.builder(
            itemCount: _controller.purchaseModelList.length,
            itemBuilder: (context,index){
              final course = _controller.purchaseModelList[index];
              return Card(
                child: ListTile(
                  onTap: () => Get.to(() => PurchaseModelDetail(purchaseModel: course)),
                  title: Text(
                    "Delivery Fees => ${course.deliveryTownshipInfo[0]}",
                  ),
                 
                  trailing: Text(
                    "${getDate(DateTime.parse(course.dateTime))}"
                  ),
                ),
              );
            },
          );
        }
      );
    });
  }
}