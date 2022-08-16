import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/view/cart.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../routes/routes.dart';

class RewardProductSeeAll extends StatelessWidget {
  const RewardProductSeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "ဆုလာဘ်များ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: StaggeredGridView.countBuilder(
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemCount: controller.rewardProductList.length,
            itemBuilder: (_, i) {
              final item = controller.rewardProductList[i];
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: Container(
                    //height: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                          spreadRadius: 0.1,
                          offset:
                              Offset(1, 1), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: item.image, //controller.getItems()[i].photo,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        side: BorderSide(
                                          color:
                                              (controller.currentUser.value ==
                                                      null)
                                                  ? Colors.black
                                                  : homeIndicatorColor,
                                        ))),
                                onPressed: () {
                                  if (controller.currentUser.value == null) {
                                    controller.signInWithGoogle(homeScreen);
                                  } else {
                                    debugPrint(
                                        "*****Add to cart reward product**");

                                    controller.addToRewardCart(item, i);
                                  }
                                },
                                child: (controller.currentUser.value == null)
                                    ? Text("sign in to access",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))
                                    : Text(
                                        controller.rewardProductList[i]
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
              );
            }),
      ),
    );
  }
}
