import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/item.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/home_controller.dart';
import 'package:getwidget/getwidget.dart';

import '../routes/routes.dart';

class HomePickUp extends StatelessWidget {
  const HomePickUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final List<ItemModel> slideList = controller.pickUp();
    return slideList.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,
              bottom: 10,
            ),
            child: GFCarousel(
              aspectRatio: 16 / 9,
              autoPlay: true,
              viewportFraction: 1.0,
              hasPagination: true,
              activeIndicator: Colors.black,
              passiveIndicator: Colors.grey,
              autoPlayInterval: const Duration(seconds: 6),
              items: slideList.map((produt) {
                return InkWell(
                  onTap: () {
                    controller.setSelectedItem(produt);
                    Get.toNamed(detailScreen);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
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
                      imageUrl: produt.photo,
                      fit: BoxFit.fill,
                    ),

                    //name
                  ),
                );
              }).toList(),
            ),
          );
  }
}
