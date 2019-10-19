class CustomResponse {
  int code;
  String message;
  dynamic data;

  CustomResponse(this.code, this.message, this.data);

  CustomResponse.fromJson(Map<String, dynamic> json)
      : code = json["Code"],
        message = json["Message"],
        data = json["Data"];
}
