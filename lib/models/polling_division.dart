class PollingDivision {
  int id;
  String name;
  int districtId;

  PollingDivision(this.id, this.name);

  PollingDivision.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        districtId = json['districtId'];
}
