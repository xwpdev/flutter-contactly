class User {
  String username;
  String password;
  String name;
  String districtId;

  Map<String, dynamic> toJson() => _itemToJson(this);

  Map<String, dynamic> _itemToJson(User instance) {
    return <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'districtId': instance.districtId
    };
  }
}
