class ForgotPasswordResponse {
  String success;
  String message;
  String otp;

  ForgotPasswordResponse({this.success, this.message, this.otp});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    otp = json['otp'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}
