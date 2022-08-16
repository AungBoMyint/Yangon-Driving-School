// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
// import 'package:get/get.dart';
//
// import '../controller/home_controller.dart';
// import '../controller/manage_controller.dart';
// import '../data/constant.dart';
// import '../model/item.dart';
// import '../routes/routes.dart';
//
// class ManageItem extends StatefulWidget {
//   const ManageItem({Key? key}) : super(key: key);
//
//   @override
//   State<ManageItem> createState() => _ManageItemState();
// }
//
// class _ManageItemState extends State<ManageItem> {
//   final TextEditingController editingController = TextEditingController();
//   final HomeController homeController = Get.find();
//   final MangeController mangeController = Get.find();
//   @override
//   void dispose() {
//     homeController.clear();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
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
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: size.height,
//           width: size.width,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: TextField(
//                   controller: editingController,
//                   onChanged: homeController.onSearch,
//                   // onSubmitted: homeController.searchItem,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Search",
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           editingController.clear();
//                           homeController.clear();
//                         },
//                         icon: Icon(Icons.clear),
//                       )),
//                 ),
//               ),
//               Expanded(child: Obx(() {
//                 if (homeController.isSearch.value) {
//                   //If currently searching
//                   return ListView.builder(
//                     itemCount: homeController.searchitems.length,
//                     itemBuilder: (context, index) {
//                       return itemWidget(homeController.searchitems[index]);
//                     },
//                   );
//                 } else {
//                   return SizedBox(
//                     height: size.height,
//                     width: size.width,
//                     child: ListView(children: [
//                       //Export Brand
//                       SizedBox(
//                           height: homeController.items.length * 140,
//                           child: ListView.builder(
//                             primary: false,
//                             itemCount: homeController.items.length,
//                             itemBuilder: (context, index) {
//                               return itemWidget(homeController.items[index]);
//                             },
//                           )),
//                       //Own Brand
//                       SizedBox(
//                           height: homeController.brandItems.length * 140,
//                           child: ListView.builder(
//                             primary: false,
//                             itemCount: homeController.brandItems.length,
//                             itemBuilder: (context, index) {
//                               return itemWidget(
//                                   homeController.brandItems[index]);
//                             },
//                           ))
//                     ]),
//                   );
//                 }
//               })),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget itemWidget(ItemModel item) {
//   final HomeController homeController = Get.find();
//   final MangeController mangeController = Get.find();
//   return SwipeActionCell(
//     key: ValueKey(item.id),
//     trailingActions: [
//       SwipeAction(
//         onTap: (CompletionHandler _) async {
//           await _(true);
//           await mangeController.delete(item.id!);
//           //setState(() {});
//         },
//         title: 'Delete',
//       ),
//       SwipeAction(
//         color: Colors.grey,
//         onTap: (CompletionHandler _) async {
//           await _(false);
//
//           homeController.setEditItem(item);
//           homeController.changeOwnBrandOrNot(item.isOwnBrand,
//               false); //Make Sure to change Brand Options Depend On This Product.
//           Get.toNamed(uploadItemScreen);
//           //setState(() {});
//         },
//         title: 'Edit',
//       ),
//     ],
//     child: Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       height: 140,
//       child: Card(
//         elevation: 5,
//         child: Row(
//           children: [
//             CachedNetworkImage(
//               imageUrl: item.photo,
//               width: 100,
//               height: 125,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.name,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     item.color.replaceAll(',', ', '),
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       wordSpacing: 1,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     item.size.replaceAll(',', ', '),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       wordSpacing: 1,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "${item.price}Ks",
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }