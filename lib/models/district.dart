class District {
  int id;
  String name;

  District(this.id, this.name);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(json['id'], json['name']);
  }
}
