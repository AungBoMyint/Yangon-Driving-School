import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:hammies_user/screen/admin/sub_question_management/controller/sub_question_controller.dart';

class SubQuestionManagementView extends StatefulWidget {
  const SubQuestionManagementView({Key? key}) : super(key: key);

  @override
  State<SubQuestionManagementView> createState() => _SubQuestionManagementViewState();
}

class _SubQuestionManagementViewState extends State<SubQuestionManagementView> {
 final SubQuestionManagementController _controller = Get.find();
 final HomeController _homeController = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    var subQuestion = _homeController.editSubQuestion.value;
    _controller.inputMap.putIfAbsent("qNo", () => 
    TextEditingController()..text = subQuestion?.qNo.toString() ?? "");
    _controller.inputMap.putIfAbsent("title", () => 
    TextEditingController()..text = subQuestion?.title.toString() ?? "");
     _controller.inputMap.putIfAbsent("description", () => 
    TextEditingController()..text = subQuestion?.description.toString() ?? "");
     _controller.inputMap.putIfAbsent("answer", () => 
    TextEditingController()..text = subQuestion?.answer.toString() ?? "");
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                //QNo
                ChildTextFieldWidget(
                  fieldKey: "qNo", 
                  inputType: TextInputType.number,
                  maxLength: 2,
                  fieldName: "Question Number",
                  ),
                //Title
                ChildTextFieldWidget(
                  fieldKey: "title", 
                  fieldName: "Title",
                  ),
                  ChildTextFieldWidget(
                  fieldKey: "description", 
                  fieldName: "Description",
                  ),
                  ChildTextFieldWidget(
                  fieldKey: "answer", 
                  fieldName: "Answer",
                  ),
                  SizedBox(
            height: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: 
              () {
                _controller.pressedFirstTime();
                setState(() {
                });
                if(_controller.isValidate()){
                  _controller.newOrUpdateMainQuestion();
                  debugPrint("***********Validating is Validate*****");
                }else{
                  debugPrint("*********Invalid*****");
                }
              }, child: Text("Submit")),
            ),
          ),
              ],
              ),
          ),
      ),
    );
  }
}

class ChildTextFieldWidget extends StatefulWidget {
  final String fieldName;
  final String fieldKey;
  final bool isOptional;
  final TextInputType? inputType;
  final int? maxLength;
  const ChildTextFieldWidget({Key? key,required this.fieldKey,
  this.isOptional = false,
  this.inputType,
  this.maxLength,
  required this.fieldName,
  }) : super(key: key);

  @override
  State<ChildTextFieldWidget> createState() => _ChildTextFieldWidgetState();
}

class _ChildTextFieldWidgetState extends State<ChildTextFieldWidget> {
  final SubQuestionManagementController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Label
          Text(
            widget.fieldName,
            style: TextStyle(
              color: Colors.black,
              fontSize:16,
            ),
          ),
          const SizedBox(height: 15,),
          //TextField
          Expanded(
              child:  TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                  decoration: TextDecoration.none,
                ),
                scrollPadding: const EdgeInsets.all(5.0),
                onChanged: (value){
                  if(!(widget.isOptional)){
                    _controller.checkHasError(widget.fieldKey, value);
                  setState(() {
                  });
                  }
                },
                controller: _controller.inputMap[widget.fieldKey],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  isDense: true,
                   disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color:widget.isOptional ? Colors.grey : ( _controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey),
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: widget.isOptional ? Colors.grey : (_controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey),
                      )
                   ),
                   focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                       width: 2,
                        color:_controller.checkHasError(widget.fieldKey, _controller.inputMap[widget.fieldKey]?.text) ?
                       Colors.red : Colors.grey,
                      )
                   ),
                ),
                        ),
             
              ),
        ]
      ),
    );
  }
}