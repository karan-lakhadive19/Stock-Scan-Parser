import 'package:flutter/material.dart';
import 'package:stock_scan_parser/data/models/stock_model.dart';

class Description extends StatefulWidget {
  String name;
  String tag;
  Color myColor; 
  final List<Criteria>? criteria;

  Description({
    Key? key,
    required this.name,
    required this.tag,
    required this.criteria,
    required this.myColor,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            height: 400,
            color: Color(0xff01131B),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    color: Color(0xff1686b0),
                    height: 100,
                    child: ListTile(
                      title: Text(
                        widget.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        widget.tag,
                        style: TextStyle(color: widget.myColor), // Use widget.myColor directly
                      ),
                    ),
                  ),
                ),
                if (widget.criteria != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.criteria!.map((c) {
                        return ListTile(
                          subtitle: Text(c.text ?? '', style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
