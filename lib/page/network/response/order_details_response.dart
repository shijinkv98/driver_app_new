class OrderDetailsResponse {
  String success;
  String message;
  List<Orders> orders;
  String total;

  OrderDetailsResponse({this.success, this.message, this.orders, this.total});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Orders {
  String orderdetailid;
  String orderid;
  String product;
  String productId;
  String description;
  String image;
  String price;
  String quantity;
  String orderslno;
  String accepted;
  String status;
  String ordertype;
  String datentime;
  String cusname;
  String paymentmod;
  String shopname;
  List<Deliveryaddress> deliveryaddress;
  List<Companyaddress> companyaddress;

  Orders(
      {this.orderdetailid,
        this.orderid,
        this.product,
        this.productId,
        this.description,
        this.image,
        this.price,
        this.quantity,
        this.orderslno,
        this.accepted,
        this.status,
        this.ordertype,
        this.datentime,
        this.cusname,
        this.paymentmod,
        this.shopname,
        this.deliveryaddress,
        this.companyaddress});

  Orders.fromJson(Map<String, dynamic> json) {
    orderdetailid = json['orderdetailid'].toString();
    orderid = json['orderid'].toString();
    product = json['product'].toString();
    productId = json['product_id'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    orderslno = json['orderslno'].toString();
    accepted = json['accepted'].toString();
    status = json['status'].toString();
    ordertype = json['ordertype'].toString();
    datentime = json['datentime'].toString();
    cusname = json['cusname'].toString();
    paymentmod = json['paymentmod'].toString();
    shopname = json['shopname'].toString();
    if (json['deliveryaddress'] != null) {
      deliveryaddress = new List<Deliveryaddress>();
      json['deliveryaddress'].forEach((v) {
        deliveryaddress.add(new Deliveryaddress.fromJson(v));
      });
    }
    if (json['companyaddress'] != null) {
      companyaddress = new List<Companyaddress>();
      json['companyaddress'].forEach((v) {
        companyaddress.add(new Companyaddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderdetailid'] = this.orderdetailid;
    data['orderid'] = this.orderid;
    data['product'] = this.product;
    data['product_id'] = this.productId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['orderslno'] = this.orderslno;
    data['accepted'] = this.accepted;
    data['status'] = this.status;
    data['ordertype'] = this.ordertype;
    data['datentime'] = this.datentime;
    data['cusname'] = this.cusname;
    data['paymentmod'] = this.paymentmod;
    data['shopname'] = this.shopname;
    if (this.deliveryaddress != null) {
      data['deliveryaddress'] =
          this.deliveryaddress.map((v) => v.toJson()).toList();
    }
    if (this.companyaddress != null) {
      data['companyaddress'] =
          this.companyaddress.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deliveryaddress {
  String nameAdress;
  String house;
  String roadName;
  String streetName;
  String state;
  String country;
  String latitude;
  String long;
  String mobile;

  Deliveryaddress(
      {this.nameAdress,
        this.house,
        this.roadName,
        this.streetName,
        this.state,
        this.country,
        this.latitude,
        this.long,
        this.mobile});

  Deliveryaddress.fromJson(Map<String, dynamic> json) {
    nameAdress = json['name_adress'].toString();
    house = json['house'].toString();
    roadName = json['road_name'].toString();
    streetName = json['street_name'].toString();
    state = json['state'].toString();
    country = json['country'].toString();
    latitude = json['latitude'].toString();
    long = json['long'].toString();
    mobile = json['mobile'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_adress'] = this.nameAdress;
    data['house'] = this.house;
    data['road_name'] = this.roadName;
    data['street_name'] = this.streetName;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['long'] = this.long;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Companyaddress {
  String address;
  String lat;
  String long;

  Companyaddress({this.address, this.lat, this.long});

  Companyaddress.fromJson(Map<String, dynamic> json) {
    address = json['address'].toString();
    lat = json['lat'].toString();
    long = json['long'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
