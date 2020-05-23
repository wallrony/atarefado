class TODO {
  int id;
  String name;
  String description;
  String date;
  bool realized;

  TODO({ this.id, this.name, this.description, this.date, this.realized });

  TODO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    date = json['todo_date'];
    realized = json['realized'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['todo_date'] = this.date;
    data['realized'] = this.realized ? 1 : 0;
    return data;
  }
}