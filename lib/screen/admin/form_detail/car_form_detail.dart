import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hammies_user/model/form/car_licence_form.dart';
import 'package:hammies_user/utils/widget/widget.dart';

class CarFormDetail extends StatelessWidget {
  final CarLicenceForm carLicenceForm;
  const CarFormDetail({Key? key,required this.carLicenceForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Form Detail"),
      body: ListView(
        children: [
          FormRowWidget(
            label: "နာမည်: ",
            value: carLicenceForm.name,
          ),
         
          FormRowWidget(
            label: "မှတ်ပုံတင်အမှတ်: ",
            value: carLicenceForm.idNo,
          ),
          FormRowWidget(
            label: "နေရပ်လိပ်စာ: ",
            value: carLicenceForm.address,
          ),
          FormRowWidget(
            label: "ဖုန်းနံပါတ်: ",
            value: carLicenceForm.phoneNumber,
          ),
          FormRowWidget(
            label: "ကားအမှတ်: ",
            value: carLicenceForm.carNo,
          ),
          FormRowWidget(
            label: "ကားလိုင်စင်ကုန်ဆုံးရက်: ",
            value: carLicenceForm.carExpiredDate,
          ),
          FormRowWidget(
            label: "ကား engin power: ",
            value: carLicenceForm.enginPowerType,
          ),
          FormRowWidget(
            label: "သင်တန်းကြေး: ",
            value: "${carLicenceForm.cost}ks",
          ),
        ],
      ),
    );
  }
}