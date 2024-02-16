class StockModel {
  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criteria>? criteria;

  StockModel({this.id, this.name, this.tag, this.color, this.criteria});

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    color = json['color'];
    if (json['criteria'] != null) {
      criteria = <Criteria>[];
      json['criteria'].forEach((v) {
        criteria!.add(new Criteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['color'] = this.color;
    if (this.criteria != null) {
      data['criteria'] = this.criteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Criteria {
  String? type;
  String? text;

  Criteria({this.type, this.text});

  Criteria.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['text'] = this.text;
    return data;
  }
}