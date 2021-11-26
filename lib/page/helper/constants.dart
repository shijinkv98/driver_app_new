import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/user.dart';
import 'package:projectname33/page/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SUCCESS_MESSAGE = "You will be contacted by us very soon.";
const APP_TAG = "DRIVER_APP";

// Api related
const BASE_URL = "https://2ccart.webdemos.cf/newdemo/api/api_driver/";
const Color colorPrimary = const Color.fromRGBO(11, 63, 139, 1.0);
const Color transparent  = const Color(0);
// const Color appBarColor = Color(0xFF0a3a80);
// const Color colorPrimaryLight = Color(0xFFe3ebb1);
const Color colorPrimaryLight = const Color(0xFF7C91BC);
const Color colorGrayBg = Color(0xFFefefef);
const Color gradientEnd = Color.fromARGB(255, 141, 209, 0);
const iconColor1 = Color.fromARGB(255, 163, 148, 103);
const double field_text_size=10.0;
const Color textColor = Color(0xFF616161);
const Color textColorSecondary = Color(0xFF999999);
const padding = 10.0;
const contryCode = 91;
String deviceToken = "";
String deviceId = "";
UserData userDataGlobal;
NextPageReplacement(BuildContext context, nextpage) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => nextpage));
}
NextPagePush(BuildContext context, nextpage) {
  Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => nextpage));
}

Widget enableData(String Title) => Center(
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
            Text(Title,style: TextStyle(color: colorPrimary,fontSize: 20,fontWeight: FontWeight.bold),),
            Text('Please check your network connection',style: TextStyle(color: colorPrimary,fontSize: 15),),
          ],
        ),
      ),

    ],
  ),
);

Widget errorScreen(String errorTitle) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(errorTitle),
      )
    ],
  ),
);
Widget progressBar = InkWell(
  child: SafeArea(
    child: Center(
      child: SizedBox(
        child: CircularProgressIndicator( ),
        width: 60,
        height: 60,
      ),
    ),
  ),
);
Future<void> logout(BuildContext context)
async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  NextPageReplacement(context, LoginScreen());
}
Widget getAlertLogout(BuildContext context){
  return  showDialog(
    builder: (context) => AlertDialog(
      title: Center(child: Column(
        children: [
          Text('Logout ?', style:TextStyle(color: colorPrimary,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Text('Are you sure you want to exit ?' , style:TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal),)
        ],
      )),
      // content: Center(child: Text('Are you sure you want to exit ?')),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("you choose no");
            Navigator.of(context).pop(false);
          },
          child: Text('No',style:TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal)),
        ),
        FlatButton(
          onPressed: () {
            logout(context);
          },
          child: Text('Yes',style:TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal)),
        ),
      ],
    ), context: context,
  ) ??
      false;
}