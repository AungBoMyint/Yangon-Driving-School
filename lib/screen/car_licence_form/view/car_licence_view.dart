import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:hammies_user/screen/car_licence_form/controller/car_license_controller.dart';
import 'package:hammies_user/screen/course_form/controller/course_form_controller.dart';
import 'package:hammies_user/utils/widget/widget.dart';
import 'package:hammies_user/widgets/radio/radio_type.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../controller/home_controller.dart';
import '../../../model/radio/radio_model.dart';
import '../../view/cart.dart';

class CarLicenceForm extends StatefulWidget {
  const CarLicenceForm({Key? key}) : super(key: key);

  @override
  State<CarLicenceForm> createState() => _CarLicenceFormState();
}

class _CarLicenceFormState extends State<CarLicenceForm> {
  final CarLicenseController _controller = Get.find();

  String enginGroupValue = "";

  @override
  void initState() {
    enginGroupValue = carEnginList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "ကားလိုင်စင် ဝန်ဆောင်မှု",
      ),
      body: Form(
          child:  ListView(
              children: [
                ChildTextFieldWidget(
                  key: Key("name"),
                  fieldKey: "name",
                  fieldName: "အမည်",
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
                  fieldKey: "carNo",
                  fieldName: "ကားအမှတ်",
                ),
                ChildTextFieldWidget(
                  fieldKey: "expireDate",
                  fieldName: "ကားလိုင်စင်ကုန်ဆုံးရက်",
                ),
                RadioTypeWidget<String>(
                  title: "ကား Engine အမျိုးအစား",
                  onChanged: (result) {
                    setState(() {
                      enginGroupValue = result;
                    });
                  },
                  count: carEnginList.length,
                  groupValue: enginGroupValue, 
                  labelList: carEnginList.map((e){
                    return RadioModel(
                      name: e, 
                      value: e,
                      );
                  }).toList(),
                  ),  
                ChildTextFieldWidget(
                  fieldKey: "toDoFromOffice",
                  fieldName: "လုပ်ငန်းဆောင်ရွက်ရန်ရုံး",
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
                    callback: () =>   _controller.submitForm(enginPowerType: enginGroupValue)),
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
  const ChildTextFieldWidget({Key? key,required this.fieldKey,
  required this.fieldName,
  }) : super(key: key);

  @override
  State<ChildTextFieldWidget> createState() => _ChildTextFieldWidgetState();
}

class _ChildTextFieldWidgetState extends State<ChildTextFieldWidget> {
  final CarLicenseController _controller = Get.find();

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
                  _controller.checkHasError(widget.fieldKey, value);
                  setState(() {
                    
                  });
                },
                controller: _controller.inputMap[widget.fieldKey],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  
                  isDense: true,
                   disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey,
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color:_controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey,
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

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseFormController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          //Title
          Text(
            "သင်တန်းရက်ရွေးပါ(စတက်မည့်ရက်)",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
          ),
          //DatePicker
          SizedBox(
            height: 300,
            width: size.width * 0.85,
            child: SfDateRangePickerTheme(
            data: SfDateRangePickerThemeData(
              backgroundColor: Colors.grey,
            ),
            child: SfDateRangePicker(
              initialSelectedDate: _controller.selectedDateTime.value,
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(color: Colors.white,)
              ),
              todayHighlightColor: Colors.white,
                  showTodayButton: true,
                  onSelectionChanged: (args) => _controller.setSelectedDateTime(args.value as DateTime),
                ),
                  ),
          ),
        ]
      ),
    );
  }
}