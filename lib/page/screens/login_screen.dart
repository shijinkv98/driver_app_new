import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/login_response.dart';
import 'package:projectname33/page/notifier/loading_notifier.dart';
import 'package:projectname33/page/notifier/loginnotifier.dart';
import 'package:provider/provider.dart';
import 'forgotpassword.dart';
import 'home_screen2.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final GlobalKey<FormState> _userPhoneKey = GlobalKey();
  final GlobalKey<FormState> _passwordKey = GlobalKey();
  String password,phone;
  LoginUpdateNotifier _updateNotifier;
  @override
  void initState() {
    super.initState();
    _updateNotifier =
        Provider.of<LoginUpdateNotifier>(context, listen: false);
    super.initState();
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);
  @override
  Widget build(BuildContext context) {
    Widget getTextFormUser(){
      return Form(
        key: _userPhoneKey,
          child:TextFormField(
            obscureText: false,
            // controller: emailController,
            onSaved: (value) {
              phone = value;
            },
            style: style,
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'This field is required';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              hintText: "Phone Number",
              labelText: 'Phone Number*',
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
            ),
          )
      );
    }

    Widget getTextFormPassword(){
      return Form(
        key:_passwordKey,
          child:TextFormField(
          obscureText: _isObscure,
        autofocus: false,
        style: style,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'This field is required';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          password = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            hintText: "Password",
            labelText: "Password*",
            suffixIcon:
            InkWell(
              onTap: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              child: IconButton(
                icon:Image.asset(
                  _isObscure ?
                  'assets/images/strike-eye.png':'assets/images/eye-icon.png',
                  width: 20,
                  height: 297446451830,
                  color: colorPrimary,
                ),
                onPressed: null,
                color: colorPrimary,
              ),
            )
        ),
      )

      );
    }

    Widget getForgetPassword(){
      return Container(
        margin: EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ForgotPasswordScreen('')));
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      );
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromARGB(255, 163, 148, 103),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          if(_userPhoneKey.currentState.validate()&&_passwordKey.currentState.validate())
          {
            _userPhoneKey.currentState.save();
            _passwordKey.currentState.save();
            login(phone, password);
          }





          // NextPageReplacement(context,OrderDialogNew());
          // Navigator.of(context).pushReplacementNamed('/home');
          // if (_formKey.currentState.validate()) {
          //   _formKey.currentState.save();
          //   Map body = {
          //     // 'email': emailController.text.trim(),
          //     // 'password': passwordController.text.trim()
          //     'phonenumber': phone.trim(),
          //     'password': password.trim(),
          //     'device_token': deviceToken,
          //     'device_id': deviceId,
          //     'device_platform': Platform.isIOS ? '2' : '1',
          //   };

            // ApiCall()
            //     .execute<LoginResponse, Null>(LOGIN_URL, body).then((LoginResponse result){
            //   _loginLoadingNotifier.isLoading = false;
            //   // if(result.success==null)
            //   // {
            //   //   if(result.error!=null)
            //   //     ApiCall().showToast(result.error);
            //   // }
            //   if(result.success=="1")
            //   {
            //
            //     ApiCall().saveUserToken(result.drivertoken);
            //     ApiCall().saveLoginResponse(result.toJson().toString());
            //     ApiCall().saveUserMobile(result.mobile);
            //     ApiCall().saveUserName(result.shopname);
            //
            //     NextPageReplacement(context,OrderDialogNew());
            //   }
            //
            // });


            // FocusScope.of(context).requestFocus(FocusNode());
            // _loginLoadingNotifier.isLoading = true;
            // LoginResponse value = await ApiCall().execute<LoginResponse, Null>("driver_login", body);
            // _loginLoadingNotifier.isLoading = false;
            // if (value != null && value. != null) {
            //   await ApiCall().saveUser(jsonEncode(value.vendorData.toJson()));
            //   Navigator.of(context).pushReplacementNamed('/home');
            // }
          // }
        },
        child: Text("LOGIN",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              color: colorPrimary
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 15.0),
                          Image(
                            image: AssetImage("assets/images/logo_1.png"),
                            height: 80.0,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 15.0),
                          getTextFormUser(),
                          SizedBox(height: 25.0),
                          getTextFormPassword(),
                          getForgetPassword(),
                          SizedBox(
                            height: 35.0,
                          ),
                          loginButon,
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer<LoginLoadingNotifier>(builder: (context, data, child) {
            return data.isLoading
                ? Stack(
              children: [
                const Opacity(
                  child: const ModalBarrier(
                      dismissible: false, color: Colors.grey),
                  opacity: 0.5,
                ),
                Center(child:  CircularProgressIndicator())
              ],
            )
                : Container(
              height: 0,
            );
          }),
        ],
      ),
    );
  }

  Future<void> login(String phone,String password)
  async {
    _updateNotifier.isProgressShown = true;
    // String deviceId = await DeviceId.getID;
    // String devicetoken = await FirebaseMessaging.instance.getToken();
    Map body = {
      // name,email,phone_number,password
      USER_PHONE: phone,
      USER_PASSWORD: password.trim(),
      // DEVICE_ID:deviceId,
      // DEVICE_TOKEN:devicetoken,
    };
    ApiCall()
        .execute<LoginResponse, Null>(LOGIN_URL, body).then((LoginResponse result){
      _updateNotifier.isProgressShown = true;
      if(result.success==null)
      {
        if(result.error!=null)
          ApiCall().showToast(result.error);
      }
      ApiCall().showToast(result.error!=null?result.message:"");
      if(result.success=="1")
      {

        ApiCall().saveUserToken(result.drivertoken);
        ApiCall().saveLoginResponse(result.toJson().toString());
        ApiCall().saveUserMobile(result.mobile);
        ApiCall().saveUserName(result.shopname);
        ApiCall().showToast(result.message);

        NextPageReplacement(context,HomeScreenNew());
      }


    });

  }

}
