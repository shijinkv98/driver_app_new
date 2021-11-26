
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/delivery_confirm_response.dart';
import 'package:projectname33/page/network/response/delivery_payment_response.dart';
import 'package:projectname33/page/screens/loan_list_scrren.dart';
import 'package:projectname33/page/screens/profile_screen_new.dart';
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

class LoanRequest extends StatefulWidget {

  @override
  _LoanRequestState createState() =>
      new _LoanRequestState();
  LoanRequest() {

  }
}

class _LoanRequestState extends State<LoanRequest> {
  bool value = false;
  String _Name;
  final GlobalKey<FormState> formKey = GlobalKey();
  CheckBoxNotifier _checkBoxNotifier;
  _LoanRequestState();

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
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
        ),
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

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          margin: EdgeInsets.only( bottom: 20),


          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  color: colorPrimary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                      child: Text(
                    'Loan Request',
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
                              'Loan Amount',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ))),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Center(
                        child: Center(
                          child:getTextField()


                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){

                              if(formKey.currentState.validate())
                              {
                                formKey.currentState.save();

                                confirmed(_Name);
                              }

                            },
                            child: Container(
                              height: 45,
                              margin: EdgeInsets.only(bottom: 20,top: 20),
                              decoration: BoxDecoration(
                                color: iconColor1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Container(
                                  margin: EdgeInsets.only(left: 25, right: 25,top: 5,bottom: 5),
                                  child: Center(
                                      child: Text(
                                    "Request",
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
  Widget getTextField(){
    return Form(
      key: formKey,
      child:TextFormField(
      enabled: true,
      onSaved: (value) {
        _Name = value;
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'This field is required';
          // } else if (!RegExp(
          //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          //     .hasMatch(value)) {
          //   return 'Invalid email';
        } else {
          return null;
        }
      },
      maxLines: 2,
      minLines: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Enter loan amount',
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold),

        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    ),);
  }
  Future<void> confirmed(String amount) async {
    // _updateNotifier.isProgressShown = true;

    Map body = {
      // name,email,phone_number,password
      AMOUNT:amount,
      // PAYMENTRECEIVED:"1",
    };
    ApiCall()
        .execute<DeliveryPaymentResponse, Null>(LOAN_REQUEST, body)
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
                  LoanListScreen()));
    });
  }
}



