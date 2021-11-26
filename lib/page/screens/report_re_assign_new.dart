
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/order_accept_response.dart';
import 'package:projectname33/page/network/response/report_reassign_response.dart';
import '../helper/apiparams.dart';
import '../helper/apiurldata.dart';
import '../network/response/HomeScreenResponse.dart';
import 'balance_screen_new.dart';
import 'home_screen2.dart';
class ReportReAssignNew extends StatefulWidget {
  Orders orders;
  String orderid;
  @override
  _ReportReAssignNewState createState() => new _ReportReAssignNewState(item: this.orders,orderid: this.orderid,);
  ReportReAssignNew(Orders orders,orderid)
  {
    this.orders=orders;
    this.orderid=orderid;
  }
}

class _ReportReAssignNewState extends State<ReportReAssignNew> {
String _value = " ";
Orders item;
String orderid;

final GlobalKey<FormState> reportKey = GlobalKey();
_ReportReAssignNewState({this.item,this.orderid});

  @override
  void initState() {


    super.initState();
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
  color: colorPrimary,),
      centerTitle: true,
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
      title: Container(
        child: Text(
          '2c Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
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
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: getContent(),

    );
  }
  String _reason;
Widget getContent(){
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 15,right: 15),
        color:colorGrayBg,
        child:Container(
          margin: EdgeInsets.only(bottom: 20),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Report / Re-assign',style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.only(top: 15,right: 5,left: 5),
                child:  Text('Please enter the reason for rejecting order below',
                  style: TextStyle(color: Colors.grey,fontSize: 15),textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.white,
                  child:
                  Form(
                    key: reportKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value
                            .trim()
                            .isEmpty) {
                          return 'This field is required';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _reason = value;
                      },
                      initialValue: _reason,
                      maxLines: 8,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          hintText: "Type here.....",
                          hintStyle: TextStyle(color: Colors.grey)

                        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                      ),

                    ),
                  )

              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height:40,
                margin: EdgeInsets.only(top: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreenNew()));
              },
                      child: Container(
                          width: 110,
                          margin: EdgeInsets.only(right:10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: iconColor1
                          ),
                          child: Center(
                            child:Text('CANCEL', style: TextStyle(color: Colors.white,fontSize: 15),),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(
                        reportKey.currentState.validate()
                        ){
                          reportKey.currentState.save();
                          sendReason(_reason,);
                        }


                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreenNew()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: colorPrimary
                          ),
                          child: Center(
                            child:Text('SEND', style: TextStyle(color: Colors.white,fontSize: 15),),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
}

Future<void> sendReason(String reason) async {
  // _updateNotifier.isProgressShown = true;

  Map body = {
    // name,email,phone_number,password
    ORDER_ID: orderid,
    REASON:_reason,
    DECISION: "2",
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
               HomeScreenNew()));
  });
}
}
