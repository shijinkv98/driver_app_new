
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/screens/reason_for_return.dart';
import 'package:url_launcher/url_launcher.dart';

import 'balance_screen_new.dart';
import 'delivery_confirmation.dart';

class UpdateStatusNew extends StatefulWidget {
  Accepted accept;
  String orderid;
  String rupees;
  String ordertotal;
  String mode;


  @override
  _UpdateStatusNewState createState() => new _UpdateStatusNewState(item: this.accept,orderid: this.orderid,rupees: this.rupees,ordertotal:this.ordertotal,mode:this.mode);
  UpdateStatusNew({this.accept,this.orderid,this.rupees,this.ordertotal,this.mode})
  {
    this.accept=accept;
    this.orderid=orderid;
    this.rupees=rupees;
    this.ordertotal=ordertotal;
    this.mode=mode;

  }
}

class _UpdateStatusNewState extends State<UpdateStatusNew> {
  HomeScreenResponse homeScreenResponse;
  bool isSwitched = false;
  String _selectedGender = 'Door closed';
  String _value = " ";
  Accepted item;
  String orderid;
  String rupees;
  String ordertotal;
  String mode;



  _UpdateStatusNewState({this.item,this.orderid,this.rupees,this.ordertotal,this.mode});

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
        // child: Image(
        //   image: AssetImage("assets/images/logo_1.png"),
        //   height: 30.0,
        //   color: Colors.white,
        //   fit: BoxFit.contain,
        // ),

        child: Center(
          child: Text(
            '2c Cart',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // use Scaffold also in order to provide material app widgets
        appBar: appBar(context),
        body: Column(
          children: [
            _tabSection(context),

          ],
        )
    );
  }
  Widget getContent(){
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _status(),
                // homeScreenResponse.accepted[index], index

          ],
        ),
      ),
    );
  }
  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 1,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:20),
            child:
            Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  // indicator:  BoxDecoration(
                  //   color: Colors.white,
                  // ),
                  indicatorColor: colorPrimary,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [ Center(
                    child: Container(
                        height: 30,
                        child: Center(child: Text("Update Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                  ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height-200,
            child: TabBarView(children: [
              Container(
                  color: Colors.white,
                  child: getContent()),


            ]),
          ),
        ],
      ),
    );
  }

  Widget _status() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
        color: Colors.white,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ReasonForReturn(this.orderid)));
                      },
                      child: ListTile(
                        leading: Radio(
                          groupValue: _selectedGender,
                          activeColor: colorPrimary,
                        ),
                        title: Text('Return / Cancel'),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DeliveryConfirmation(rupees:this.rupees,orderid:this.orderid,ordertotal:this.ordertotal,mode:this.mode)));
                      },
                      child: ListTile(
                        leading: Radio(
                          activeColor: colorPrimary,
                          groupValue: _selectedGender,
                        ),
                        title: Text('Delivered'),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _reason() {
    return Container(
      color: colorGrayBg,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
        color: Colors.white,
        child: Column(
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
                  ],
                ))
          ],
        ),
      ),
    );
  }

//
}
