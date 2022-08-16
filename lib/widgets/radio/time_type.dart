/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/radio/radio_model.dart';
import '../../screen/course_form/controller/course_form_controller.dart';

class TimeTypeRadioWidgets extends StatelessWidget {
  final int count;
  final String title;
  final List<RadioModel> labelList;
  const TimeTypeRadioWidgets({Key? key,
  required this.title,
  required this.count,
  required this.labelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseFormController _controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Container(
      height: (count * 65) + 50,
      padding: const EdgeInsets.only(left: 20,bottom: 5,),
      child: Column(
        children: [
          SizedBox(
            width: 200,
            child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count,
              itemBuilder: (context,index){
                return Row(
                  children: [
                    //Label
                    Text(labelList[index].name,
                    style: TextStyle(
                      fontSize: 16,
                    )),
                    //Radio
                    Obx(
                      () {
                        return Radio<TimeType>(
                          value: labelList[index].value, 
                          groupValue: _controller.timeType.value, 
                          onChanged: (value) => _controller.changeTimeType(value!),
                          );
                      }
                    ),
                  ],
                );
              },
              ),
          ),
        ],
      ),
    );
  }
} */