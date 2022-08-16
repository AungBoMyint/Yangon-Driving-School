import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../data/colorpicker.dart';
import '../../../../utils/widget/widget.dart';
import '../controller/gc_controller.dart';

class GCManagement extends StatefulWidget {
  const GCManagement({Key? key}) : super(key: key);

  @override
  State<GCManagement> createState() => _GCManagementState();
}

class _GCManagementState extends State<GCManagement> {
  @override
  Widget build(BuildContext context) {
    final GCController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(title: "လမ်းညွှန်ချက်အမျိုးအစားများ"),
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
                                    children: colorList.map((e){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                  onTap: () => _controller.setPickedColor(e),
                                                  splashColor: Colors.grey,
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor: HexColor(e),
                                                  ),
                                                ),
                                              ),
                        
                                              _controller.pickedColor.value == e ?
                                              Align(
                                                alignment: Alignment.center,
                                                child: Icon(Icons.check,color: Colors.white)
                                              )
                                              : const SizedBox(),
                                            ]
                                          )
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
  final GCController _controller = Get.find();

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