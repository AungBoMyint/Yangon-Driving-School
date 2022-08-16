import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/utils/widget/widget.dart';
import 'package:hammies_user/widgets/radio/radio_type.dart';

import '../../../controller/home_controller.dart';
import '../../../model/radio/radio_model.dart';
import '../../../routes/routes.dart';
import '../../view/cart.dart';
import '../controller/service_form_controller.dart';

class ServiceForm extends StatefulWidget {
  const ServiceForm({Key? key}) : super(key: key);

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {

  String licenceGroupValue = licenceType[0];
  String serviceGroupValue = serviceType[0];

  @override
  Widget build(BuildContext context) {
    final ServiceFormController _controller = Get.find();
    final HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "ယာဉ်မောင်းလိုင်စင် ဝန်ဆောင်မှု",
      ),
      body: Form(
          child:  ListView(
              children: [
                ChildTextFieldWidget(
                  fieldKey: "name",
                  fieldName: "အမည်",
                ),
                ChildTextFieldWidget(
                  fieldKey: "father-name",
                  fieldName: "အဖအမည်",
                ),
                ChildTextFieldWidget(
                  fieldKey: "dateOfBirth",
                  fieldName: "မွေးသက္ကရာဇ်",
                ),
                ChildTextFieldWidget( 
                  fieldKey: "idNo",
                  fieldName: "မှတ်ပုံတင်အမှတ်",
                ),
                ChildTextFieldWidget(
                  fieldKey: "adress",
                  fieldName: "နေရပ်လိပ်စာ",
                ),
                ChildTextFieldWidget(
                  fieldKey: "phNo",
                  fieldName: "ဖုန်းနံပါတ်",
                ),
                ChildTextFieldWidget(
                  fieldKey: "licenseNo",
                  fieldName: "လိုင်စင်အမှတ်(သက်တမ်းတိုး)",
                  isOptional: true,
                ),
                ChildTextFieldWidget(
                  fieldKey: "licenseExpireDate",
                  fieldName: "လိုင်စင်ကုန်ဆုံးရက်(သက်တမ်းတိုး)",
                  isOptional: true,
                ),
                RadioTypeWidget<String>(
                  title: "ဆောင်ရွက်လိုသောလိုင်စင်",
                  groupValue: licenceGroupValue,
                  onChanged: (result) => setState(() {
                    licenceGroupValue = result;
                  }),
                  count: 4, 
                  labelList: licenceType.map((e) => RadioModel(
                      name: e, 
                      value: e,
                      ),).toList(),
                  ),
                
                  const SizedBox(height: 10,),
                  RadioTypeWidget<String>(
                  title: "ဆောင်ရွက်လိုသောဝန်ဆောင်မှု",
                  groupValue: serviceGroupValue,
                  onChanged: (result) => setState(() {
                    serviceGroupValue = result;
                  }),
                  count: 4, 
                  labelList: serviceType.map((e) => RadioModel(
                      name: e, 
                      value: e,
                      ),).toList(),
                  ),
                  const SizedBox(height: 5,),
                  Obx((){
                    return RadioTypeWidget<String>(
                      highSpace: 10,
                      nameWidth: 200,
                    eachCountHeight: 150,
                    titleWidth: 250,
                  title: "လိုင်စင်ကြေး အမျိုးအစား",
                  groupValue: _controller.costID.value,
                  onChanged: (result)=> _controller.setCostId(result),
                  count: _controller.costList.length, 
                  labelList: _controller.costList.map((e) => RadioModel(
                      name: "${e.desc}\n${e.cost}ks", 
                      value: e.id,
                      ),).toList(),
                  );
                  }), 
              ],
              
          ),
          
      ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: 
            () {
              _controller.pressedFirstTime();
              setState(() {
              });
              if(_homeController.currentUser.value!.status! < 0){
                Get.toNamed(loginScreen);
                return;
              }
              if(_controller.isValidate()){
                Get.bottomSheet(
                  PaymentOptionContent(
                    callback: () =>   _controller.submitForm(licenceType: licenceGroupValue,
                serviceType: serviceGroupValue,
                )),
                  backgroundColor: Colors.white,
                  barrierColor: Colors.white.withOpacity(0),
                  elevation: 2,
                );
                debugPrint("***********Validating is Validate*****");
              }else{
                debugPrint("*********Invalid*****");
              }
            }, child: Text("စာရင်းသွင်းရန်")),
          ),
        ),
    );
  }
}

class ChildTextFieldWidget extends StatefulWidget {
  final String fieldName;
  final String fieldKey;
  final bool isOptional;
  const ChildTextFieldWidget({Key? key,required this.fieldKey,
  this.isOptional = false,
  required this.fieldName,
  }) : super(key: key);

  @override
  State<ChildTextFieldWidget> createState() => _ChildTextFieldWidgetState();
}

class _ChildTextFieldWidgetState extends State<ChildTextFieldWidget> {
  final ServiceFormController _controller = Get.find();

  @override
  void initState() {
     super.initState();
     _controller.inputMap.putIfAbsent(widget.fieldKey, () => TextEditingController());
     //_controller.inputMap[widget.fieldKey] = TextEditingController();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
      child: Row(
        children: [
          //Label
          Text(
            widget.fieldName,
            style: TextStyle(
              color: Colors.black,
              fontSize:16,
            ),
          ),
          const SizedBox(width: 10,),
          //TextField
          Expanded(
              child:  TextFormField(
                style: TextStyle(
                  decoration: TextDecoration.none,
                ),
                scrollPadding: const EdgeInsets.all(5.0),
                onChanged: (value){
                  if(!(widget.isOptional)){
                    _controller.checkHasError(widget.fieldKey, value);
                  setState(() {
                  });
                  }
                },
                controller: _controller.inputMap[widget.fieldKey],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  isDense: true,
                   disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color:widget.isOptional ? Colors.grey : ( _controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey),
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: widget.isOptional ? Colors.grey : (_controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey),
                      )
                   ),
                   focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                       width: 2,
                        color:_controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey,
                      )
                   ),
                ),
                        ),
             
              ),
        ]
      ),
    );
  }
}

