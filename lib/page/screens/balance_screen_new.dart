
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/cod_balance_response.dart';



class BalanceScreenNew extends StatefulWidget {
  @override
  _BalanceState createState() => new _BalanceState();
}

class _BalanceState extends State<BalanceScreenNew> {
  CodBalanceResponse codBalanceResponse;
  String _value = "";
  @override
  void initState() {
    super.initState();
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        color: colorPrimary,
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
      title: Container(
        child: Text(
          'COD Balance',
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
        body: FutureBuilder<CodBalanceResponse>(
          future: ApiCall()
              .execute<CodBalanceResponse, Null>(COD_BALANCE_URL, null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              codBalanceResponse = snapshot.data;
              return _getView();
            } else if (snapshot.hasError) {
              return
                enableDataHome();
                  // errorScreen('Error: ${snapshot.error}');
            } else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
              ;
            }
          },
        ));
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

  Widget _getView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/balance_cod.jpg',
              height: 150.0,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(top: 5, left: 5, right: 5),
              decoration: BoxDecoration(
                  color: colorGrayBg,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      "Total Amount Collected",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                    child: Text(
                      codBalanceResponse.collected,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              height: 45,
              decoration: BoxDecoration(
                  color: colorGrayBg,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      "Cash in Hand",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                    child: Text(
                      codBalanceResponse.cashinhand,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _listWidget(String title, String amount) {
  //   return DecoratedBox(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(2.0),
  //         color: Colors.grey.withAlpha(50)),
  //     child: Padding(
  //       padding: EdgeInsets.all(10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 16),
  //           ),
  //           Expanded(
  //             child: Align(
  //               alignment: Alignment.centerRight,
  //               child: Text(
  //                 amount ?? '',
  //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
