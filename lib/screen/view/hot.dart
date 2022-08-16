import 'package:cached_network_image/cached_network_image.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../routes/routes.dart';

class HotView extends StatelessWidget {
  const HotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Obx(
          () => ListView.builder(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        itemCount: controller.hot().length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            controller.setSelectedItem(controller.hot()[i]);
            Get.toNamed(detailScreen);
          },

          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.hot()[i].name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            Icons.star,
                            size: 18,
                            color: index <= controller.getItems()[i].star
                                ? Colours.gold
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.hot()[i].price}  Ks",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${((controller.hot()[i].price)*(20/100)).round() + controller.hot()[i].price}   Ks",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                    ],
                  ),

                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: controller.hot()[i].photo,
                    // "$baseUrl$itemUrl${controller.hot()[i].photo}/get",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}