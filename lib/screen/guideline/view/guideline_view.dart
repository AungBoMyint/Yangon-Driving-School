import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/widget/widget.dart';
import '../../../controller/home_controller.dart';
import '../controller/guideline_controller.dart';

class GuideLineView extends StatelessWidget {
  const GuideLineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GuideLineController _controller = Get.find();
    final HomeController _homeController = Get.find();
    return Scaffold(
      appBar: appBar(title: "လမ်းညွှန်ချက်များ"),
      body: Obx(
         () {
          if(_controller.isLoading.value){
        return const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
        ),);
      }
      if (_controller.guideLineCategoriesList.isEmpty) {
          return const Center(
              child: Text(
            "No guideline items yet....",
          ));
        }
          return ListView.builder(
            itemCount: _controller.guideLineCategoriesList.length,
            itemBuilder: (context,index){
              final guide = _controller.guideLineCategoriesList[index];
              return Card(
                color: HexColor(guide.color),
                child: ListTile(
                  onTap: () {
                    _homeController.setParentGuideLineID(guide.id);
                    Get.toNamed(guideLineDetailScreen);
                  },
                  leading: CachedNetworkImage(
                  imageUrl: guide.image,
                  width: 50,
                  height: 50,
                  ),
                  title: Text(guide.title,style: TextStyle(color: Colors.white,)),
                ),
                );
            },
            );
        }
      ),
    );
  }
}