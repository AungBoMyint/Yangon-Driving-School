import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/course_form/controller/course_form_controller.dart';
import 'package:hammies_user/utils/utils.dart';
import 'package:hammies_user/utils/widget/widget.dart';
import 'package:hammies_user/widgets/radio/radio_type.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../controller/home_controller.dart';
import '../../../model/radio/radio_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/radio/car_type.dart';
import '../../../widgets/radio/class_type.dart';
import '../../../widgets/radio/days_type.dart';
import '../../view/cart.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({Key? key}) : super(key: key);

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
 final CourseFormController _controller = Get.find();
  String classGroupValue = classType[0];
  String carGroupValue = carType[0];
  String timeGroupValue = timeType[0];
  String dayTypeGroupValue = dayType[0];
  

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "သင်တန်းအပ်ရန်",
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
                  fieldKey: "father-name",
                  fieldName: "အဖအမည်",
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
                RadioTypeWidget<String>(
                  title: "သင်တန်းအမျိုးအစား",
                  onChanged: (result) {
                    setState(() {
                      classGroupValue = result;
                    });
                  },
                  count: 2,
                  groupValue: classGroupValue, 
                  labelList: classType.map((e) => RadioModel(
                      name: e ,
                      value: e,
                      ),).toList(),
                  ),  
                RadioTypeWidget<String>(
                  title: "ကားအမျိုးအစား",
                  groupValue: carGroupValue,
                  onChanged: (result) => setState(() {
                    carGroupValue = result;
                  }),
                  count: 2, 
                  labelList: carType.map((e) => RadioModel(
                      name: e, 
                      value: e,
                      ),).toList(),
                  ),
                RadioTypeWidget<String>(
                  eachCountHeight: 100,
                  title: "သင်တန်းရက်",
                  count: 2, 
                   groupValue: dayTypeGroupValue,
                  onChanged: (result) => setState(() {
                    dayTypeGroupValue= result;
                  }),
                  labelList:
                  dayType.map((e){
                    return e == dayType[0] ? RadioModel(
                      name: e + "\n(အင်္ဂါ၊ဗုဒ္ဓဟူး၊ကြာသပတေး၊သောကြာ)", 
                      value: e,
                      ) : RadioModel(
                      name: e + "\n(စနေ၊တနင်္ဂနွေ)",
                    
                      value: e,
                      );
                  }).toList(),
                  
                  ), 
                  const SizedBox(height: 10,),
                  RadioTypeWidget<String>(
                    eachCountHeight: 80,
                    titleWidth: 200,
                  title: "သင်တန်းအချိန်",
                  groupValue: timeGroupValue,
                  onChanged: (result)=> setState(() {
                    timeGroupValue = result;
                  }),
                  count: 2, 
                  labelList: timeType.map((e) => RadioModel(
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
                  title: "သင်တန်းကြေး အမျိုးအစား",
                  groupValue: _controller.priceID.value,
                  onChanged: (result)=> _controller.changePriceID(result),
                  count: _controller.priceList.length, 
                  labelList: _controller.priceList.map((e) => RadioModel(
                      name: "${e.desc}\n${e.price}ks", 
                      value: e.id,
                      ),).toList(),
                  );
                  }),
                  const SizedBox(height: 5,),
                  DateTimePickerWidget(),    
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
                    callback: () =>  _controller.submitForm(
                  carType: carGroupValue, 
                  courseType: classGroupValue, 
                  dayType: dayTypeGroupValue,
                  timeType: timeGroupValue,
                  )),
                  backgroundColor: Colors.white,
                  barrierColor: Colors.white.withOpacity(0),
                  elevation: 2,
                );
                /* _controller.submitForm(
                  carType: carGroupValue, 
                  courseType: classGroupValue, 
                  dayType: dayTypeGroupValue,
                  timeType: timeGroupValue,
                  ); */
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
  final CourseFormController _controller = Get.find();

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
              backgroundColor: Colors.grey.shade400,
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