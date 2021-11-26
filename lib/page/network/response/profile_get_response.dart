class ProfileGetResponse {
  String success;
  String message;
  List<Details>details;

  ProfileGetResponse({this.success, this.message, this.details});

  ProfileGetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String name;
  String email;
  String phone;
  String firstname;
  String lastname;
  String vehicletype;
  String gender;

  Details({this.name, this.email,this.firstname,this.lastname, this.phone, this.vehicletype, this.gender});

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    firstname = json['firstname'].toString();
    lastname = json['lastname'].toString();
    vehicletype = json['vehicletype'].toString();
    gender = json['gender'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['vehicletype'] = this.vehicletype;
    data['gender'] = this.gender;
    return data;
  }
}
