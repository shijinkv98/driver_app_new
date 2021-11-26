
import 'package:floatingpanel/floatingpanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectname33/page/custom/custom_switch.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/driver_duty_response.dart';
import 'package:projectname33/page/network/response/loan_list_response.dart';
import 'package:projectname33/page/screens/direction_new_customer.dart';
import 'package:projectname33/page/screens/direction_new_google.dart';
import 'package:projectname33/page/screens/loan_request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'balance_screen_new.dart';
import 'direction_new.dart';
class LoanListScreen extends StatefulWidget {



  @override
  _LoanListScreenState createState() => new _LoanListScreenState();
  LoanListScreen();
}

class _LoanListScreenState extends State<LoanListScreen> {
  LoanListResponse loanListResponse;
  String _value = "";
    _LoanListScreenState();

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
        child: Center(
          child: Text(
            'Loan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // use Scaffold also in order to provide material app widgets
        appBar: appBar(context),
      floatingActionButton: SpeedDial( //Speed dial menu
        marginBottom: 40,
        marginEnd: 25,//margin bottom
        icon: Icons.add, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: colorPrimary, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor: Colors.red, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: 65.0, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,

        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild( //speed dial child
            child: Icon(Icons.monetization_on_outlined),
            backgroundColor:colorPrimary,
            foregroundColor: Colors.white,
            labelBackgroundColor: Colors.white,
            label: 'Apply for Loans',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              NextPagePush(context, LoanRequest());
            },
            onLongPress: () {
              NextPagePush(context, LoanRequest());
            },
          ),


          //add more menu item childs here
        ],
      ),
      backgroundColor: Colors.white,
      body:FutureBuilder<LoanListResponse>(
        future:
        ApiCall().execute<LoanListResponse, Null>(LOAN_LIST, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            loanListResponse = snapshot.data;
            return  getMainBody();
          } else if (snapshot.hasError) {
            return
              enableDataHome();
            // errorScreen('Error: ${snapshot.error}');
          }
          else {
          return  progressBar;
          }
        },
      )




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
              Text('OOPS!  NO INTERNET',style: TextStyle(color: colorPrimary,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5),
              Text('Please check your network connection',style: TextStyle(color: colorPrimary,fontSize: 20),),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 40,top:5,right: 40),
            child: FlatButton(onPressed: updateUI,color: colorPrimary,child: Text('Try Again',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),))
      ],
    ),
  );

  void updateUI(){
    setState(() {
      //You can also make changes to your state here.
    });
  }

  Widget getMainBody(){
    return Column(
      children: [
         getTitle(),
         _productsTitle(),
         Container(
          child: Divider(
            height: 5,color: Colors.grey[300],
          ),
        ),
         getProductList(),

      ],
    );
  }


  Widget getProductList(){
    return ListView.builder(
        itemCount: loanListResponse.data.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(loanListResponse.data[index].dateRequested,style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Text(
                          loanListResponse.data[index].amount,style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            loanListResponse.data[index].loanStatus,style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                  Container(margin:EdgeInsets.only(top: 5),child: _getDivider())
                ],
              ),
            ),
          );
        });
  }

  Widget _productsTitle(){
    return Container(
      color: colorGrayBg,
      height: 50,
      child:
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text('Date',style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold)),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Text('Amount',style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),)),
                    SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text('Pending/Approval',style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight:FontWeight.bold),),
                        )),
                  ],
                ),

              ],
            ),
          ),
    );
  }
  Widget _getDivider() {
    return Divider(
      height: 3,color: Colors.grey[300],);
  }
  Widget getTitle(){
    return Container(
        margin: EdgeInsets.only(top: 25,bottom: 25),
        child: Text('${'Balance : '}${loanListResponse.balance}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),));


 }

}
