class Voter {
  String firstName;
  String lastName;
  String address;
  int cityId;
  String cityName;
  String postalCode;
  String pollingDivision;
  String pollingCentre;
  String email = '';
  String phone = '';
  int adminUserId;

  Map<String, dynamic> toJson() => _itemToJson(this);

  Map<String, dynamic> _itemToJson(Voter instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'city': instance.cityId.toString(),
      'postalCode': instance.postalCode,
      'pollingDivision': instance.pollingDivision,
      'pollingCentre': instance.pollingCentre,
      'email': instance.email,
      'phone': instance.phone,
      'adminUserId': instance.adminUserId.toString()
    };
  }
}
