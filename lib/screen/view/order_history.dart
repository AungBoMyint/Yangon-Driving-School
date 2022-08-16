import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../controller/home_controller.dart';
import '../../data/constant.dart';
import '../../model/hive_purchase.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: Hive.box<HivePurchase>(purchaseBox).listenable(),
      builder: (context, Box<HivePurchase> box, widget) {
        debugPrint("*************${box.values.length}*****");
        return box.isNotEmpty
            ? SizedBox(
                height: size.height,
                width: size.width,
                child: ListView(
                  children: box.values.map((purchase) {
                    debugPrint(
                        "*****Purchase Item List: ${purchase.items?.length}");
                    return Obx(() {
                      return Dismissible(
                        key: Key(purchase.id),
                        background: Container(
                          color: Colors.black12,
                        ),
                        onDismissed: (direction) {
                          box.delete(purchase.id);
                        },
                        direction: DismissDirection.startToEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionPanelList(
                              expansionCallback: (index, isExpanded) =>
                                  controller.setPurchaseId(purchase.id),
                              children: [
                                ExpansionPanel(
                                  isExpanded:
                                      controller.purchaseId == purchase.id,
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isExpand) {
                                    var totalCount = 0;
                                    if (!(purchase.items == null)) {
                                      for (var item in purchase.items!) {
                                        totalCount += item.count;
                                      }
                                    }
                                    if (!(purchase.rewardProductList == null)) {
                                      for (var item
                                          in purchase.rewardProductList!) {
                                        totalCount += item.count;
                                      }
                                    }
                                    return ListTile(
                                      title: Text("${purchase.totalPrice} ကျပ်",
                                      style: TextStyle(fontSize: 14),),
                                      subtitle: Text(
                                          "${purchase.deliveryTownshipInfo[0]} ပေါင်းပြီး",
                                        style: TextStyle(fontSize: 12),),
                                      trailing: Text("${purchase.dateTime.day}/${purchase.dateTime.month}/${purchase.dateTime.year}",
                                      style: TextStyle(fontSize: 15),),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      //Normal Products
                                      if (!(purchase.items == null) &&
                                          (purchase.items!.length > 0)) ...[
                                        SizedBox(
                                          height: purchase.items!.length * 50,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.all(0),
                                            itemCount: purchase.items!.length,
                                            itemBuilder: (_, o) => Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: SizedBox(
                                                          width: 170,
                                                          child: Text(
                                                            "${o + 1}. ${purchase.items![o].itemName}",
                                                            style:
                                                                TextStyle(fontSize: 14),
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${purchase.items![o].color}",
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                            Text(
                                                              "${purchase.items![o].size}",
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 20),
                                                        child: Text(
                                                          "${purchase.items![o].price} x  ${purchase.items![o].count} ",
                                                          style:
                                                              TextStyle(fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      if (!(purchase.rewardProductList ==
                                              null) &&
                                          (purchase.rewardProductList!.length >
                                              0)) ...[
                                        SizedBox(
                                          height: purchase
                                                  .rewardProductList!.length *
                                              50,
                                          child: ListView.builder(
                                            itemCount: purchase
                                                .rewardProductList!.length,
                                            itemBuilder: (context, index) {
                                              final reward = purchase
                                                  .rewardProductList![index];
                                              return Row(
                                                children: [
                                                  Text("${index + 1}."),
                                                  //Name

                                                  Expanded(
                                                      child: Text(reward.name)),
                                                  //Point * Count
                                                  Text(
                                                      "${reward.requirePoints} points × ${reward.count}"),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      );
                    });
                  }).toList(),
                ),
              )
            : Center(
                child: Text("No order history."),
              );
      },
    );
  }
}
