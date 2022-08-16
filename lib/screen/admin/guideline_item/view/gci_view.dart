import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/guideline_item/controller/gci_controller.dart';
import 'package:hammies_user/screen/admin/guideline_item/view/gci_management.dart';

import '../../../../utils/widget/widget.dart';

class GCIView extends StatelessWidget {
  const GCIView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GCIController _controller = Get.find();
    return Scaffold(
      appBar: appBar(title: "လမ်းညွှန်ချက်များ"),
      body: Column(
        children: [
          //Title
           Obx(
              () {
                return Wrap(
                  children: _controller.guideLineCategories.map((element){
                                        final isSelected = _controller.selectedCategory.value == element.id;

                    return 
                         Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isSelected ? Colors.black: Colors.white,
                            ),
                            onPressed: () => _controller.setSelectedCategory(element.id), 
                            child: Expanded(
                              child: Text(
                                element.title,
                                style: TextStyle(color: isSelected ? Colors.white: Colors.black,),
                              ),
                            ),
                            ),
                        )
                        ;
                  }).toList(),
                );
              }
          
          ),
          //Items
          Expanded(
            child: Obx((){
             if(_controller.isLoading.value){
                            return const Center(
                              child:  SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (_controller.guideLineItems.isEmpty) {
                            return const Center(
                                child: Text(
                              "No guide categoriey items yet....",
                            ));
                          }
                        
                          return  ListView.builder(
                             
                              itemCount: _controller.guideLineItems.length,
                              itemBuilder: (context, index) {
                                var cate = _controller.guideLineItems[index];
                                return Obx((){
                                 if(_controller.selectedCategory.value != cate.parentId){
                                  return SizedBox();
                                }
                                return SizedBox(
                                  height: 180,
                                  child: Card(
                                
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  //Title
                                                  Text(cate.desc,style: TextStyle(color: Colors.black,fontSize: 16,),
                                                  maxLines: 2,),
                                                  const SizedBox(height: 10),
                                                  //Image
                                                   CachedNetworkImage(
                                                      imageUrl: cate.image,
                                                      width: 85,
                                                      height: 50,
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
                                                  color: Colors.red,
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
                                });
                              },
                            );
            }),
          ),
        ],
      ),
      floatingActionButton: InkWell(
          onTap: (){
            Get.to(() => GCIManagement());
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