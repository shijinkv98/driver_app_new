class VehicleResponse {
  String success;
  String message;
  List<Vehicle> vehicle;

  VehicleResponse({this.success, this.message, this.vehicle});

  VehicleResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    if (json['details'] != null) {
      vehicle = new List<Vehicle>();
      json['details'].forEach((v) {
        vehicle.add(new Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.vehicle != null) {
      data['details'] = this.vehicle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicle {
  String id;
  String type;

  Vehicle({this.id, this.type});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
