/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/radio/radio_model.dart';
import '../../screen/course_form/controller/course_form_controller.dart';

class ClassTypeRadioWidgets extends StatelessWidget {
  final int count;
  final String title;
  final List<RadioModel> labelList;
  const ClassTypeRadioWidgets({Key? key,
  required this.title,
  required this.count,
  required this.labelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseFormController _controller = Get.find();
    return Container(
      height: (count * 50) + 50,
      padding: const EdgeInsets.only(left: 20,bottom: 5,),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
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
                        return Radio<ClassType>(
                          value: labelList[index].value, 
                          groupValue: _controller.classType.value, 
                          onChanged: (value) => _controller.changeClassType(value!),
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