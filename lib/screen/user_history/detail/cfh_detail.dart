import 'package:flutter/material.dart';
import 'package:hammies_user/model/form/course_form.dart';
import 'package:hammies_user/utils/widget/widget.dart';

import '../../../utils/utils.dart';

class CFHDetail extends StatelessWidget {
  final CourseForm courseForm;
  const CFHDetail({Key? key,required this.courseForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "History Detail"),
      body: ListView(
        children: [
          FormRowWidget(
            label: "သင်တန်း: ",
            value: courseForm.courseType,
          ),
          FormRowWidget(
            label: "ကား gear: ",
            value: courseForm.carType,
          ),
          FormRowWidget(
            label: "သင်တန်းရက်: ",
            value: courseForm.dayType,
          ),
          FormRowWidget(
            label: "အချိန်: ",
            value: courseForm.timeType,
          ),
          FormRowWidget(
            label: "စတက်မည့်ရက်: ",
            value: getDate(courseForm.initialDay),
          ),
          FormRowWidget(
            label: "သင်တန်းကြေး: ",
            value: "${courseForm.price.desc} \n ${courseForm.price.price}ks",
          ),
        ],
      ),
    );
  }
}