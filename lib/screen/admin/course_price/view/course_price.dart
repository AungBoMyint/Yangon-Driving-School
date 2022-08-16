import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constant.dart';
import '../controller/course_price_controller.dart';

class CoursePriceView extends StatefulWidget {
  const CoursePriceView({Key? key}) : super(key: key);

  @override
  State<CoursePriceView> createState() => _CoursePriceViewState();
}

class _CoursePriceViewState extends State<CoursePriceView> {
  

  @override
  Widget build(BuildContext context) {
    final CoursePriceController _controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Center(child: Text("စျေးနှုန်းများ",
          style: TextStyle(color: Colors.black,))),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 20,
          ),
          child: Column(
            children: [
               Form(
                  key: _controller.formKey,
                  child:   Column(
                            children: [
                              //Desc
                              SizedBox(
                                height: 100,
                                child: TextFormField(
                                controller: _controller.descController,
                                  validator: _controller.validate,
                                  decoration: InputDecoration(
                                    hintText: "Enter description",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              //Price
                              SizedBox(
                                height: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                controller: _controller.priceController,
                                    validator: _controller.validate,
                                    decoration: InputDecoration(
                                      hintText: "Enter price",
                                      
                                      border: OutlineInputBorder(),
                                    ),
                                ),
                              ),
                            const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () => _controller.addPrice(), 
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.white,),
                            ),
                            ),
                        ),
                            ],
                          ),     
                        
                ),
            
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
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
                    if (_controller.priceList.isEmpty) {
                      return const Center(
                          child: Text(
                        "No price yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: _controller.priceList.length,
                      itemBuilder: (context, index) {
                        var cate = _controller.priceList[index];

                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${cate.desc}\n"
                                      "${cate.price.toString()}ks",
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                       _controller.deletePrice(cate.id);
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
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
