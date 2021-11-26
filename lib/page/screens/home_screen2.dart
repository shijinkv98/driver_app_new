import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projectname33/page/custom/custom_switch.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/cod_balance_response.dart';
import 'package:projectname33/page/network/response/driver_duty_response.dart';
import 'package:projectname33/page/network/response/order_accept_response.dart';
import 'package:projectname33/page/screens/settings.dart';
import 'package:projectname33/page/screens/update_status_new.dart';
import 'package:projectname33/page/screens/view_details_new.dart';
import 'balance_screen_new.dart';
import 'order_details_new.dart';
import 'report_re_assign_new.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenNew> {
  HomeScreenResponse homeScreenResponse;
  bool isSwitched = false;
  bool status = false;
  String _value = "";
  Timer timer;
  Position _location = Position(latitude: 0.0, longitude: 0.0);
  DateTime currentBackPressTime;

  void _displayCurrentLocation() async {
    final location = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => setState(() {}));
    _displayCurrentLocation();
    // showOngoingNotification(notifications,
    //     title: 'Tite', body: 'Body');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appBar(),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: FutureBuilder<HomeScreenResponse>(
          future:
              ApiCall().execute<HomeScreenResponse, Null>(HOME_PAGE_URL, null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              homeScreenResponse = snapshot.data;
              return getContent();
            } else if (snapshot.hasError) {
              return enableDataHome();
              // errorScreen('Error: ${snapshot.error}');
            }
            // else {
            //   homeScreenResponse.orders.length != '0' ? Align(
            //     alignment: Alignment.center,
            //     child:Container(
            //         width: MediaQuery.of(context).size.width,
            //         child:AlertDialog(
            //           backgroundColor: Colors.transparent,
            //           // title: setupAlertDialoadContainer(orders,context),
            //           // Container(child: Padding(
            //           //   padding: const EdgeInsets.all(8.0),
            //           //   child: Text('Pick Item',style: TextStyle(color: Colors.white),),
            //           // ),color: Colors.blueAccent,),
            //           content: setupAlertDialoadContainer(),
            //         )
            //     )
            // ): Align(child: Container(),);
            return progressBar;
            // }
          },
        ),
      ),
    );
  }

  Widget getContent() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              _titleName(),
              _tabSection(context),
            ],
          ),
        ),
        homeScreenResponse.orders.length != 0
            ? Align(
                alignment: Alignment.center,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      // title: setupAlertDialoadContainer(orders,context),
                      // Container(child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text('Pick Item',style: TextStyle(color: Colors.white),),
                      // ),color: Colors.blueAccent,),
                      content: setupAlertDialoadContainer(),
                    )))
            : Align(
                child: Container(),
              ),
        // homeScreenResponse.orders.length !=0? showOngoingNotification(notifications,
        //     title: 'New Order', body: 'Arrived'):Container(),
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomContainer(),
        )
      ],
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press Back Button again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> acceptOrder(int index) async {
    // _updateNotifier.isProgressShown = true;

    Map body = {
      // name,email,phone_number,password
      DECISION: "1",
      ORDER_ID: homeScreenResponse.orders[index].orderid
    };
    ApiCall()
        .execute<OrderAccptResponse, Null>(ORDER_ACCEPT_REJECT_URL, body)
        .then((OrderAccptResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
      }
      updateUI();
    });
  }

  Future<void> rejectOrder(int index) async {
    // _updateNotifier.isProgressShown = true;

    Map body = {
      // name,email,phone_number,password
      DECISION: "2",
      ORDER_ID: homeScreenResponse.orders[index].orderid
    };
    ApiCall()
        .execute<OrderAccptResponse, Null>(ORDER_ACCEPT_REJECT_URL, body)
        .then((OrderAccptResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
        NextPageReplacement(context, HomeScreenNew());
      }
    });
  }

  Widget _listOrdersDriver(Orders orders, index) {
    return ListTile(
      title: Card(
        margin: EdgeInsets.only(left: 0, right: 0),
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Orders',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8, right: 10, left: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 335,
                        child: Text(
                          '${'Order Id : '}${orders.orderid} ',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // width:MediaQuery.of(context).size.width -335,
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              child: Text(
                                orders.ordertime,
                                // task.createdAt,
                                style: TextStyle(
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  orderInfo4(orders),
                  // OrderInfo2(
                  //   order: task.order.length < 1 ? null : task.order.first,
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  orderInfo5(orders),
                  // OrderInfo1(
                  //   // order: task.order.length < 1 ? null : task.order.first,
                  //   task: task,
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Order status:',
                  //       style: TextStyle(
                  //         fontSize: 13.0,
                  //         color: Colors.black,
                  //         // fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 5.0,
                  //     ),
                  //     // Text('',
                  //     //   // task.statusText,
                  //     //   style: TextStyle(
                  //     //     fontSize: 14.0,
                  //     //     color: Colors.black,
                  //     //     fontWeight: FontWeight.w500,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: colorPrimary,
                          onPressed: () {
                            acceptOrder(index);

                            // Navigator.of(context).pushNamed('/homenew');
                            // NextPageReplacement(context,HomeScreenNew());
                            // orderUpdateStatus?.update(true, task, null);
                            // updateTaskApi(task);
                          },
                          child: new Text("Accept"),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: () {
                            // rejectOrder(index);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ReportReAssignNew(
                                            orders,
                                            homeScreenResponse
                                                .orders[index].orderid)));
                          },
                          textColor: Colors.white,
                          color: iconColor1,
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Reject",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderInfo5(Orders orders) {
    Ordersnew count = orders.ordersnew != null && orders.ordersnew.length > 0
        ? orders.ordersnew[0]
        : null;
    return Container(
      child: DecoratedBox(
        decoration: const BoxDecoration(
            // color: colorGrayBg,
            color: colorGrayBg,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // FadeInImage.assetNetwork(
                  //   width: 15.0,
                  //   height: 15,
                  //   fit: BoxFit.fitHeight,
                  //   placeholder: 'assets/images/quantity.png',
                  //   image: 'assets/images/quantity.png',
                  //   // image: orders.image,
                  //   // image: order?.packageInfo?.origination?.logo ?? '',
                  // ),

                    Image.asset("assets/images/quantity.png",width: 15.0,color: iconColor1, fit: BoxFit.contain,),

                  SizedBox(
                    width: 5,
                  ),
                  // Icon(Icons.line_style,
                  //     color: Color.fromARGB(255, 163, 148, 103)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: colorPrimary,
                        ),
                      ),
                      Text(
                        '${count.itemcount}${' Nos'}',
                        // '${order?.packageInfo?.packages?.first?.amount} Nos',
                        // '${task.totalQuantity} Nos',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     // Icon(Icons.line_weight, color: iconColor1),
              //     Image(
              //       image: AssetImage("assets/images/weight.png"),
              //       width: 15.0,
              //       color: iconColor1,
              //       fit: BoxFit.contain,
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           'Weight',
              //           style: TextStyle(
              //             fontSize: 10.0,
              //             color: colorPrimary,
              //           ),
              //         ),
              //         Text(
              //           "40 Kgs",
              //           // order?.packageInfo?.packages?.first?.weight ?? '',
              //           // task.totalWeight ?? '',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 10.0,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     // Icon(
              //     //   Icons.timelapse,
              //     //   color: iconColor1,
              //     // ),
              //     Image(
              //       image: AssetImage("assets/images/size.png"),
              //       width: 15.0,
              //       color: iconColor1,
              //       fit: BoxFit.contain,
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           'Size',
              //           style: TextStyle(
              //             fontSize: 10.0,
              //             color: colorPrimary,
              //           ),
              //         ),
              //         Text(
              //           "30 x 12",
              //           // order?.packageInfo?.packages?.first?.cost ?? '',
              //           // task.maxLength ?? '',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 10.0,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderInfo4(Orders orders) {
    Address deliAddress = orders.address != null && orders.address.length > 0
        ? orders.address[0]
        : null;
    return Row(
      children: <Widget>[
        Image.asset('assets/images/logo_1.png',width: 60,height: 60,),
        // FadeInImage.assetNetwork(
        //   width: 80.0,
        //   height: 80,
        //   fit: BoxFit.fitHeight,
        //   placeholder: 'assets/images/logo_1.png',
        //   // image: orders.customer_img,
        //   image:'assets/images/logo_1.png',
        //   // image: orders.image,
        //   // image: order?.packageInfo?.origination?.logo ?? '',
        // ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                deliAddress.name,
                // order?.packageInfo?.origination?.name ?? '',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${deliAddress.house}${' , '}${deliAddress.roadName}${' , '}${deliAddress.streetName}${' , '}${deliAddress.state}${' , '}${deliAddress.country}',

                // order?.packageInfo?.origination?.getAddress() ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget bottomContainer() {
    return Container(
      height: 50,
      color: colorPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/profilenew');
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "My Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.white,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Setting()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text("Settings", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleName() {
    if (homeScreenResponse.driver_duty == '1') status = true;
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            // margin: EdgeInsets.only(top: 15),
            child: Text(
                '${'Hi , '}${homeScreenResponse.firstname}${" "}${homeScreenResponse.lastname}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text(
                  "${'Total Amount Collected : '}${homeScreenResponse.totalamountcollected}",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3 - 130,
                margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                child: Text(
                  '',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 25,
            child: CustomSwitch(
              value: status,
              activeColor: colorPrimaryLight,
              activeTextColor: Colors.white,
              inactiveColor: iconColor1,
              inactiveTextColor: Colors.white,
              onChanged: (value) {
                status != true ? dutyupdate() : dutyoff();
                setState(() {
                  status = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> dutyupdate() async {
    Map body = {
      DUTY_ON: "1",
      // LATITUDE:_location.latitude,
      // LONGITUDE:_location.longitude
    };
    ApiCall()
        .execute<DriverDutyResponse, Null>(DUTY_ON_OFF, body)
        .then((DriverDutyResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);

        setState(() {
          NextPageReplacement(context, HomeScreenNew());
        });
      }
    });
  }

  Future<void> dutyoff() async {
    Map body = {DUTY_ON: "2"};
    ApiCall()
        .execute<DriverDutyResponse, Null>(DUTY_ON_OFF, body)
        .then((DriverDutyResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
        // NextPageReplacement(context, HomeScreenNew());
        setState(() {
          NextPageReplacement(context, HomeScreenNew());
        });
      }
    });
  }

  Widget _listOrders(Accepted accept, index) {
    return Container(
      color: colorGrayBg,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${'Order Id : '}${accept.orderid}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        // 'Order Id: ${task.orderId}'
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Text(
                              accept.ordertime,
                              // task.createdAt,
                              style: TextStyle(
                                  color: colorPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DecoratedBox(
                            decoration: const BoxDecoration(color: iconColor1),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 5.0, 20.0, 5.0),
                              child: Text(
                                accept.paymentmod,
                                // task.paymentMethod,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      orderInfoAccept(accept),
                      SizedBox(
                        height: 10.0,
                      ),
                      orderInfo1(accept),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Order status:',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            accept.orderstatus,
                            // task.statusText,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                padding: const EdgeInsets.all(8.0),
                                textColor: Colors.white,
                                color: colorPrimary,
                                onPressed: () {
                                  homeScreenResponse
                                              .accepted[index].orderstatus ==
                                          "Order Placed"
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  // UpdateStatusNew(accept,homeScreenResponse.accepted[index].orderid,homeScreenResponse.accepted[index].shipping)))
                                                  ViewDetailsNew(
                                                      accept: accept,
                                                      orderid:
                                                          homeScreenResponse
                                                              .accepted[index]
                                                              .orderid)))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  UpdateStatusNew(
                                                      accept: accept,
                                                      orderid:homeScreenResponse.accepted[index].orderid,
                                                      rupees: homeScreenResponse.accepted[index].rupees,
                                                      ordertotal:homeScreenResponse.accepted[index].ordertotal,
                                                      mode:homeScreenResponse.accepted[index].paymentmod,
                                                  )));
                                },
                                child: new Text("Update Status"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              OrderDetailsNew(
                                                  accept: accept,
                                                  orderid: accept.orderid,
                                                  firstname: homeScreenResponse
                                                      .firstname,
                                                  lastname: homeScreenResponse
                                                      .lastname,
                                                  acceptedorders:
                                                      accept.acceptedorders,
                                                  deliaddressacc:
                                                      accept.deliaddressacc,
                                                  duty_on: homeScreenResponse
                                                      .driver_duty)));
                                },
                                textColor: Colors.white,
                                color: iconColor1,
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "View Details",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // _getPadding(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _history(History history) {
    Deliaddresshis deliAddress =
        history.deliaddresshis != null && history.deliaddresshis.length > 0
            ? history.deliaddresshis[0]
            : null;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: colorGrayBg,
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 1),
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'Order Id : '}${history.orderid}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    // 'Order Id: ${task.orderId}'
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          history.ordertime,
                          // task.createdAt,
                          style: TextStyle(
                              color: colorPrimary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(color: iconColor1),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          child: Text(
                            history.paymentmod,
                            // task.paymentMethod,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FadeInImage.assetNetwork(
                      //   width: 15,
                      //   height: 15,
                      //   fit: BoxFit.fitHeight,
                      //   placeholder: 'assets/images/location-icon.png',
                      //   image: 'assets/images/location-icon.png',
                      //   // image: accept.image,
                      //   // image: order?.packageInfo?.origination?.logo ?? '',
                      // ),
                      Image.asset(
                        'assets/images/location-icon.png',
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Delivery Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  deliAddress != null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(deliAddress.name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                              Text(
                                  '${deliAddress.house}${","} ${deliAddress.road_name}${","} ${deliAddress.street_name}${","} ${deliAddress.state}${","} ${deliAddress.country}${","} ${deliAddress.mobile}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text("Order Status : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        Text(history.orderstatus,
                            style: TextStyle(
                                color: iconColor1,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderInfoAccept(Accepted accept) {
    Deliaddressacc acceptdeliAddress =
        accept.deliaddressacc != null && accept.deliaddressacc.length > 0
            ? accept.deliaddressacc[0]
            : null;
    return Row(
      children: <Widget>[
        FadeInImage.assetNetwork(
          width: 100.0,
          height: 60,
          fit: BoxFit.fitHeight,
          placeholder: 'assets/images/logo_1.png',
          image: accept.customer_image,
          // image: accept.image,
          // image: order?.packageInfo?.origination?.logo ?? '',
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                acceptdeliAddress.name,
                // order?.packageInfo?.origination?.name ?? '',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${acceptdeliAddress.house}${' , '}${acceptdeliAddress.road_name}${' , '}${acceptdeliAddress.street_name}${' , '}${acceptdeliAddress.state}${' , '}${acceptdeliAddress.country}',
                // order?.packageInfo?.origination?.getAddress() ?? '',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget orderInfo1(Accepted accept) {
    return Container(
      child: DecoratedBox(
        decoration: const BoxDecoration(
            // color: colorGrayBg,
            color: colorGrayBg,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // FadeInImage.assetNetwork(
                  //   width: 20,
                  //   height: 20,
                  //   fit: BoxFit.fitHeight,
                  //   placeholder: 'assets/images/quantity.png',
                  //   image: 'assets/images/quantity.png',
                  //   // image: accept.image,
                  //   // image: order?.packageInfo?.origination?.logo ?? '',
                  // ),
                  Image(
                    image: AssetImage("assets/images/quantity.png"),
                    width: 20.0,
                    color: iconColor1,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // Icon(Icons.line_style,
                  //     color: Color.fromARGB(255, 163, 148, 103)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: colorPrimary,
                        ),
                      ),
                      Text(
                        '${accept.itemcount}${' Nos'}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     // Icon(Icons.line_weight, color: iconColor1),
              //     Image(
              //       image: AssetImage("assets/images/weight.png"),
              //       width: 20.0,
              //       color: iconColor1,
              //       fit: BoxFit.contain,
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           'Weight',
              //           style: TextStyle(
              //             fontSize: 14.0,
              //             color: colorPrimary,
              //           ),
              //         ),
              //         Text(
              //           '${'40'}${' Kgs'}',
              //           // order?.packageInfo?.packages?.first?.weight ?? '',
              //           // task.totalWeight ?? '',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     // Icon(
              //     //   Icons.timelapse,
              //     //   color: iconColor1,
              //     // ),
              //     Image(
              //       image: AssetImage("assets/images/size.png"),
              //       width: 20.0,
              //       color: iconColor1,
              //       fit: BoxFit.contain,
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           'Size',
              //           style: TextStyle(
              //             fontSize: 14.0,
              //             color: colorPrimary,
              //           ),
              //         ),
              //         Text(
              //           "30 x 12",
              //           // order?.packageInfo?.packages?.first?.cost ?? '',
              //           // task.maxLength ?? '',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TabBar(
                  isScrollable: true,
                  // indicator:  BoxDecoration(
                  //   color: Colors.white,
                  // ),
                  indicatorColor: colorPrimary,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: EdgeInsets.only(left: 5, right: 0),
                  tabs: [
                    Container(
                        height: 30,
                        width: 80,
                        child: Center(
                            child: Text(
                          "Orders",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))),
                    Container(
                        height: 30,
                        width: 80,
                        child: Center(
                            child: Text(
                          "History",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )))
                  ],
                ),
              ),
            ),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height - 250,
            child: TabBarView(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: homeScreenResponse.accepted.length != 0
                      ? _getOrdersList()
                      : _noDataFound('No Orders Found')),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: homeScreenResponse.history.length != 0
                      ? _getHistoryList()
                      : _noDataFound('No History Found')),
            ]),
          ),
        ],
      ),
    );
  }

  Widget appBar() => AppBar(
        flexibleSpace: Container(
          color: colorPrimary,
        ),
        title: Center(
          child: Container(
            child: Text(
              '2c Cart',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            //       child: Image(
            //         image: AssetImage("assets/images/logo_1.png"),
            //         height: 30.0,
            //         fit: BoxFit.contain,
            //       ),
          ),
        ),
        actions: [
          PopupMenuButton(
              color: Colors.white,
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                setState(() {
                  _value = value;
                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BalanceScreenNew()));
                        },
                        child: TextField(
                          enabled: false,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "COD balance",
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 12),
                            prefixIcon: Icon(
                              Icons.monetization_on,
                              size: 18,
                            ),
                            border: InputBorder.none,

                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          getAlertLogout(context);
                          Navigator.pop(context);
                        },
                        child: TextField(
                          enabled: false,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Logout",
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 12),
                            prefixIcon: Icon(
                              Icons.logout,
                              size: 18,
                            ),
                            border: InputBorder.none,
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                        ),
                      ),
                    ),
                  ])
        ],
      );

  Widget _getPadding() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 0),
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: colorGrayBg,
    );
  }

  Widget _getOrdersList() {
    return ListView.builder(
        itemCount: homeScreenResponse.accepted.length,
        itemBuilder: (BuildContext context, int index) {
          return _listOrders(homeScreenResponse.accepted[index], index);
        });
  }

  Widget _getHistoryList() {
    return ListView.builder(
        itemCount: homeScreenResponse.history.length,
        itemBuilder: (BuildContext context, int index) {
          return _history(homeScreenResponse.history[index]);
        });
  }

  Widget setupAlertDialoadContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.transparent,
          height: MediaQuery.of(context)
              .size
              .width, // Change as per your requirement
          width: MediaQuery.of(context)
              .size
              .width, // Change as per your requirement
          child:
          ListView.builder(
            // scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return _listOrdersDriver(homeScreenResponse.orders[index], index);
            },
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: FlatButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text("Cancel"),
        //   ),
        // )
      ],
    );
  }

  Widget enableDataHome() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Text(
                    'OOPS!  NO INTERNET',
                    style: TextStyle(
                        color: colorPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please check your network connection',
                    style: TextStyle(color: colorPrimary, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 40, top: 5, right: 40),
                child: FlatButton(
                  onPressed: updateUI,
                  color: colorPrimary,
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      );

  void updateUI() {
    setState(() {
      //You can also make changes to your state here.
    });
  }

  Widget _noDataFound(String text) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo_1.png',height: 100,width: 100,),
          SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(color: colorPrimary, fontSize: 20),
          )
        ],
      ),
    );
  }
}
