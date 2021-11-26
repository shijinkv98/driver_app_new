class CodBalanceResponse {
  String success;
  String message;
  String collected;
  String cashinhand;

  CodBalanceResponse(
      {this.success, this.message, this.collected, this.cashinhand});

  CodBalanceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    collected = json['collected'].toString();
    cashinhand = json['cashinhand'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['collected'] = this.collected;
    data['cashinhand'] = this.cashinhand;
    return data;
  }
}
