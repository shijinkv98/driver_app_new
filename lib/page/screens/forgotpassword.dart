
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/forgotPasswordResponse.dart';
import 'package:projectname33/page/screens/resetpassword.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String title;

  ForgotPasswordScreen(String title)
  {
    this.title=title;
  }
  @override
  _ForgotPasswordScreenState createState() => new _ForgotPasswordScreenState(title: title);
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _ForgotPasswordScreenState({ this.title}) ;

  Widget getForms_forgot(){
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 5,left: 25,bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    margin: EdgeInsets.only(top: 35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width-50,
                            child: phoneField),
                      ],
                    ),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget getButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
      child: Container(
        width: double.infinity,
        height: 40,
        child: RaisedButton(
            color: colorPrimary,
            elevation: 0,
            child: Text('Submit',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

              }


              Map body={
                "phonenumber":phone,
                // "country":"99"
              };
              FocusScope.of(context).requestFocus(FocusNode());

              var response = await ApiCall()
                  .execute<ForgotPasswordResponse, Null>("forgot_password", body);

              if (response!= null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ResetPasswordScreen(phone:phone,)));
              }
            }

        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title:  Text('Forgot Password',style:TextStyle(fontSize:15,color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body:getContent()
        // FutureBuilder<CountryList>(
        //   future: ApiCall().execute<CountryList, Null>('countries/en', null),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       countries=snapshot.data.countries;
        //       // if(countries!=null)
        //       // {
        //       //   _chosenValue = countries[0];
        //       //   countryId = _chosenValue.id.toString();
        //       // }
        //       return getContent();
        //     } else if (snapshot.hasError) {
        //       return errorScreen('Error: ${snapshot.error}');
        //     } else {
        //       return progressBar;
        //     }
        //   },
        // )





    );
  }

  Widget getContent(){
    return Container(
      child: Column(
        children: [
          getPersonalInfo(),
          getButton(context)
        ],
      ),
    );
  }
  Container getPersonalInfo()
  {
    return Container(
      child: Container(width: double.infinity,
        child: Column(

          children: [
            getForms_forgot(),


          ],
        ),

      ),
    );
    //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

  }

}
String phone;
bool isLoading = false;
final phoneField = TextFormField(
  cursorColor: colorPrimary,
  obscureText: false,
  // inputFormatters: [
  //   new WhitelistingTextInputFormatter(
  //       new RegExp(r'^[0-9]*$')),
  //   new LengthLimitingTextInputFormatter(10)
  // ],
  onChanged: (value) {
    phone = value;
  },
  // style: style,
  validator: (value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return value.length < 10 ? 'Enter a valid Mobile Number ' : null;
    }
  },
  keyboardType: TextInputType.number,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
    hintText: "Enter Registered Phone Number", hintStyle: TextStyle(color: textColorSecondary),
    labelText: 'Phone Number',
    // prefixText: "+974",
    labelStyle: TextStyle(fontSize: field_text_size, color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorPrimary),
    ),


    suffixIcon:  Icon(
      Icons.local_phone_outlined,
      color: colorPrimary,
    ),

  ),

);

