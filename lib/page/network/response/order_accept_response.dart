class OrderAccptResponse {
  String success;
  String message;

  OrderAccptResponse({this.success, this.message});

  OrderAccptResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'].toString();
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
