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
  String replacePlaceholders(String text, List<dynamic>? values, Map<String, dynamic>? variableDefaults) {
  return text.replaceAllMapped(
    RegExp(r'\$(\d+)'), 
    (match) {
      int index = int.tryParse(match.group(1)!) ?? 0; 

      if (values != null && index <= values.length) {
        return values[index - 1].toString();
      } else {
        String placeholder = '\$$index';
        dynamic defaultValue = variableDefaults?[placeholder];

        if (defaultValue != null) {
          if (defaultValue is Map<String, dynamic> && defaultValue.containsKey('values')) {
            return (defaultValue['values'] as List<dynamic>?)?[index - 1].toString() ?? match.group(0)!;
          } else {
            return defaultValue["default_value"].toString();
          }
        }

        return match.group(0)!;
      }
    },
  );
}



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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        style: TextStyle(color: widget.myColor),
                      ),
                    ),
                  ),
                ),
                if (widget.criteria != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.criteria!.map((c) {
                        String updatedText = c.type == 'variable'
                            ? replacePlaceholders(
                                c.text ?? '',
                                (c.variable?['values'] as List<dynamic>?)
                                    ?.reversed
                                    .toList(),
                                c.variable,
                              )
                            : c.text ?? '';

                        return ListTile(
                          subtitle: Text(updatedText,
                              style: TextStyle(color: Colors.white)),
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
