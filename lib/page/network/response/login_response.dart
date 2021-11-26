class LoginResponse {
  String success;
  String message;
  String drivertoken;
  String shopname;
  String mobile;
  String error;
  LoginResponse(
      {this.success,
        this.message,
        this.drivertoken,
        this.shopname,
        this.error,
        this.mobile});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    error = json['success'].toString();
    drivertoken = json['drivertoken'].toString();
    shopname = json['shopname'].toString();
    mobile = json['mobile'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['drivertoken'] = this.drivertoken;
    data['shopname'] = this.shopname;
    data['mobile'] = this.mobile;
    data['error'] = this.error;
    return data;
  }
}
