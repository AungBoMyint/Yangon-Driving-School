import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/guideline_item/controller/gci_controller.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../data/colorpicker.dart';
import '../../../../utils/widget/widget.dart';

class GCIManagement extends StatefulWidget {
  const GCIManagement({Key? key}) : super(key: key);

  @override
  State<GCIManagement> createState() => _GCIManagementState();
}

class _GCIManagementState extends State<GCIManagement> {
  @override
  Widget build(BuildContext context) {
    final GCIController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(title: "လမ်းညွှန်ချက်များ"),
      body:   ListView(
                  children: [
                     
                                    //Desc
                                    ChildTextFieldWidget(
                                        fieldKey: "title", 
                                        fieldName: "Enter title",
                                        ),
                                    
                                    ChildTextFieldWidget(
                                        fieldKey: "image", 
                                        fieldName: "Enter image url",
                                        ),
                                  const SizedBox(
                                height: 10.0,
                              ),
                               Obx((){
                                  return Wrap(
                                    children: _controller.guideLineCategories.map((e){
                                     final isSelected = _controller.selectedCategory.value == e.id;
                                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: isSelected ? Colors.black: Colors.white,
                            ),
                            onPressed: () => _controller.setSelectedCategory(e.id), 
                            child: Expanded(
                              child: Text(
                                e.title,
                                style: TextStyle(color: isSelected ? Colors.white: Colors.black,),
                              ),
                            ),
                            ),
                        );
                                    }).toList(),
                                  );
                                }),
              
                          ]),
                  bottomNavigationBar: SizedBox(
                                height: 50,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    onPressed: 
                                  () {
                                    _controller.pressedFirstTime();
                                    setState(() {
                                    });
                                    if(_controller.isValidate()){
                                      _controller.uploadGLC();
                                      debugPrint("***********Validating is Validate*****");
                                    }else{
                                      debugPrint("*********Invalid*****");
                                    }
                                  }, child: Text("Submit")),
                                ),
                              ),
                              
                    );
  }
}


class ChildTextFieldWidget extends StatefulWidget {
  final String fieldName;
  final String fieldKey;
  const ChildTextFieldWidget({Key? key,required this.fieldKey,
  required this.fieldName,
  }) : super(key: key);

  @override
  State<ChildTextFieldWidget> createState() => _ChildTextFieldWidgetState();
}

class _ChildTextFieldWidgetState extends State<ChildTextFieldWidget> {
  final GCIController _controller = Get.find();

  @override
  void initState() {
     super.initState();
     _controller.inputMap.putIfAbsent(widget.fieldKey, () => TextEditingController());
     //_controller.inputMap[widget.fieldKey] = TextEditingController();
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: _controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                           Colors.red : Colors.grey,
          )
        ),
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: Expanded(
          child: TextFormField(
                    style: TextStyle(
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.fieldName,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )
                    ),
                    scrollPadding: const EdgeInsets.all(5.0),
                    onChanged: (value){
                      _controller.checkHasError(widget.fieldKey, value);
                      setState(() {
                        
                      });
                    },
                    controller: _controller.inputMap[widget.fieldKey],
                    
                            ),
        ),
               
              
      ),
    );
  }
}