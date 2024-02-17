import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_scan_parser/data/models/stock_model.dart';
import 'package:stock_scan_parser/presentation/pages/description.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StockModel> home_list = [];

  Future<List<StockModel>> getdata() async {
    final response = await http.get(Uri.parse("http://coding-assignment.bombayrunning.com/data.json"));
    final data = jsonDecode(response.body.toString());
    List<StockModel> newList = [];

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        newList.add(StockModel.fromJson(i));
      }
    }

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    home_list = snapshot.data as List<StockModel>;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(color: Color(0xff01131B),),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Description(
                                        name: home_list[index].name.toString(),
                                        tag: home_list[index].tag.toString(),
                                        criteria: home_list[index].criteria,
                                        myColor: index<=2? Colors.green: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    home_list[index].name.toString(),
                                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                                  ),
                                  subtitle: Text(
                                    home_list[index].tag.toString(),
                                    style: index <= 2 ? TextStyle(color: Colors.green, decoration: TextDecoration.underline, decorationColor: Colors.white) : TextStyle(color: Colors.red, decoration: TextDecoration.underline, decorationColor: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: home_list.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}