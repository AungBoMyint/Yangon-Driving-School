import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/data/enum.dart';
import 'package:hammies_user/screen/admin/form_detail/car_form_detail.dart';
import 'package:hammies_user/screen/admin/form_detail/course_form_detail.dart';
import 'package:hammies_user/screen/admin/form_detail/driving_licence_form_detail.dart';
import 'package:hammies_user/screen/admin/form_detail/purchase_detail.dart';
import 'package:hammies_user/screen/user_history/detail/pm_detail.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../controller/home_controller.dart';
import '../../../../utils/widget/widget.dart';
import '../controller/enrollment_controller.dart';

class EnrollmentDataView extends StatefulWidget {
  const EnrollmentDataView({Key? key}) : super(key: key);

  @override
  State<EnrollmentDataView> createState() => _EnrollmentDataViewState();
}

class _EnrollmentDataViewState extends State<EnrollmentDataView> {
  GlobalKey _scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find();
    final EnrollmentController _enController = Get.find();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffold,
              appBar:  AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: appBarColor,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0,
              title: Text("Enrollment Data",
                        style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: Colors.black,
                            fontSize: 16,),
                      ),
                      bottom: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: "Course",
                          ),
                          Tab(
                            text: "Driving Licence",
                          ),
                          Tab(
                            text: "Car Licence",
                          ),
                          Tab(
                            text: "Purchase",
                          ),
                        ],
                        ),
        ),
      
        body:  TabBarView(
          children: [
            EnrollmentListView(controller: _controller, enController: _enController),
            DrivingLicenceListView(controller: _controller, enController: _enController),
            CarLicenceFormListView(controller: _controller, enController: _enController),
            PurchaseModelList(),
          ],
          ),
          
      ),
    );
  }
}

class EnrollmentListView extends StatelessWidget {
  const EnrollmentListView({
    Key? key,
    required HomeController controller,
    required EnrollmentController enController,
  }) : _controller = controller, _enController = enController, super(key: key);

  final HomeController _controller;
  final EnrollmentController _enController;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Prepay
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.PrePay ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.PrePay), 
                    child: Text("Prepay"),
                    ),),
                    //Space
                    const SizedBox(width: 20),
                  //CashOn
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.CashOnDelivery), 
                    child: Text("CashOn"),
                    ),),
                ],
              )
            ),
            Expanded(
              child: Obx(
                () {
                  final selectedPM = _enController.selectedPaymentMethod.value;
                  return selectedPM != PaymentOptions.None ?
                   ListView.builder(
                    itemCount: _controller.enrollList.length,
                    itemBuilder: (context,index){
                      final courseForm = _controller.enrollList[index];
                       return Obx((){
                        if(courseForm.bankSlipImage == null && _enController.selectedPaymentMethod.value == PaymentOptions.PrePay){
                          return const SizedBox();
                        }
                        if(!(courseForm.bankSlipImage == null) && _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery){
                          return const SizedBox();
                        }
                      return SizedBox(
                        height: 85,
                        child: Card(
                          child: Center(
                            child: ListTile(
                              onTap: () => Get.to(() => CourseFormDetail(courseForm: courseForm)),
                              leading: bankSlipImageWidget(courseForm.bankSlipImage,context),
                              title: Text(courseForm.name),
                              subtitle: Text(courseForm.address),
                              trailing:courseForm.isConfirmed ? null: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  elevation: 0,
                                  ),
                                onPressed: (){
                                  _enController.confirmEnrollment(
                                    collection: courseFormCollection,
                                    resourceId: courseForm.id, 
                                    userId: courseForm.userID, 
                                    cost: courseForm.price.price);
                                }, 
                                child: Text("Confirm",style: TextStyle(color: Colors.white,)),
                                ),
                            ),
                          ),
                        ),
                      );
                       });
                    },
                    ) : const SizedBox();
                }
              ),
            ),
          ],
        );
  }
}


class DrivingLicenceListView extends StatelessWidget {
  const DrivingLicenceListView({
    Key? key,
    required HomeController controller,
    required EnrollmentController enController,
  }) : _controller = controller, _enController = enController, super(key: key);

  final HomeController _controller;
  final EnrollmentController _enController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Prepay
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.PrePay ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.PrePay), 
                    child: Text("Prepay"),
                    ),),
                    //Space
                    const SizedBox(width: 20),
                  //CashOn
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.CashOnDelivery), 
                    child: Text("CashOn"),
                    ),),
                ],
              )
            ),
        Obx(
       () {
        return Expanded(
          child: ListView.builder(
            itemCount: _controller.drivingLicenceFormList.length,
            itemBuilder: (context,index){
              final courseForm = _controller.drivingLicenceFormList[index];
              return Obx((){
                if(courseForm.bankSlipImage == null && _enController.selectedPaymentMethod.value == PaymentOptions.PrePay){
                return const SizedBox();
              }
              if(!(courseForm.bankSlipImage == null) && _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery){
                return const SizedBox();
              }
              return SizedBox(
                height: 85,
                child: Card(
                  child: Center(
                    child: ListTile(
                      onTap: () => Get.to(() => DrivingLicenceFormDetail(drivingLicenceForm: courseForm)),
                      leading: bankSlipImageWidget(courseForm.bankSlipImage,context),
                      title: Text(courseForm.name),
                      subtitle: Text(courseForm.address),
                      trailing:courseForm.isConfirmed ? null: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black,),
                        onPressed: (){
                          _enController.confirmEnrollment(
                            collection: drivingLicenceCollection,
                            resourceId: courseForm.id, 
                            userId: courseForm.userId, 
                            cost: courseForm.cost,
                            );
                        }, 
                        child: Text("Confirm",style: TextStyle(color: Colors.white,)),
                        ),
                    ),
                  ),
                ),
              );
              });
            },
            ),
        );
      }
    ),
      ]
    );
  }}

  
class CarLicenceFormListView extends StatelessWidget {
  const CarLicenceFormListView({
    Key? key,
    required HomeController controller,
    required EnrollmentController enController,
  }) : _controller = controller, _enController = enController, super(key: key);

  final HomeController _controller;
  final EnrollmentController _enController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Prepay
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.PrePay ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.PrePay), 
                    child: Text("Prepay"),
                    ),),
                    //Space
                    const SizedBox(width: 20),
                  //CashOn
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery ?
                      Colors.black : Colors.grey,
                    ),
                    onPressed: () => _enController.setPaymentMethod(PaymentOptions.CashOnDelivery), 
                    child: Text("CashOn"),
                    ),),
                ],
              ),),
        Obx(
       () {
        return Expanded(
          child: ListView.builder(
            itemCount: _controller.carLicenceFormList.length,
            itemBuilder: (context,index){
              final courseForm = _controller.carLicenceFormList[index];
               return Obx((){
                if(courseForm.bankSlipImage == null && _enController.selectedPaymentMethod.value == PaymentOptions.PrePay){
                return const SizedBox();
              }
              if(!(courseForm.bankSlipImage == null) && _enController.selectedPaymentMethod.value == PaymentOptions.CashOnDelivery){
                return const SizedBox();
              }
              return SizedBox(
                height: 85,
                child: Card(
                  child: Center(
                    child: ListTile(
                      onTap: () => Get.to(() => CarFormDetail(carLicenceForm: courseForm)),
                      leading: bankSlipImageWidget(courseForm.bankSlipImage,context),
                      title: Text(courseForm.name),
                      subtitle: Text(courseForm.address),
                      trailing:courseForm.isConfirmed ? null: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black,),
                        onPressed: (){
                          _enController.confirmEnrollment(
                            collection: carLicenceCollection,
                            resourceId: courseForm.id, 
                            userId: courseForm.userId, 
                            cost: courseForm.cost,
                            );
                        }, 
                        child: Text("Confirm",style: TextStyle(color: Colors.white,)),
                        ),
                    ),
                  ),
                ),
              );
               });
            },
            ),
        );
      }
    ),
      ],
    );
  }}

class CustomPhotoViewer extends StatelessWidget {
  final String heroTags;
  const CustomPhotoViewer({Key? key,required this.heroTags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: PhotoView(
              imageProvider: NetworkImage(heroTags),
              loadingBuilder: (context, progress) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: const CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration:
                  BoxDecoration(color: Colors.white.withOpacity(0)),
              gaplessPlayback: false,
              //customSize: MediaQuery.of(context).size,
              heroAttributes: PhotoViewHeroAttributes(
                tag: heroTags,
                transitionOnUserGestures: true,
              ),
              //scaleStateChangedCallback: this.onScaleStateChanged,
              enableRotation: true,
              //controller:  controller,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 3,
              initialScale: PhotoViewComputedScale.contained,
              basePosition: Alignment.center,
              //scaleStateCycle: scaleStateCycle
            ),
          
        ),
      ),
    );
  }
}
  
  //PhotoViewer
  Widget photoViewer({required String heroTags}) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PhotoView(
          imageProvider: NetworkImage(heroTags),
          loadingBuilder: (context, progress) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: const CircularProgressIndicator(),
            ),
          ),
          backgroundDecoration:
              BoxDecoration(color: Colors.white.withOpacity(0)),
          gaplessPlayback: false,
          //customSize: MediaQuery.of(context).size,
          heroAttributes: PhotoViewHeroAttributes(
            tag: heroTags,
            transitionOnUserGestures: true,
          ),
          //scaleStateChangedCallback: this.onScaleStateChanged,
          enableRotation: true,
          //controller:  controller,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 3,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
          //scaleStateCycle: scaleStateCycle
        ),
      ),
    );
  }

  Widget bankSlipImageWidget(String? imageURL,BuildContext context){
    if(imageURL == null){
      return const SizedBox();
    }
    return InkWell(
                      onTap: () {
                        showDialog(
                          //barrierColor: Colors.white.withOpacity(0),
                          context: Get.context!,
                          builder: (context) {
                            return photoViewer(
                                heroTags: imageURL);
                          },
                        );
                      },
                      child:  CachedNetworkImage(
                          imageUrl:
                         imageURL,
                         width: 50,
                         height: 100,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, status) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  value: status.progress,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                    );
  }
  
  class PurchaseModelList extends StatelessWidget {
  const PurchaseModelList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return  ListView.builder(
                    itemCount: _homeController.purchaseModelList.length,
                    itemBuilder: (context,index){
                      final purchase = _homeController.purchaseModelList[index];
                       
                      return SizedBox(
                        height: 85,
                        child: Card(
                          child: Center(
                            child: ListTile(
                              onTap: () => Get.to(() => PurchaseModelDetail(purchaseModel: purchase)),
                              title: Text(purchase.name),
                              subtitle: Text(purchase.address),
                             ),
                            ),
                          ),
                    
                      );
                    },
                    );
  }
}