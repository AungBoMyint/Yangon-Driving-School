import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hammies_user/model/form/course_form.dart';
import 'package:hammies_user/utils/utils.dart';
import 'package:hammies_user/utils/widget/widget.dart';

class CourseFormDetail extends StatelessWidget {
  final CourseForm courseForm;
  const CourseFormDetail({Key? key,required this.courseForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Form Detail"),
      body: ListView(
        children: [
          FormRowWidget(
            label: "နာမည်: ",
            value: courseForm.name,
          ),
          FormRowWidget(
            label: "အဖအမည်: ",
            value: courseForm.fatherName,
          ),
          FormRowWidget(
            label: "မှတ်ပုံတင်အမှတ်: ",
            value: courseForm.idNo,
          ),
          FormRowWidget(
            label: "နေရပ်လိပ်စာ: ",
            value: courseForm.address,
          ),
          FormRowWidget(
            label: "ဖုန်းနံပါတ်: ",
            value: courseForm.phoneNumber,
          ),
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
