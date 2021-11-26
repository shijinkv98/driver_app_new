class NotificationResponse {
  String success;
  String message;
  List<Notifications> notifications;

  NotificationResponse({this.success, this.message, this.notifications});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String dateandtime;
  String image;
  String details;

  Notifications({this.dateandtime, this.image, this.details});

  Notifications.fromJson(Map<String, dynamic> json) {
    dateandtime = json['dateandtime'];
    image = json['image'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateandtime'] = this.dateandtime;
    data['image'] = this.image;
    data['details'] = this.details;
    return data;
  }
}
