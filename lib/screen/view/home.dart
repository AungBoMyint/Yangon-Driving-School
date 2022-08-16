import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/widgets/home_reward.dart';
import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../routes/routes.dart';
import '../../ui/driving_courses/booking.dart';
import '../question5/view/tab_bar.dart';
import '../../utils/widget/widget.dart';
import '../../widgets/home_category.dart';
import '../../widgets/home_items.dart';
import '../../widgets/home_pickup.dart';
import '../ydslearning.dart';
import 'hot.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [

                Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.coins,
                                  color: Colours.yellow,
                                  size: 20,
                                ),
                                SizedBox(width: 15),

                                Text(
                                  "${_homeController.currentUser.value?.points}""  Points",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            Text(
                              '1 Point = 1 Kyat (MMK)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          'Level - 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),

                        Expanded(
                          child: Column(
                            children: [
                        
                        
                              InkWell(
                                onTap: () {
                                  if (controller.currentUser.value == null) {
                                    controller.signInWithGoogle(userProfileUrl);
                                  } else {
                                    Get.toNamed(userProfileUrl);
                                  }
                                },
                                child: Obx(() {
                                  return circularNetworkImage(
                                    controller.currentUser.value?.image ?? userImage,
                                    20,
                                  );
                                }),
                              ),
                        
                              SizedBox(height: 5),
                        
                              Text(
                                _homeController.currentUser.value?.userName.toUpperCase() ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                ),
                              ),
                        
                        
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                ClassTypeWidgets(),
              ],
            ),
            HomePickUp(),
            HomeReward(),
            const SizedBox(
              height: 10,
            ),
            // HomeCategory(),
            // HomeItems(),
          ],
        ),
      ),
    );


  }

}

class ClassTypeWidgets extends StatelessWidget {
  const ClassTypeWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: ()=> Get.toNamed(courseFormScreen),
                        child: Image.asset(
                          'assets/dc.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('သင်တန်း \nအပ်ရန်',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(serviceFormScreen);
                        },
                        child: Image.asset(
                          'assets/dl.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('ယာဉ်မောင်းလိုင်စင်\nဝန်ဆောင်မှု',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(carLicenceFormScreen);
                        },
                        child: Image.asset(
                          'assets/cl.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('ကားလိုင်စင်\nဝန်ဆောင်မှု',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: ()=> Get.toNamed(userProfileUrl),
                        child: Image.asset(
                          'assets/o.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('ကျွန်ုပ်၏\nအချက်အလက်',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
            
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(questionTabScreen);
                        },
                        child: Image.asset(
                          'assets/qa.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('မေးခွန်း\n(၅)စုံ',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
            
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.toNamed(guideLineScreen),
                        child: Image.asset(
                          'assets/sb.png',
                          width: 80.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('လမ်းညွှန်\nအမှတ်အသားများ',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,MaterialPageRoute(builder: (context) => Vlog()),);
                        },
                        child: Image.asset(
                          'assets/vl.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('ဗီဒီယို\nသင်ခန်းစာများ',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.toNamed(userHistoryScreen),
                        child: Image.asset(
                          'assets/r.png',
                          width: 55.0,
                          height: 55.0,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
            
                          shape: CircleBorder(), //<-- SEE HERE
                        ),
                      ),
            
                      Text('လုပ်ဆောင်မှု\nမှတ်တမ်း',
                        textAlign: TextAlign.center,
                      ),
            
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

