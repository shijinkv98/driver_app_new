class SuccessResponse {
  String success;
  String message;

  SuccessResponse(this.message, this.success);

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    success = json['success'].toString();
  }
}
