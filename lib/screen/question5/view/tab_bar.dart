import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/screen/question5/controller/q_controller.dart';

class QuestionTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final QuestionTabController _controller = Get.find();
    return Obx(
      () {
        if(_controller.isLoading.value){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                 Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("YANGON DRIVING SCHOOL",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        wordSpacing: 2,
                        letterSpacing: 2),
                    ),
                  ),
                ),
                  ])),
              body:const Center(
                child:  SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator()),
              ),
            );
        }
        return DefaultTabController(
          length: _controller.mainQuestionList.length,
          child: Scaffold(
              appBar: AppBar(
              
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("YANGON DRIVING SCHOOL",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        wordSpacing: 2,
                        letterSpacing: 2),
                    ),
                  ),
                ),
                  ],
                ),
                backgroundColor: Colors.grey,
                elevation: 0,
                bottom: TabBar(
              indicatorWeight: 10.0,
              tabs:  _controller.mainQuestionList.map((element) => Tab(
                text: element.title,
              ))
                .toList()
              ,
            ),
              ),
              body: Obx(
                 () {
                  /* final mainList = _controller.subQuestionMap.value?.entries
                  .map((element){
                    return {
                      element.key: element.value.entries.map((e) => e.value).toList(),
                    };
                  }).toList(); */
                  if(_controller.isSubTabLoading.value){
                    return TabBarView(children: List.generate(_controller.mainQuestionList.length, 
                    (index) => Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: const CircularProgressIndicator(),
                      ),
                    )));
                  }
                  return TabBarView(
                    children: _controller.subQuestionMap.value!.entries.map((e){
                      if(e.value.isEmpty){
                        return Tab(
                          child: Center(
                            child: Text("Empty"),
                          ),
                        );
                      }else{
                        return  SingleChildScrollView(
                            child: ExpansionPanelList(
                              expansionCallback: (index,value){
                                final subKey = e.value.entries.map((e) => e).toList()[index]
                                .value.qNo;
                                _controller.setExpandedOrCollapsed(
                                  e.key, subKey, value);
                              },
                              children: e.value.entries.map((subQ) => ExpansionPanel(
                                isExpanded: subQ.value.isExpanable!,
                                headerBuilder: (context, isExpanded) =>  ListTile(
                                  title: Text(subQ.value.title,
                                  style: TextStyle(
                                    fontSize: 14
                                  ),),
                                  subtitle: Text(subQ.value.description,
                                    style: TextStyle(
                                        fontSize: 13
                                    ),
                                  ),
                                ), 
                                body: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text(subQ.value.answer),
                                ),
                                )).toList(),
                            ),
                          
                        );
                      }
                    }).toList(),
                  );
                }
              ),
            ),
        );
      }
    );
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(itemBuilder: (context, index)=>ListTile(
      title: Text(s+' $index'),
    ));
  }
}

class CustomTabBar extends StatelessWidget with PreferredSizeWidget{
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuestionTabController _controller = Get.find();
    return Obx((){
      if(_controller.mainQuestionList.isEmpty){
        return const SizedBox();
      }
      return TabBar(
              indicatorWeight: 10.0,
              tabs:  _controller.mainQuestionList.map((element) => Tab(
                text: element.title,
              ))
                .toList()
              ,
            );
    });
  }
  
  @override
  Size get preferredSize => Size(double.infinity, 56);
}