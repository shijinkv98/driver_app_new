class DeliveryPaymentResponse {
  String success;
  String message;
  String total;
  String orderid;
  String paymenttype;

  DeliveryPaymentResponse(
      {this.success, this.message, this.total, this.orderid, this.paymenttype});

  DeliveryPaymentResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'].toString();
    message = json['message'].toString();
    total = json['Total'].toString();
    orderid = json['Orderid'].toString();
    paymenttype = json['Paymenttype'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['message'] = this.message;
    data['Total'] = this.total;
    data['Orderid'] = this.orderid;
    data['Paymenttype'] = this.paymenttype;
    return data;
  }
}
