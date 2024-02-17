import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/data/models/stock_model.dart';
import 'package:stock_scan_parser/presentation/pages/next_screen.dart';

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
  RichText replacePlaceholders(String text, List<dynamic>? values,
      Map<String, dynamic>? variableDefaults) {
    List<InlineSpan> children = [];

    text.splitMapJoin(
      RegExp(r'\$(\d+)'),
      onMatch: (Match match) {
        int index = int.tryParse(match.group(1)!) ?? 0;

        if (values != null && index <= values.length) {
          children.add(
            TextSpan(
              text: values[0].toString(),
              style: TextStyle(color: Colors.deepPurpleAccent, decoration: TextDecoration.underline,),
            ),
          );
        } else {
          String placeholder = '\$$index';
          dynamic defaultValue = variableDefaults?[placeholder];

          if (defaultValue != null) {
            if (defaultValue is Map<String, dynamic> &&
                defaultValue.containsKey('values')) {
              String replacedValue =
                  (defaultValue['values'] as List<dynamic>?)?[0]
                          .toString() ??
                      match.group(0)!;
              children.add(
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextScreen(
                            values: defaultValue["values"],
                            defaultValue: defaultValue["default_value"],
                            name: widget.name,
                          ),
                        ),
                      );
                    },
                  text: "(${replacedValue.toString()})",
                  style: TextStyle(color: Colors.deepPurpleAccent, decoration: TextDecoration.underline),
                ),
              );
            } else {
              children.add(
                TextSpan(
                  recognizer: TapGestureRecognizer()
                  ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextScreen(
                            values: defaultValue["values"],
                            defaultValue: defaultValue["default_value"].toString(),
                            name: widget.name,
                          ),
                        ),
                      );
                    },
                  text: "(${defaultValue["default_value"].toString()})",
                  style: TextStyle(color: Colors.deepPurpleAccent, decoration: TextDecoration.underline),
                ),
              );
            }
          } else {
            children.add(TextSpan(text: match.group(0)!));
          }
        }
        return '';
      },
      onNonMatch: (String nonMatch) {
        children.add(TextSpan(text: nonMatch));
        return '';
      },
    );

    return RichText(text: TextSpan(children: children));
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
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.criteria!.map((c) {
                    return ListTile(
                      subtitle: replacePlaceholders(
                        c.text ?? '',
                        c.variable?['values'] as List<dynamic>?,
                        c.variable,
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}