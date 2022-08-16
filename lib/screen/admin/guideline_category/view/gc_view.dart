import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/guideline_category/controller/gc_controller.dart';
import 'package:hammies_user/utils/widget/widget.dart';
import 'package:hexcolor/hexcolor.dart';

import 'gc_management.dart';


class GCView extends StatefulWidget {
  const GCView({Key? key}) : super(key: key);

  @override
  State<GCView> createState() => _GCViewState();
}

class _GCViewState extends State<GCView> {
  @override
  Widget build(BuildContext context) {
    final GCController _controller = Get.find();
    return Scaffold(
      appBar: appBar(title: "လမ်းညွှန်ချက်အမျိုးအစားများ"),
      body:   
                     Obx(
                        () {
                          if(_controller.isLoading.value){
                            return const Center(
                              child:  SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (_controller.guideLineCategories.isEmpty) {
                            return const Center(
                                child: Text(
                              "No guide categories yet....",
                            ));
                          }
                        
                          return  ListView.builder(
                             
                              itemCount: _controller.guideLineCategories.length,
                              itemBuilder: (context, index) {
                                var cate = _controller.guideLineCategories[index];
                        
                                return SizedBox(
                                  height: 180,
                                  child: Card(
                                      color: HexColor(cate.color),
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  //Title
                                                  Text(cate.title,style: TextStyle(color: Colors.white,fontSize: 16,),
                                                  maxLines: 2,),
                                                  const SizedBox(height: 10),
                                                  //Image
                                                  Expanded(
                                                    child: CachedNetworkImage(
                                                      imageUrl: cate.image,
                                                      width: 85,
                                                      ),
                                                  ),
                                                ],
                                              )
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                 _controller.deleteGC(cate.id);
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                );
                              },
                            );
                        },
                      ),
                      floatingActionButton: InkWell(
          onTap: (){
            Get.to(() => GCManagement());
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
                  );
  }
}

