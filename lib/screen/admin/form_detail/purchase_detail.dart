import 'package:flutter/material.dart';
import 'package:hammies_user/model/purchase.dart';
import 'package:hammies_user/utils/widget/widget.dart';

class PurchaseOrderDetail extends StatelessWidget {
  final PurchaseModel purchaseModel;
  const PurchaseOrderDetail({Key? key,required this.purchaseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Order Detail"),
      body: ListView(
        children: [
          //
        ],
      ),
    );
  }
}