import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:shimmer/shimmer.dart';

import '../data/constant.dart';
import '../model/reward_product.dart';
import '../utils/theme/theme.dart';

class HomeReward extends StatefulWidget {
  const HomeReward({Key? key}) : super(key: key);

  @override
  State<HomeReward> createState() => _HomeRewardState();
}

class _HomeRewardState extends State<HomeReward> {
  late HomeController _homeController;
  bool hasData = false;

  @override
  void initState() {
    _homeController = Get.find();
    if (_homeController.widgetInput.containsKey("rewardwidget")) {
      hasData = true;
    } else {
      refreshPage();
    }

    super.initState();
  }

  void refreshPage() => Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          hasData = true;
        });
      });

  @override
  Widget build(BuildContext context) {
    debugPrint("*****HasData: $hasData");
    _homeController.widgetInput.putIfAbsent("rewardwidget", () => null);
    if (hasData) {
      final rewardProductList = _homeController.rewardProductList;
      if (_homeController.rewardProductList.isNotEmpty) {
        return Container(
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 0.2,
                //spreadRadius: 1.0,
                offset: Offset(0.2, 0.2), // shadow direction: bottom right
              )
            ],
          ),
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              //See All
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: homeIndicatorColor,
                      width: 5,
                    ),
                  ),
                ),
                child: Row(children: [
                  const SizedBox(width: 5),
                  Expanded(
                      child: Text(
                    "ဆုလာဘ်များ",
                    style: textStyleBold,
                  )),
                  Text("ထပ်ကြည့်ရန်", style: textStyleGrey),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(rewardProducts);
                      //TODO:GO TO ALL PAGE
                      ///  Get.to(SeeAllScreen(itemList: controller.pickUp()));
                    },
                    icon: Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      color: homeIndicatorColor,
                    ),
                  )
                ]),
              ),
              //New Products
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(right: 20, top: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: rewardProductList.length,
                    itemBuilder: (_, i) {
                      final item = rewardProductList[i];
                      return GestureDetector(
                        onTap: () {
                          //controller.setSelectedItem(controller.pickUp()[i]);
                          //Get.toNamed(detailScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(),
                            child: Container(
                              //height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.2,
                                    //spreadRadius: 1.0,
                                    offset: Offset(0.2,
                                        0.2), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: item
                                          .image, //controller.getItems()[i].photo,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: item.image,
                                          // imageUrl: controller
                                          //     .getItems()[i]
                                          //     .photo,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      item.name, //controller.getItems()[i].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Price
                                          Text(
                                            "${item.requirePoint} points",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Obx(() {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  side: BorderSide(
                                                    color: (_homeController
                                                                .currentUser
                                                                .value ==
                                                            null)
                                                        ? Colors.black
                                                        : homeIndicatorColor,
                                                  ))),
                                          onPressed: () {
                                            if(_homeController.currentUser.value!.status! < 0){
                                                Get.toNamed(loginScreen);
                                                return;
                                              } else {
                                              debugPrint(
                                                  "*****Add to cart reward product**");

                                              _homeController.addToRewardCart(
                                                  item, i);
                                            }
                                          },
                                          child: (_homeController
                                                      .currentUser.value ==
                                                  null)
                                              ? Text("sign in to access",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ))
                                              : Text(
                                                  _homeController
                                                              .rewardProductList[
                                                                  i]
                                                              .count! ==
                                                          0
                                                      ? "Add to cart"
                                                      : "Added",
                                                  style: TextStyle(
                                                    color: homeIndicatorColor,
                                                  )),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    }
    return ShimmerRewardWidget();
  }
}

class ShimmerRewardWidget extends StatelessWidget {
  const ShimmerRewardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 0.2,
              //spreadRadius: 1.0,
              offset: Offset(0.2, 0.2), // shadow direction: bottom right
            )
          ],
        ),
        width: double.infinity,
        height: 230,
        child: Column(
          children: [
            //See All
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    //color: Colors.white,
                    width: 5,
                  ),
                ),
              ),
              child: Row(children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    height: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  height: 25,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ]),
            ),
            //New Products
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(right: 20, top: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Container(
                            //height: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.all(Radius.circular(20)),
                              //color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 0.2,
                                  //spreadRadius: 1.0,
                                  offset: Offset(0.2,
                                      0.2), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.white),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    height: 25,
                                    color: Colors.white,
                                    width: 100,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    height: 25,
                                    color: Colors.white,
                                    width: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}
