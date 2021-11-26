
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/delivery_confirm_response.dart';
import 'package:projectname33/page/network/response/delivery_payment_response.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/apiparams.dart';
import '../helper/apiparams.dart';
import '../helper/apiurldata.dart';
import '../helper/constants.dart';
import '../notifier/checkbox_notifier.dart';
import 'balance_screen_new.dart';
import 'home_screen2.dart';
import 'home_screen2.dart';

class DeliveryConfirmation extends StatefulWidget {
  Accepted accept;
  String rupees;
  String orderid;
  String ordertotal;
  @override
  _DeliveryConfirmationState createState() =>
      new _DeliveryConfirmationState(item: this.accept, rupees: this.rupees,orderid:this.orderid,ordertotal:this.ordertotal);
  DeliveryConfirmation({this.rupees, this.ordertotal, this.orderid}) {
    this.accept = accept;
    this.rupees = rupees;
    this.orderid = orderid;
    this.ordertotal = ordertotal;
  }
}

class _DeliveryConfirmationState extends State<DeliveryConfirmation> {
  bool value = false;
  Accepted item;
  String rupees;
  String orderid;
  String ordertotal;

  CheckBoxNotifier _checkBoxNotifier;
  _DeliveryConfirmationState({this.item, this.rupees,this.orderid,this.ordertotal});

  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text("Are you sure?"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('$APP_TAG ReturnToStoreScreen build()');
    _checkBoxNotifier = Provider.of<CheckBoxNotifier>(context, listen: false);
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      backgroundColor: Colors.white,
      // appBar: appBar(context),
      body: getContent(),
    );
  }

  Widget getContent() {
    return Center(
      child: Card(
        margin: EdgeInsets.only(left: 15, right: 15),
        elevation: 10,
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _reason(),
          ],
        )),
      ),
    );
  }

  Widget _reason() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: colorPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                      child: Text(
                    'Delivery Confirmation',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Delivery Confirmation Message',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ))),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Center(
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 2,
                            minLines: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '${rupees}${' '}${ordertotal}',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),

                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            child: Consumer<CheckBoxNotifier>(
                                builder: (context, value, child) {
                              return Checkbox(
                                value: value.isChecked,
                                activeColor: colorPrimary,
                                onChanged: (bool value2) {
                                  value.isChecked = value2;
                                },
                              );
                            }),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Payment Received',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )) //
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Container(
                              height: 35,
                              margin: EdgeInsets.only(right: 10, bottom: 20),
                              decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Container(
                                  margin: EdgeInsets.only(left: 25, right: 25),
                                  child: Center(
                                      child: Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(!_checkBoxNotifier.isChecked){
                                ApiCall().showToast("Please accept the Verification box");
                              }
                              else{
                                confirmed(context);
                              }
                            },
                            child: Container(
                              height: 35,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: iconColor1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Container(
                                  margin: EdgeInsets.only(left: 25, right: 25),
                                  child: Center(
                                      child: Text(
                                    "Confirmed",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> confirmed(BuildContext context) async {
    // _updateNotifier.isProgressShown = true;

    Map body = {
      // name,email,phone_number,password
      ORDER_ID: orderid,
      AMOUNT:ordertotal,
      PAYMENTRECEIVED:"1",
    };
    ApiCall()
        .execute<DeliveryPaymentResponse, Null>(DELIVERY_PAYMENT, body)
        .then((DeliveryPaymentResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreenNew()));
    });
  }
}



