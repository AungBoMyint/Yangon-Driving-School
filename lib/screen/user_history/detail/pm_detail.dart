import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../model/purchase.dart';
import '../../../utils/widget/widget.dart';

class PurchaseModelDetail extends StatelessWidget {
  final PurchaseModel purchaseModel;
  const PurchaseModelDetail({Key? key,required this.purchaseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBar(title: "History Detail"),
       body: ListView(
        children: [
           FormRowWidget(
            label: "နာမည်: ",
            value: purchaseModel.name,
          ),
          FormRowWidget(
            label: "အီးမေးလ်: ",
            value: purchaseModel.email,
          ),
          FormRowWidget(
            label: "လိပ်စာ: ",
            value: purchaseModel.address,
          ),
          FormRowWidget(
            label: "${purchaseModel.deliveryTownshipInfo[0]}: ",
            value: "",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Text("Products များ", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),),
          ),
          SizedBox(
            height: purchaseModel.rewardProductList!.length * 50,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: purchaseModel.rewardProductList!.length,
              itemBuilder: (context,index){
                final item = purchaseModel.rewardProductList![index];
                return SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Name
                      Text(item.name,),
                      //Point
                      Text("${item.requirePoint} points"),
                      //Count
                      Text("count ${item.count}")
                    ],
                  ),
                );
              },
              ),
          ),
        ],
       ),
    );
  }
}