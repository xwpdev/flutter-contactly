class VoterReq {
  String firstName;
  String lastName;
  String address;
  int pollingCentreId;
  int postOfficeId;
  String email = '';
  String phone = '';
  int adminUserId;

  Map<String, dynamic> toJson() => _itemToJson(this);

  Map<String, dynamic> _itemToJson(VoterReq instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'pollingCentreId': instance.pollingCentreId.toString(),
      'postOfficeId': instance.postOfficeId.toString(),
      'email': instance.email,
      'phone': instance.phone,
      'adminUserId': instance.adminUserId.toString()
    };
  }
}
