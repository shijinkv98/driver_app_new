class LoanListResponse {
  String success;
  String message;
  String balance;
  List<Data> data;

  LoanListResponse({this.success, this.message,this.balance, this.data});

  LoanListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    balance = json['balance'].toString();
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['balance'] = this.balance;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String reqstId;
  String driverId;
  String amount;
  String loanStatus;
  String dateRequested;

  Data(
      {this.reqstId,
        this.driverId,
        this.amount,
        this.loanStatus,
        this.dateRequested});

  Data.fromJson(Map<String, dynamic> json) {
    reqstId = json['reqst_id'];
    driverId = json['driver_id'];
    amount = json['amount'];
    loanStatus = json['loan_status'];
    dateRequested = json['date_requested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reqst_id'] = this.reqstId;
    data['driver_id'] = this.driverId;
    data['amount'] = this.amount;
    data['loan_status'] = this.loanStatus;
    data['date_requested'] = this.dateRequested;
    return data;
  }
}
