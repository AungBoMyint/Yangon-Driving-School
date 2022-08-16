import 'package:flutter/material.dart';

import '../../model/radio/radio_model.dart';

class RadioTypeWidget<T> extends StatefulWidget {
  final int count;
  final String title;
  final double? nameWidth;
  final List<RadioModel> labelList;
  final T groupValue;
  final void Function(T t) onChanged;
  final double? titleWidth;
  final double? eachCountHeight;
  final double? highSpace;
  const RadioTypeWidget({Key? key,
  required this.title,
  required this.count,
  required this.labelList,
  required this.onChanged,
  required this.groupValue,
  this.nameWidth,
  this.highSpace,
  this.titleWidth,
  this.eachCountHeight,
  }) : super(key: key);

  @override
  State<RadioTypeWidget<T>> createState() => _RadioTypeWidgetState<T>();
}

class _RadioTypeWidgetState<T> extends State<RadioTypeWidget<T>> {

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValue;
  }
 
   T? groupValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.count * 50) + (widget.eachCountHeight ?? 50),
      padding: const EdgeInsets.only(left: 20,bottom: 5,),
      child: Column(
        children: [
          SizedBox(
                      width: widget.titleWidth,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,

              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.count,
              itemBuilder: (context,index){
                return Padding(
                  padding:  EdgeInsets.only(bottom: widget.highSpace ?? 0),
                  child: Row(
                    children: [
                      //Label
                      
                         SizedBox(
                          width: widget.nameWidth,
                           child: Text(widget.labelList[index].name,
                        style: TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.visible,
                        )),
                         ),
                      
                      //Radio
                       Radio<T>(
                            value: widget.labelList[index].value, 
                            groupValue: groupValue, 
                            onChanged: (value){
                              setState(() {
                                groupValue = value;
                              });
                              widget.onChanged(value!);
                            },
                            ),
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