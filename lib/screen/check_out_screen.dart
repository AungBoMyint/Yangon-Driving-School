import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../data/enum.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: Container(
          margin: EdgeInsets.only(
            top: 7,
            bottom: 10,
            left: 7,
          ),
          width: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            onPressed: Get.back,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: GetX<HomeController>(
        builder: (controller) {
          return Theme(
            data: ThemeData(
                primarySwatch: Colors.orange,
                colorScheme: ColorScheme.light(
                  primary: Colors.orange,
                  secondary: Colors.orange,
                )),
            child: Stepper(
              currentStep: controller.checkOutStep.value,
              controlsBuilder: (context, controlDetails) {
                return controller.checkOutStep.value == 1
                    ? ElevatedButton(
                        onPressed: ()  {
                          //TODO: TOSUBMIT ORDER
                          if ((controller.paymentOptions !=
                                  PaymentOptions.None) &&
                              (controller.paymentOptions ==
                                  PaymentOptions.CashOnDelivery)) {
                            //First we need to set Image to null
                            controller.setBankSlipImage('');
                             controller.proceedToPay();
                          } else if ((controller.paymentOptions !=
                                  PaymentOptions.None) &&
                              (controller.paymentOptions ==
                                  PaymentOptions.PrePay) &&
                              (controller.bankSlipImage.isNotEmpty)) {
                            //First we need to set Image to null
                             controller.proceedToPay();
                          } else {
                            debugPrint("*********Noting do....................");
                          }
                        },
                        child: Center(
                          child: Text(
                            "Order တင်မည်",
                          ),
                        ),
                      )
                    : SizedBox(height: 0, width: 0);
              },
              onStepTapped: (index) => controller.changeStepIndex(index),
              type: StepperType.horizontal,
              steps: [
                Step(
                  isActive: controller.checkOutStep >= 0,
                  state: controller.checkOutStep.value > 0
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text("Delivery အချက်အလက်ဖြည့်"),
                  content: FormWidget(),
                ),
                Step(
                  isActive: controller.checkOutStep >= 1,
                  state: StepState.indexed,
                  title: Text("အတည်ပြု"),
                  content: controller.paymentOptions == PaymentOptions.PrePay
                      ? prePayWidget(context)
                      : SizedBox(height: 0, width: 0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//Pre-Pay Widget
Widget prePayWidget(BuildContext context) {
  final size = MediaQuery.of(context).size;
  HomeController controller = Get.find();
  return SizedBox(
    height: 389,
    child: Padding(
      padding: const EdgeInsets.only(left: 15,top: 15,),
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        //Button
        Column(
          children: [

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/kpay.png",
                      width: 112,
                      height: 63,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Kyaw Maw Ye",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(text: "09795633589"))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "KBZ Pay Account နံပါတ် 09 795 633 589 ကို Copy ကူး လိုက်ပါပြီ")));
                        });
                      },
                      child: const Text('09 795 633 589'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/kbz.png",
                      width: 112,
                      height: 63,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Kyaw Maw Ye",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                            new ClipboardData(text: "13630121900306201"))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "KBZ Bank Account နံပါတ် 1363 0121 9003 0620 1 ကို Copy ကူး လိုက်ပါပြီ")));
                        });
                      },
                      child: const Text('1363 0121 9003 0620 1'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/aya.png",
                      width: 112,
                      height: 63,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Kyaw Maw Ye",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                            new ClipboardData(text: "20005733048"))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "AYA Bank Account နံပါတ် 2000 5733 048 ကို Copy ကူး လိုက်ပါပြီ")));
                        });
                      },
                      child: const Text('2000 5733 048'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/cbbank.png",
                      width: 112,
                      height: 63,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "  Kyaw Maw Ye",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(text: "0010600500635901"))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "CB Bank Account နံပါတ်  0010 6005 0063 5901 ကို Copy ကူး လိုက်ပါပြီ")));
                        });
                      },
                      child: const Text('0010 6005 0063 5901'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            OutlinedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              )),
              onPressed: () => getBankSlip(controller),
              child: Text("KBZ Pay / KBZ / AYA / CB ငွေလွှဲ Screenshot တင်ရန်"),
            ),
          ],
        ),
        //Image String
        Obx(() => SizedBox(
              height: 50,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: Text(
                    controller.bankSlipImage.value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                controller.bankSlipImage.value.isNotEmpty
                    ? SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () => controller.setBankSlipImage(""),
                          icon: Icon(
                            FontAwesomeIcons.times,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SizedBox(height: 0, width: 0),
              ]),
            ))
      ])),
    ),
  );
}

//Get Bank Slip
getBankSlip(HomeController controller) async {
  try {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    controller.setBankSlipImage(image!.path);
  } catch (e) {
    debugPrint("Error Bank Slip Image Picking");
  }
}

//Cash On Delivery Widget
//Form Text
class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _form = GlobalKey();
  final HomeController controller = Get.find();
  
  ///
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    final list = controller.getUserOrderData();
    if (list.isNotEmpty) {
      nameController.text = list[0];
      emailController.text = list[1];
      phoneController.text = list[2];
      addressController.text = list[3];
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _form,
      child: SizedBox(
        height: size.height * 0.8,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: nameController,
                validator: (e) =>
                    e?.isEmpty == true ? "Name is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'အမည်',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: phoneController,
                validator: (e) =>
                    e?.isEmpty == true ? "Phone is required" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ဆက်သွယ်ရန် ဖုန်းနံပါတ်',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: addressController,
                validator: (e) =>
                    e?.isEmpty == true ? "Address is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ပို့ဆောင်ပေးရမည့် လိပ်စာ',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: emailController,
                validator: (e) => e?.isEmpty == true
                    ? "Remark is required"
                    : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'မှတ်ချက်',
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () async {
                  if (_form.currentState?.validate() == true) {
                    //TODO: TO SAVE OR NOT INTO DATABASE
                    await controller
                        .setUserOrderData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                        )
                        .then((value) => controller.changeStepIndex(1));
                    //Store into UserOrderData

                    /*Get.back();

                    Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'အောင်မြင်ပါသည်');*/
                  }
                },
                child: Text('သိမ်းထားမည်'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
