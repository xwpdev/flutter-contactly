class Voter {
  String firstName;
  String lastName;
  String address;
  int districtId;
  String districtName;
  int postOfficeId;
  String postalCode;
  int pollingDivisionId;
  String pollingDivisionName;
  int pollingCentreId;
  String pollingCentreName;
  String email = '';
  String phone = '';
  int adminUserId;

  Map<String, dynamic> toJson() => _itemToJson(this);

  Map<String, dynamic> _itemToJson(Voter instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'districtId': instance.districtId.toString(),
      'districtName': instance.districtName,
      'postOfficeId': instance.postOfficeId.toString(),
      'postalCode': instance.postalCode,
      'pollingDivisionId': instance.pollingDivisionId.toString(),
      'pollingCentreId': instance.pollingCentreId.toString(),
      'email': instance.email,
      'phone': instance.phone,
      'adminUserId': instance.adminUserId.toString()
    };
  }
}
