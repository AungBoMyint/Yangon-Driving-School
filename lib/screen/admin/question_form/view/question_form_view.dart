import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/main_question_management/view/main_question_management_view.dart';
import 'package:hammies_user/screen/admin/question_form/controller/question_form_controller.dart';

import '../../../../controller/home_controller.dart';
import '../../../../routes/routes.dart';

class QuestionFormView extends StatefulWidget {
  const QuestionFormView({Key? key}) : super(key: key);

  @override
  State<QuestionFormView> createState() => _QuestionFormViewState();
}

class _QuestionFormViewState extends State<QuestionFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final QuestionFormController _controller = Get.find();
    final HomeController _homeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black,),
          title: const Center(child: Text("မေးခွန်း အုပ်စုများ")),
        ),
        body:  Obx(
                  () {
                    if(_controller.isLoading.value){
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (_controller.mainQuestionList.isEmpty) {
                      return const Center(
                          child: Text(
                        "No questions yet....",
                      ));
                    }

                    return Container(
                      child: SingleChildScrollView(
                        child:  ExpansionPanelList(
                          animationDuration: const Duration(seconds: 1),
                                  expansionCallback: (index,bool){
                                    _controller.setExpandedOrCollapsed(index, bool);
                                  },
                                  children: _controller.mainQuestionList.map((element) {
                                   
                                        
                                    return ExpansionPanel(
                                      isExpanded: element.isExpanded!,
                                      headerBuilder: (_,__){
                                        return SwipeActionCell(
                                                    
                                          backgroundColor: Colors.white,
                                          key: Key(element.id),
                                          leadingActions: [
                                            SwipeAction(
                                              widthSpace: 50,
                                              color: Colors.amber,
                                              title: "Edit",
                                              style: const TextStyle(fontSize: 14, color: Colors.white),
                                              onTap: (CompletionHandler _) async {
                                                        await _(false);
                                                        _homeController.setMainQuestion(element);
                                                       Get.defaultDialog(
                                                        title: "Update Main Question",
                                                      content: MainQuestionManagementView(question: element),
                                                    );
                                                }
                                              ),
                                              SwipeAction(
                                              widthSpace: 50,
                                              color: Colors.green,
                                              title: "Add",
                                              style: const TextStyle(fontSize: 14, color: Colors.white,
                                              overflow: TextOverflow.visible,
                                            
                                              ),
                                              onTap: (CompletionHandler _) async {
                                                        await _(false);
                                                      _homeController.setMainQuestion(element);
                                                      _homeController.setEditSubQuestion(null);
                                                      Get.toNamed(subQuestionManagementScreen);
                                                }
                                              ),
                                              SwipeAction(
                                              widthSpace: 50,
                                              color: Colors.red,
                                              title: "Delete",
                                              style: const TextStyle(fontSize: 14, color: Colors.white,
                                              overflow: TextOverflow.visible,
                                            
                                              ),
                                              onTap: (CompletionHandler _) async {
                                                        await _(false);
                                                     Get.defaultDialog(
                                                      title: "Warning!",
                                                      confirm: ElevatedButton(
                                                        onPressed: () => _controller.deleteMain(element), 
                                                        child: Text("Yes"),
                                                        ),
                                                      cancel:    ElevatedButton(
                                                        onPressed: () => Get.back(), 
                                                        child: Text("No"),
                                                        ),
                                                     );
                                                }
                                              ),
                                            ],
                                          child:   ListTile(
                                                leading: Text("${element.qNo}.",
                                                style: TextStyle(fontWeight: FontWeight.bold,)),
                                                title: Text(element.title,
                                                style: TextStyle(fontWeight: FontWeight.bold,)),
                                              ),
                                            
                                            
                                        );
                                      },
                                      body: Obx((){
                                         final subQuestionList = _controller.subQuestionMap.value![element.qNo]
                                        ?.entries.map((e) => e.value).toList();
                                        return !(subQuestionList == null) &&  (subQuestionList.isNotEmpty) ? SizedBox(
                                        height: subQuestionList.length * 60,
                                        child: ListView.builder(
                                          itemCount: subQuestionList.length,
                                          itemBuilder: (context,index){
                                            final subQ = subQuestionList[index];
                                            return SwipeActionCell(
                                                    
                                          backgroundColor: Colors.white,
                                          key: Key(element.id),
                                          leadingActions: [
                                            SwipeAction(
                                              widthSpace: 50,
                                              color: Colors.amber,
                                              title: "Edit",
                                              style: const TextStyle(fontSize: 14, color: Colors.white),
                                              onTap: (CompletionHandler _) async {
                                                        await _(false);
                                                       _homeController.setMainQuestion(element);
                                                      _homeController.setEditSubQuestion(subQ);
                                                      Get.toNamed(subQuestionManagementScreen);
                                                }
                                              ),
                                              SwipeAction(
                                              widthSpace: 50,
                                              color: Colors.red,
                                              title: "Delete",
                                              style: const TextStyle(fontSize: 14, color: Colors.white,
                                              overflow: TextOverflow.visible,
                                            
                                              ),
                                              onTap: (CompletionHandler _) async {
                                                        await _(false);
                                                     Get.defaultDialog(
                                                      title: "Warning!",
                                                      confirm: ElevatedButton(
                                                        onPressed: () => _controller.deleteSubQuestion(element,subQ), 
                                                        child: Text("Yes"),
                                                        ),
                                                      cancel:    ElevatedButton(
                                                        onPressed: () => Get.back(), 
                                                        child: Text("No"),
                                                        ),
                                                     );
                                                }
                                              ),
                                            ],
                                              child: Center(
                                                child: ListTile(
                                                          onTap: () {
                                                           
                                                          },
                                                          leading: Text(subQ.qNo.toString()),
                                                          title: Text(subQ.title),
                                                          subtitle: Text(subQ.description),
                                                          trailing: Text(subQ.answer),
                                                        ),
                                              ),
                                            );
                                          },
                                          ),
                                      ): const SizedBox();
                                      })
                                    );
                                  } ).toList(),
                                )
                          
                      ),
                    );
                  },
                ),
        
        floatingActionButton: InkWell(
          onTap: (){
            Get.defaultDialog(
              title: "Add Main Question",
              content: MainQuestionManagementView(),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
      );
  }
}

