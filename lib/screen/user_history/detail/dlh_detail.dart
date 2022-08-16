import 'package:flutter/material.dart';
import 'package:hammies_user/model/form/driving_licence_form.dart';

import '../../../utils/utils.dart';
import '../../../utils/widget/widget.dart';

class DLHDetail extends StatelessWidget {
  final DrivingLicenceForm drivingLicenceForm;
  const DLHDetail({Key? key,required this.drivingLicenceForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "တင်ပြထားသော ယာဥ်မောင်းလိုင်စင်များ"),
      body: ListView(
        children: [
          FormRowWidget(
            label: "လိုင်စင် အမှတ် ",
            value: drivingLicenceForm.licenceNo ?? "",
          ),
          FormRowWidget(
            label: "လိုင်စင် ကုန်ဆုံးရက် ",
            value: drivingLicenceForm.licenceExpiredDate ?? "",
          ),
          FormRowWidget(
            label: "ဆောင်ရွက်လိုသော လိုင်စင် ",
            value: drivingLicenceForm.licenceType,
          ),
          FormRowWidget(
            label: "ဆောင်ရွက်လိုသော ဝန်ဆောင်မှု ",
            value: drivingLicenceForm.serviceType,
          ),
          FormRowWidget(
            label: "သင်တန်းကြေး ",
            value: "${drivingLicenceForm.cost} ကျပ်",
          ),
        ],
      ),
    );
  }
}