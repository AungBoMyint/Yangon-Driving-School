import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/radio/radio_model.dart';
import '../../screen/course_form/controller/course_form_controller.dart';

class DayTypeRadioWidgets extends StatelessWidget {
  final int count;
  final String title;
  
  final List<RadioModelWithDescription> labelList;
  const DayTypeRadioWidgets({Key? key,
  required this.title,
  required this.count,
  required this.labelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseFormController _controller = Get.find();
    return Container(
      height: (count * 100) + 50,
      padding: const EdgeInsets.only(left: 20,bottom: 5,right: 10,),
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
                return SizedBox(
                  height: 100,
                  child: Obx(
                    () {
                      return RadioListTile<String>(
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity :ListTileControlAffinity.trailing,
                        value: labelList[index].value,
                        title: Text(
                            labelList[index].name,
                            style: TextStyle(
                                fontSize: 16,
                              )
                          ),
                        subtitle: Text(
                            labelList[index].description,
                            style: TextStyle(
                                fontSize: 16,
                              )
                          ), 
                        groupValue: _controller.dayType.value, 
                        onChanged: (value) => _controller.changeDayType(value!),
                        );
                    }
                  ),
                  );}),),]),
    );
  }
}

/*
Column(
                    children: [
                      //Radio
                      Expanded(
                        child: Row(
                          children: [
                            //Label
                            Expanded(
                              flex: 1,
                              child: Text(labelList[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.visible,
                              )),
                            ),
                            //Radio
                            Obx(
                              () {
                                return Expanded(
                                  flex: 1,
                                  child: Radio<DayType>(
                                    value: labelList[index].value, 
                                    groupValue: _controller.dayType.value, 
                                    onChanged: (value) => _controller.changeDayType(value!),
                                    ),
                                );
                              }
                            ),
                            const SizedBox(width: 100),
                          ],
                        ),
                      ),
                      //Description
                      Text(
                        labelList[index].description,
                        style: TextStyle(
                            fontSize: 16,
                          )
                      ),
                    ],
                  ),
                );
              },
              ),
          ),
        ],
      ),*/
