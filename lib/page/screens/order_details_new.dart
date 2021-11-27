
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectname33/page/custom/custom_switch.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/HomeScreenResponse.dart';
import 'package:projectname33/page/network/response/driver_duty_response.dart';
import 'package:projectname33/page/screens/direction_new_customer.dart';
import 'package:projectname33/page/screens/direction_new_google.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'balance_screen_new.dart';
import 'direction_new.dart';
class OrderDetailsNew extends StatefulWidget {

  Accepted accept;
  String orderid;
  String lastname;
  String firstname;
  String duty_on;
  List<Acceptedorders> acceptedorders;
  List<Accproducts> accproducts;
  List<Deliaddressacc> deliaddressacc;

  @override
  _OrderDetailState createState() => new _OrderDetailState(item:this.accept,
      orderid:this.orderid,
      firstname:this.firstname,
      lastname: this.lastname,
      itemorders: this.acceptedorders,
      accproducts:this.accproducts,
      deliaddressacc: this.deliaddressacc,
      duty_on:this.duty_on
  );
  OrderDetailsNew({this.accept,
    this.orderid,
    this.firstname,
    this.lastname,
    this.acceptedorders,
    this.accproducts,
    this.deliaddressacc,
    this.duty_on});
}

class _OrderDetailState extends State<OrderDetailsNew> {
  bool isSwitched = false;
  bool status = false;
  Accepted item;
  String orderid;
  String firstname;
  String lastname;
  String duty_on;
  List<Acceptedorders> itemorders;
  List<Accproducts> accproducts;
  List<Deliaddressacc> deliaddressacc;
  String _value = "";
  String _selectedGender = 'Door closed';
  HomeScreenResponse homeScreenResponse;
  LatLng currentPostion;

  Position _location = Position(latitude:  0.0, longitude:0.0);

  void _displayCurrentLocation() async {

    final location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _location = location;

        });
  }

    _OrderDetailState({this.item,
      this.orderid,
      this.firstname,
      this.lastname,
      this.itemorders,
      this.accproducts,
      this.deliaddressacc,
      this.duty_on
    });

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
    _displayCurrentLocation();
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
  // Position position;
  // void _getUserLocation() async {
  //    position = await GeolocatorPlatform.instance
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //
  //   setState(() {
  //     currentPostion = LatLng(position.latitude, position.longitude);
  //   });
  // }
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
        // use Scaffold also in order to provide material app widgets
        appBar: appBar(context),
        backgroundColor: Colors.white,
        body:getAllContent(),
);
  }
  Widget getAllContent(){
    return Column(
      children: [
        // _titleName(),
        _tabSection(context),

      ],
    );
  }
  Widget getContent(){
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child:  _getPadding()),
          SliverToBoxAdapter(child:   getAllContentsList()),
          SliverToBoxAdapter(child:  _getPadding()),
          SliverToBoxAdapter(child:   getDeliveryAddress()),
        ],
      ),
    );
  }
  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Widget getMainBody(Acceptedorders itemorder,Accepted accepted){
    return Column(
      children: [
        _getContent(itemorder),
        _productsTitle(),
         getProductList(itemorder),
        _productsRate(accepted),
        _totalProductsText(itemorder),
        _getPadding()

      ],
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
                        child: Center(child: Text("Orders Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                  ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            //Add this to give height
            // height: MediaQuery.of(context).size.height-220,
            height: MediaQuery.of(context).size.height-150,
            child: TabBarView(children: [
              Container(
                  child: getContent()),


            ]),
          ),
        ],
      ),
    );
  }
  Widget getAllContentsList(){
    return ListView.builder(
        itemCount:itemorders.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getMainBody(itemorders[index],item);
        });
  }


  Widget getProductList(Acceptedorders itemorder){
    return ListView.builder(
        itemCount: itemorder.accproducts.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _products(itemorder,index);
        });
  }

  Widget _products(Acceptedorders itemorder,int index){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      padding: EdgeInsets.only(bottom: 10),
      color: colorGrayBg,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 15,right: 15,top: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Text(itemorder.accproducts[index].productnameacc,style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),)),
                Container(
                  margin: EdgeInsets.only(left: 20),
                    width:  MediaQuery.of(context).size.width/3-40,
                    child: Text(
                      '${itemorder.accproducts[index].quantityacc}${' Nos'}',style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),)),
                Container(
                    width:  MediaQuery.of(context).size.width/3-50,
                    child: Text(
                      '${'₹ '}${itemorder.accproducts[index].priceacc}',style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),))
              ],
            ),
            Container(margin:EdgeInsets.only(top: 5),child: _getDivider())
          ],
        ),
      ),
    );
  }

  Widget _productsTitle(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      color: colorGrayBg,
      child:
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/3,
                        child: Text('Product',style: TextStyle(fontSize: 15,color: Colors.grey,fontStyle: FontStyle.italic),)),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width/3-40,
                        child: Text('Qty.',style: TextStyle(fontSize: 15,color: Colors.grey,fontStyle: FontStyle.italic),)),
                    Container(
                        width: MediaQuery.of(context).size.width/3-50,
                        child: Text('Price',style: TextStyle(fontSize: 15,color: Colors.grey,fontStyle: FontStyle.italic),)),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Divider(
                    height: 5,color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
    );
  }
  Widget _productsRate(Accepted accepted){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      color: colorGrayBg,
      child:
      Container(
        margin: EdgeInsets.only(left: 15,right: 15,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Text('Delivery Charge',style: TextStyle(fontSize: 15,color: Colors.black54,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
                Container(
                  width: MediaQuery.of(context).size.width/3-40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width/3-50,
                  child: Text(
                    '${accepted.rupees}${" "}${accepted.shipping}',style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Divider(
                height: 5,color: Colors.grey[500],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/3,
                      child: Text('Total Price',style: TextStyle(fontSize: 15,color: Colors.black54,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
                  Container(
                    width: MediaQuery.of(context).size.width/3-40,
                  ),
                  Container(

                      width: MediaQuery.of(context).size.width/3-50,
                      child: Text('${accepted.rupees}${" "}${accepted.ordertotal}',style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalProductsText(Acceptedorders itemorder){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${'Total'}${' '}${'( '}${itemorder.productcountacc}${' Products,'}${' Qty : '}${itemorder.itemcountshopacc}${' Nos.'}${' )'}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
        ],
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Container(
        child: Text(
          'Orders Details',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getContent(Acceptedorders itemorder) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 1, bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${'Order ID : '}${item.orderid}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  // 'Order Id: ${task.orderId}'
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        item.ordertime,
                        // task.createdAt,
                        style: TextStyle(
                            color: colorPrimary, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 27,),
                      child: DecoratedBox(

                        decoration: const BoxDecoration(color: iconColor1,
                        borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          child: Text(
                            item.paymentmod,
                            // task.paymentMethod,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
            // acceptedOrders array value started here

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'Vendor Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      width: 80.0,
                      height: 60,
                      fit: BoxFit.fitHeight,
                      placeholder: 'assets/images/shop.png',
                      image: itemorder.shopimage,
                      // image: item.image,
                      // image: order?.packageInfo?.origination?.logo ?? '',
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(itemorder.shopname
                            ,
                            // order?.packageInfo?.origination?.name ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(itemorder.address,
                            // "5/23, Al Seeq Apartment, Al Maqtam Street Abudhab",
                            // order?.packageInfo?.origination?.getAddress() ?? '',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child:
                    Column(
                      children: [
                        RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: colorPrimary,
                          onPressed: () {
                            String phone =itemorder.contact;
                            if (phone != null && phone.trim().isNotEmpty) {
                              phone = 'tel:$phone';
                              if ( canLaunch(phone) != null) {
                                launch(phone);
                              }
                            }

                            // _launchUrl(
                            //   // 'tel:${task.order.first?.packageInfo?.location?.phone}');
                            //     'tel:${'6238839396'}');
                          },
                          child:
                          Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/call-icon.png',height: 15,width: 15,),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Call",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Color.fromARGB(255, 159, 145, 101),
                          onPressed: () {
                            String phone ='${'wa.me/'}${'+91'}${itemorder.contact}${'/?text'}=${Uri.parse('Hi')}';
                            print("Chat:::::::" +'${'wa.me/'}${'91'}${itemorder.contact}${'/?text'}=${Uri.parse('Hi')}');
                            if (phone != null && phone.trim().isNotEmpty) {
                              phone = 'https:$phone';
                              if ( canLaunch(phone) != null) {
                                launch(phone);
                              }
                            }
                          },
                          child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/chat-icon.png',height: 15,width: 15,color: Colors.white,),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Chat",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                // DirectionNewGoogle()));
                                DirectionNew(longitude: itemorder.longitude,
                                    latitude:itemorder.latitude,
                                    shopname:itemorder.shopname,
                                    address:itemorder.address,
                                    liveLat:_location.latitude,
                                    liveLong:_location.longitude
                                )));

                            // _launchUrl(
                            //   // 'http://maps.google.com/?saddr=My+Location&daddr=${task.order.first?.packageInfo?.location?.address}'
                            //     'http://maps.google.com/?saddr=My+Location&daddr=${'kannur'}');
                          },
                          textColor: Colors.white,
                          color: Color.fromARGB(255, 27, 40, 19),
                          padding: const EdgeInsets.all(8.0),
                          child:Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Image.asset('assets/images/location-icon.png',height: 15,width: 15,color: Colors.white,),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              ],
            ),
                SizedBox(
                  height: 10.0,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleName() {
    if(duty_on=='1')
      status=true;
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 15, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.only(top: 15),
            child: Text('${'Hi , '}${firstname}${" "}${lastname}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          Container(
            height: 25,
            child:
            CustomSwitch(
              value: status==true?true:false,
              activeColor: colorPrimaryLight,
              activeTextColor: Colors.white,
              inactiveColor: iconColor1,
              inactiveTextColor: Colors.white,
              onChanged: (value) {
                status != false ? dutyoff():dutyupdate();
                setState(() {
                  status = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> dutyupdate() async {
    Map body = {
      DUTY_ON:"1",
      // LATITUDE:_location.latitude,
      // LONGITUDE:_location.longitude

    };
    ApiCall()
        .execute<DriverDutyResponse, Null>(DUTY_ON_OFF, body)
        .then((DriverDutyResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
        // NextPageReplacement(context, HomeScreenNew());
        // setState(() {
        //
        // });
      }
    });
  }

  Future<void> dutyoff() async {
    Map body = {
      DUTY_ON:"2"
    };
    ApiCall()
        .execute<DriverDutyResponse, Null>(DUTY_ON_OFF, body)
        .then((DriverDutyResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
        // NextPageReplacement(context, HomeScreenNew());
        // setState(() {
        //
        // });
      }
    });
  }

  // Widget orderInfo2(Acceptedorders accept) {
  //   // Acceptedorders acceptedorders =
  //   // accept. != null && accept.acceptedorders.length > 0
  //   //     ? accept.acceptedorders[0]
  //   //     : null;
  //   return
  //     Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       FadeInImage.assetNetwork(
  //         width: 80.0,
  //         height: 60,
  //         fit: BoxFit.fitHeight,
  //         placeholder: 'assets/images/homemade.jpg',
  //         image: 'assets/images/homemade.jpg',
  //         // image: item.image,
  //         // image: order?.packageInfo?.origination?.logo ?? '',
  //       ),
  //       SizedBox(
  //         width: 10.0,
  //       ),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(acceptedorders.shopname
  //              ,
  //               // order?.packageInfo?.origination?.name ?? '',
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Text(acceptedorders.address,
  //               // "5/23, Al Seeq Apartment, Al Maqtam Street Abudhab",
  //               // order?.packageInfo?.origination?.getAddress() ?? '',
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Expanded(child:
  //       Column(
  //         children: [
  //           RaisedButton(
  //             padding: const EdgeInsets.all(8.0),
  //             textColor: Colors.white,
  //             color: colorPrimary,
  //             onPressed: () {
  //               String phone ="6238839396";
  //               if (phone != null && phone.trim().isNotEmpty) {
  //                 phone = 'tel:$phone';
  //                 if ( canLaunch(phone) != null) {
  //                launch(phone);
  //               }
  //             }
  //
  //               // _launchUrl(
  //               //   // 'tel:${task.order.first?.packageInfo?.location?.phone}');
  //               //     'tel:${'6238839396'}');
  //             },
  //             child:
  //             Container(
  //               width: 80,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   FadeInImage.assetNetwork(
  //                     width: 15.0,
  //                     height: 15,
  //                     fit: BoxFit.fitHeight,
  //                     placeholder: 'assets/images/call-icon.png',
  //                     image: 'assets/images/call-icon.png',
  //                   ),
  //                   // Image.asset('assets/images/call-icon.png',height: 15,width: 15,),
  //                   Container(
  //                     margin: EdgeInsets.only(left: 5),
  //                     child: Text(
  //                       "Call",
  //                       style: TextStyle(fontSize: 12),
  //                     ),
  //                   ),
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //           RaisedButton(
  //             padding: const EdgeInsets.all(8.0),
  //             textColor: Colors.white,
  //             color: Color.fromARGB(255, 159, 145, 101),
  //             onPressed: () {
  //
  //               String phone ="wa.me/+916238839396/?text=${Uri.parse('Hi')}";
  //               if (phone != null && phone.trim().isNotEmpty) {
  //                 phone = 'https:$phone';
  //                 if ( canLaunch(phone) != null) {
  //                   launch(phone);
  //                 }
  //               }
  //             },
  //             child: Container(
  //               width: 80,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   FadeInImage.assetNetwork(
  //                     width: 15.0,
  //                     height: 15,
  //                     fit: BoxFit.fitHeight,
  //                     placeholder: 'assets/images/chat_icon.png',
  //                     image: 'assets/images/chat-icon.png',
  //                     // image: orders.image,
  //                     // image: order?.packageInfo?.origination?.logo ?? '',
  //                   ),
  //                   // Image.asset('assets/images/chat-icon.png',height: 15,width: 15,color: Colors.white,),
  //                   Container(
  //                     margin: EdgeInsets.only(left: 5),
  //                     child: Text(
  //                       "Chat",
  //                       style: TextStyle(fontSize: 12),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           RaisedButton(
  //             onPressed: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>DirectionNew()));
  //
  //               // _launchUrl(
  //               //   // 'http://maps.google.com/?saddr=My+Location&daddr=${task.order.first?.packageInfo?.location?.address}'
  //               //     'http://maps.google.com/?saddr=My+Location&daddr=${'kannur'}');
  //             },
  //             textColor: Colors.white,
  //             color: Color.fromARGB(255, 27, 40, 19),
  //             padding: const EdgeInsets.all(8.0),
  //             child:Container(
  //               width: 80,
  //               child: Row(
  //                 children: [
  //                   FadeInImage.assetNetwork(
  //                     width: 15,
  //                     height: 15,
  //                     fit: BoxFit.fitHeight,
  //                     placeholder: 'assets/images/location-icon.png',
  //                     image: 'assets/images/location-icon.png',
  //                     // image: orders.image,
  //                     // image: order?.packageInfo?.origination?.logo ?? '',
  //                   ),
  //                   // Image.asset('assets/images/location-icon.png',height: 15,width: 15,color: Colors.white,),
  //                   Container(
  //                     margin: EdgeInsets.only(left: 5),
  //                     child: Text(
  //                       "Location",
  //                       style: TextStyle(fontSize: 12),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ),
  //     ],
  //   );
  // }
Widget getDeliveryAddress(){
    return  ListView.builder(
        itemCount:deliaddressacc.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _getDeliveryInfo(deliaddressacc[index]);
        });
}

  Widget _getDeliveryInfo(Deliaddressacc deliaddressacc) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: const Text(
              'Delivery Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const DecoratedBox(
                decoration: const BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(deliaddressacc.name,
                    // task.order.first?.packageInfo?.location?.getName(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${deliaddressacc.house}${" , "}${deliaddressacc.road_name}${" , "}${deliaddressacc.street_name}${" , "}${deliaddressacc.state}${" , "}${deliaddressacc.country}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:
                RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: colorPrimary,
                  onPressed: () {
                    String phone =deliaddressacc.ccode+deliaddressacc.mobile;
                    if (phone != null && phone.trim().isNotEmpty) {
                      phone = 'tel:$phone';
                      if ( canLaunch(phone) != null) {
                        launch(phone);
                      }
                    }
                  },
                  child: new Text(
                    "Call",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              // Expanded(
              //   flex: 1,
              //   child:
                // RaisedButton(
                //   padding: const EdgeInsets.all(8.0),
                //   textColor: Colors.white,
                //   color: Color.fromARGB(255, 159, 145, 101),
                //   onPressed: () {
                //     String phone ='${'wa.me/'}${deliaddressacc.ccode+deliaddressacc.mobile}${'/?text'}=${Uri.parse('Hi')}';
                //     if (phone != null && phone.trim().isNotEmpty) {
                //       phone = 'https:$phone';
                //       if ( canLaunch(phone) != null) {
                //         launch(phone);
                //       }
                //     }
                //
                //     // Navigator.of(context).pushNamed("/chat");
                //     // if (task.order.length > 0) {
                //     //   _launchUrl(
                //     //     // 'https://wa.me/$contryCode${task.order.first?.packageInfo?.location?.phone}?text=hi');
                //     //       'https://wa.me/${'6238839396'}?text=hi');
                //     //       // 'https://wa.me/${task.customerPhone}?text=hi');
                //     // }
                //   },
                //   child: new Text(
                //     "Chat",
                //     style: TextStyle(fontSize: 12),
                //   ),
                // ),
              // ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child:
                RaisedButton(
                  onPressed: () {


                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>

                        DirectionNewCustomer(longitude: deliaddressacc.long,
                        latitude: deliaddressacc.lat,
                        name: deliaddressacc.name,
                        streetname:deliaddressacc.street_name,
                        road_name:deliaddressacc.road_name,
                        state:deliaddressacc.state,
                        house:deliaddressacc.house,
                        liveLat:_location.latitude,
                        liveLong:_location.longitude

                    )));

                    // _launchUrl(
                    //     // 'http://maps.google.com/?saddr=My+Location&daddr=${task.order.first?.packageInfo?.location?.address}'
                    //     'http://maps.google.com/?saddr=My+Location&daddr=${'kannur'}');
                  },
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 27, 40, 19),
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "View Location",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // ProductTable(task?.order?.first?.products),
        ],
      ),
    );
  }
  Widget _getPadding() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: colorGrayBg,
    );
  }

  Widget _getDivider() {
    return Divider(
      height: 2,color: Colors.grey[700],);
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Not supported");
    }
  }
}