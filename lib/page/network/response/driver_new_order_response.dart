class DriverNewOrderResponse {
  String success;
  String message;
  String drivername;
  List<Orders> orders;

  DriverNewOrderResponse(
      {this.success, this.message, this.drivername, this.orders});

  DriverNewOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'].toString();
    drivername = json['drivername'].toString();
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['drivername'] = this.drivername;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
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
  String timendate;
  String paymentmode;
  String price;
  String quantity;
  String orderslno;
  String accepted;
  String status;

  Orders(
      {this.orderdetailid,
        this.orderid,
        this.product,
        this.productId,
        this.description,
        this.image,
        this.timendate,
        this.paymentmode,
        this.price,
        this.quantity,
        this.orderslno,
        this.accepted,
        this.status});

  Orders.fromJson(Map<String, dynamic> json) {
    orderdetailid = json['orderdetailid'].toString();
    orderid = json['orderid'].toString();
    product = json['product'].toString();
    productId = json['product_id'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
    timendate = json['timendate'].toString();
    paymentmode = json['paymentmode'].toString();
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    orderslno = json['orderslno'].toString();
    accepted = json['accepted'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderdetailid'] = this.orderdetailid;
    data['orderid'] = this.orderid;
    data['product'] = this.product;
    data['product_id'] = this.productId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['timendate'] = this.timendate;
    data['paymentmode'] = this.paymentmode;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['orderslno'] = this.orderslno;
    data['accepted'] = this.accepted;
    data['status'] = this.status;
    return data;
  }
}
