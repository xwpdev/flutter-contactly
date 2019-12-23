class PostOffice {
  int id;
  String name;
  String postalCode;

  PostOffice(this.id, this.name);

  PostOffice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        postalCode = json['postalCode'];
}
