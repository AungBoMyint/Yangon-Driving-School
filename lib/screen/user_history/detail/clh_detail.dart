import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hammies_user/model/form/car_licence_form.dart';
import 'package:hammies_user/utils/widget/widget.dart';

class CLHDetail extends StatelessWidget {
  final CarLicenceForm carLicenceForm;
  const CLHDetail({Key? key,required this.carLicenceForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "History Detail"),
      body: ListView(
        children: [
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