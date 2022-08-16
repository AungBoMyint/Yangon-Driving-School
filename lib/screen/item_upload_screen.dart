// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../controller/home_controller.dart';
// import '../data/constant.dart';
// import '../model/item.dart';
//
// class UploadItem extends StatefulWidget {
//   const UploadItem({Key? key}) : super(key: key);
//
//   @override
//   State<UploadItem> createState() => _UploadItemState();
// }
//
// class _UploadItemState extends State<UploadItem> {
//   final HomeController homecontroller = Get.find();
//
//   @override
//   void dispose() {
//     homecontroller.setEditItem(
//       ItemModel(
//         photo: '',
//         photo2: '',
//         photo3: '',
//         brand: '',
//         deliverytime: '',
//         discountprice: 0,
//         name: '',
//         price: 0,
//         desc: '',
//         color: '',
//         size: '',
//         star: 0,
//         category: '',
//         isOwnBrand: false,
//       ),
//     );
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBackground,
//       appBar: AppBar(
//         title: Text(
//           "𝐂𝐢𝐧𝐝𝐲 Branded Export Fashion",
//           style: TextStyle(color: Colors.black, fontSize: 14),
//         ),
//         elevation: 5,
//         backgroundColor: detailBackgroundColor,
//         leading: IconButton(
//           onPressed: Get.back,
//           icon: Icon(
//             Icons.arrow_back,
//             color: appBarTitleColor,
//           ),
//         ),
//       ),
//       body: Form(
//         key: controller.form,
//         child: ListView(
//           children: [
//             //Option OwnBrand Or Not
//             SizedBox(
//               height: 50,
//               child: GetBuilder<HomeController>(builder: (con) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //Export Brand
//                     ChoiceChip(
//                       selectedColor: Colors.black,
//                       label: Text(
//                         "Export Brand",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       selected: con.isOwnBrand == false,
//                       onSelected: (selected) =>
//                           con.changeOwnBrandOrNot(false, true),
//                     ),
//                     //Space
//                     const SizedBox(width: 10),
//                     //Own Brand
//                     ChoiceChip(
//                       selectedColor: Colors.black,
//                       label: Text(
//                         "Own Brand",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       selected: con.isOwnBrand == true,
//                       onSelected: (selected) =>
//                           con.changeOwnBrandOrNot(true, true),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//
//
//
//             Container(
//               height: 50,
//               margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//               child: ElevatedButton(
//                 style: buttonStyle,
//                 onPressed: controller.upload,
//                 child: Obx(
//                   () => controller.isUploading.value
//                       ? CircularProgressIndicator(
//                           color: scaffoldBackground,
//                         )
//                       : Text(homecontroller.editItem.value.id != null
//                           ? "Edit"
//                           : "upload"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
