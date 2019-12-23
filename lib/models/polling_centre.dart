class PollingCentre {
  int id;
  String name;
  int divisionId;

  PollingCentre(this.id, this.name);

  PollingCentre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        divisionId = json['divisionId'];
}
