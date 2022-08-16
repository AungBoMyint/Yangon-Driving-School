import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hammies_user/model/question/question.dart';
import 'package:hammies_user/screen/admin/main_question_management/controller/main_question_controller.dart';

class MainQuestionManagementView extends StatefulWidget {
  final Question? question;
  const MainQuestionManagementView({Key? key,this.question}) : super(key: key);

  @override
  State<MainQuestionManagementView> createState() => _MainQuestionManagementViewState();
}

class _MainQuestionManagementViewState extends State<MainQuestionManagementView> {
  late MainQuestionManagementController _controller;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    Get.put(MainQuestionManagementController());
    _controller =  Get.find();
    _controller.inputMap.putIfAbsent("qNo", () => 
    TextEditingController()..text = widget.question?.qNo.toString() ?? "");
    _controller.inputMap.putIfAbsent("title", () => 
    TextEditingController()..text = widget.question?.title.toString() ?? "");
    super.initState();
  }

  @override
  void dispose() {
    Get.delete();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                isOptional: true,
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
                _controller.newOrUpdateMainQuestion(widget.question?.id);
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
    );
       /*  bottomNavigationBar: SizedBox(
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
                _controller.newOrUpdateMainQuestion(widget.question?.id);
                debugPrint("***********Validating is Validate*****");
              }else{
                debugPrint("*********Invalid*****");
              }
            }, child: Text("Submit")),
          ),
        ),
    ); */
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
  final MainQuestionManagementController _controller = Get.find();

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

