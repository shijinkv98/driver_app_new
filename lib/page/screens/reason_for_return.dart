
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/reson_for_return_response.dart';

import 'home_screen2.dart';

class ReasonForReturn extends StatefulWidget {
  Accepted accept;
  String orderDetailsId;

  @override
  _ReturnState createState() => new _ReturnState(item: this.accept,orderDetailsId: this.orderDetailsId);
  ReasonForReturn(orderDetailsId)
  {
    this.accept=accept;
    this.orderDetailsId=orderDetailsId;
  }
}

class _ReturnState extends State<ReasonForReturn> {
  String _selectedGender = 'Door closed';
  Accepted item;
  String orderDetailsId;
  String _reasonText;

  final GlobalKey<FormState> _reasonKey = GlobalKey();

  _ReturnState({this.item,this.orderDetailsId});

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
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      backgroundColor:colorGrayBg,
      // appBar: appBar(context),
      body: getContent(),

    );
  }
Widget getContent(){
    return Center(
      child: Container(
        color:colorGrayBg,
        child:Container(
          margin: EdgeInsets.only(bottom: 20),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.pop(context, false);
                       },

                        child: Icon(Icons.close,size: 35,))
                  ],
                ),
              ),
              _reason(),
            ],
          )
        ),
      ),
    );
}

  Widget _reason() {
    return Center(
      child: Container(
        color: colorGrayBg,
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
                        'Reason for Return',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Radio(
                          value: 'Door closed',
                          groupValue: _selectedGender,
                          activeColor: colorPrimary,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        title: Text('Door closed'),
                      ),
                      ListTile(
                        leading: Radio(
                          value: 'Product damaged',
                          activeColor: colorPrimary,
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        title: Text('Product damaged'),
                      ),
                      ListTile(
                        leading: Radio(
                          activeColor: colorPrimary,
                          value: 'Other reasons',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        title: Text('Other reasons'),
                      ),
                     _selectedGender == "Other reasons"? Container(height: 100,color: Colors.white,
                       margin: EdgeInsets.only(left: 25),
                       child:
                       Form(
                         key: _reasonKey,
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
                           onChanged: (value) {
                             _reasonText = value;
                           },
                           maxLines: 6,
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

                     ):Text('data',style: TextStyle(color: Colors.white),),
                      InkWell(
                        onTap: (){
                          if( _reasonKey.currentState.validate()
                          )
                            {
                              _reasonKey.currentState.save();
                              submit(_reasonText);
                            }
                        },
                        child: Container(
                          width: 125,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 10,left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: colorPrimary
                          ),
                          child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submit(String reasonText) async {

    Map body = {


      ORDER_DETAILS_ID_RETURN: orderDetailsId,
      RETURN_REASON:_selectedGender,
      DETAILS:_reasonText



    };
    ApiCall()
        .execute<ReasonForReturnResponse, Null>(RETURN_REQUEST_URL, body)
        .then((ReasonForReturnResponse result) {

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
