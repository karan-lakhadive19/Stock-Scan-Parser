// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  final List<dynamic>? values;
  final dynamic defaultValue;
  String name;

  NextScreen(
      {required this.values, required this.defaultValue, required this.name});

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  TextEditingController _textFieldController = TextEditingController();
  List<dynamic>? sortedValues;

  String extractString(String name) {
    int spaceIndex = name.indexOf(' ');

    return spaceIndex != -1 ? name.substring(0, spaceIndex) : name;
  }

  @override
  void initState() {
    super.initState();
    if (widget.values != null) {
      sortedValues = List.from(widget.values!)..sort();
    }
    _textFieldController.text = widget.defaultValue?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          height: 400,
          color: Color(0xff01131B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sortedValues != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedValues!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Text(
                                sortedValues![index].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(height: 1, color: Colors.white,),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              if (widget.defaultValue != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${extractString(widget.name)}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Set Parameters",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Period",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: TextField(
                                        controller: _textFieldController,
                                        decoration: InputDecoration(
                                          hintText: '${widget.defaultValue}',
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(8)),
                                          ),
                                          contentPadding:
                                              EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
