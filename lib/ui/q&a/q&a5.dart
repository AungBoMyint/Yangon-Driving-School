import 'package:flutter/material.dart';

class Item {
  Item({
    required this.id,
    required this.name,
    required this.description,
    this.isExpanded = false,
  });

  int id;
  String name;
  String description;
  bool isExpanded;
}

class QandA5 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return QandA5State();
  }
}

class QandA5State extends State<QandA5> {

  late List<Item> _items;

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  List<Item> _generateItems() {
    return List.generate(50, (int index) {
      return Item(
        id: index,
        name: 'Item $index',
        description: 'Details of item $index',
      );
    });
  }

  ExpansionPanel _buildExpansionPanel(Item item) {
    return ExpansionPanel(
      isExpanded: item.isExpanded,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(item.name),
          ),
        );
      },
      body: ListTile(
        title: Text(item.description),
      ),
    );
  }

  ExpansionPanelRadio _buildExpansionPanelRadio(Item item) {
    return ExpansionPanelRadio(
      value: item.id,
      backgroundColor: Colors.white,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(item.name),
          ),
        );
      },
      body: ListTile(
        title: Text(item.description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text("Questions & Answers",
      //   style: TextStyle(color: Colors.black,
      //   letterSpacing: 1,wordSpacing: 1),),
      //   elevation: 0,
      //   iconTheme: IconThemeData(
      //       color: Colors.black
      //   ),
      // ),


      body: SingleChildScrollView(
        child: ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 500),
          expandedHeaderPadding: EdgeInsets.all(10),
          dividerColor: Colors.grey,
          elevation: 4,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !isExpanded;
            });
          },
          children: _items.map((item) => _buildExpansionPanel(item))
              .toList(),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: ExpansionPanelList.radio(
      //     animationDuration: const Duration(milliseconds: 500),
      //     expandedHeaderPadding: EdgeInsets.all(10),
      //     elevation: 0,
      //     initialOpenPanelValue: 3,
      //     expansionCallback: (int index, bool isExpanded) {
      //       setState(() {
      //         _items[index].isExpanded = !isExpanded;
      //       });
      //     },
      //     children: _items.map((item) => _buildExpansionPanelRadio(item))
      //         .toList(),
      //   ),
      // ),
    );
  }
}