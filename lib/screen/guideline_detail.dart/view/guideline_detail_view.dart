import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widget/widget.dart';
import '../controller/guideline_detial_controller.dart';

class GuideLineDetailView extends StatelessWidget {
  const GuideLineDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GuideLineDetailController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
     appBar: appBar(title: "လမ်းညွှန်ချက်များ"),
     body: Obx((){
      if(_controller.isLoading.value){
        return const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
        ),);
      }
      if (_controller.guideLineItemList.isEmpty) {
          return const Center(
              child: Text(
            "No guideline items yet....",
          ));
        }
      return GridView.builder(
          itemCount: _controller.guideLineItemList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
          itemBuilder: (context,index){
            final item =_controller.guideLineItemList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Get.dialog(
                  
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body:  Container(
                          child: Center(
                            child: Container(
                          height: 200,
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Image
                              Expanded(
                                child: CachedNetworkImage(imageUrl: item.image,),
                              ),
                              Text(item.desc,style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                                      ),
                          ),
                       
                    ),
                  ),
                useSafeArea: false,
                barrierColor: Colors.white.withOpacity(0.5),
                ),
                splashColor: Colors.grey,
                child: Container(
                  height: size.height*0.2,
                  width: size.width*0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Image
                      Expanded(
                        child: CachedNetworkImage(imageUrl: item.image,),
                      ),
                      Text(item.desc,style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
          );
     }),
    );
  }
}