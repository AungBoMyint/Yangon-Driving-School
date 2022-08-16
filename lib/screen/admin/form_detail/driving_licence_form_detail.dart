import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hammies_user/model/form/driving_licence_form.dart';
import 'package:hammies_user/utils/widget/widget.dart';

class DrivingLicenceFormDetail extends StatelessWidget {
  final DrivingLicenceForm drivingLicenceForm;
  const DrivingLicenceFormDetail({Key? key,required this.drivingLicenceForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Form Detail"),
      body: ListView(
        children: [
          FormRowWidget(
            label: "နာမည်: ",
            value: drivingLicenceForm.name,
          ),
          FormRowWidget(
            label: "အဖအမည်: ",
            value: drivingLicenceForm.fatherName,
          ),
          FormRowWidget(
            label: "မွေးနှစ်: ",
            value: drivingLicenceForm.dateOfBirth,
          ),
          FormRowWidget(
            label: "မှတ်ပုံတင်အမှတ်: ",
            value: drivingLicenceForm.idNo,
          ),
          FormRowWidget(
            label: "နေရပ်လိပ်စာ: ",
            value: drivingLicenceForm.address,
          ),
          FormRowWidget(
            label: "ဖုန်းနံပါတ်: ",
            value: drivingLicenceForm.phoneNumber,
          ),
          FormRowWidget(
            label: "လိုင်စင်အမှတ်: ",
            value: drivingLicenceForm.licenceNo ?? "",
          ),
          FormRowWidget(
            label: "လိုင်စင်ကုန်ဆုံးရက်: ",
            value: drivingLicenceForm.licenceExpiredDate ?? "",
          ),
          FormRowWidget(
            label: "ဆောင်ရွက်လိုသောလိုင်စင်: ",
            value: drivingLicenceForm.licenceType,
          ),
          FormRowWidget(
            label: "ဆောင်ရွက်လိုသောာဝန်ဆောင်မှု: ",
            value: drivingLicenceForm.serviceType,
          ),
          FormRowWidget(
            label: "သင်တန်းကြေး: ",
            value: "${drivingLicenceForm.cost}ks",
          ),
        ]
      ),
    );
    
  }
}