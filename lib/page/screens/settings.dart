
import 'package:flutter/material.dart';
import 'package:projectname33/page/custom/custom_switch.dart';
import 'package:projectname33/page/helper/constants.dart';

import 'balance_screen_new.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => new _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched = false;
  String _value = "";
  @override
  void initState() {
    super.initState();
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
  color: colorPrimary,),
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
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/settings.jpg',
                height: 150.0,
                fit: BoxFit.contain,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 15),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notification Sound',style: TextStyle(color: Colors.grey,fontSize: 15),),
                      Container(
                        height: 25,
                        child: CustomSwitch(
                          value: isSwitched,
                          activeColor: colorPrimaryLight,
                          activeTextColor: colorPrimary,
                          inactiveColor: iconColor1,
                          inactiveTextColor: colorPrimary,
                          onChanged: (value) {

                            print("VALUE : $value");
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),


             Container(
               margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                 child:
                 Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Notification Vibration',style: TextStyle(color: Colors.grey,fontSize: 15),),
                 Container(
                   height: 25,
                   child: CustomSwitch(
                     value: isSwitched,
                     activeColor: colorPrimaryLight,
                     activeTextColor: colorPrimary,
                     inactiveColor: iconColor1,
                     inactiveTextColor: colorPrimary,
                     onChanged: (value) {
                       print("VALUE : $value");
                       setState(() {
                         isSwitched = value;
                       });
                     },
                   ),
                 ),
               ],
             )
             ),

            ],
          ),
        ),
      ),
    );
  }


}
