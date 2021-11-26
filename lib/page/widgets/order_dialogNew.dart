// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:driver_app/helper/apiurldata.dart';
// import 'package:driver_app/helper/constants.dart';
// import 'package:driver_app/network/ApiCall.dart';
// import 'package:driver_app/network/response/driver_new_order_response.dart';
// import 'package:driver_app/network/response/task.dart';
// import 'package:driver_app/screens/home_screen2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'order_info1.dart';
// import 'order_info2.dart';
//
// class OrderDialogNew extends StatefulWidget {
//   @override
//   _OrderDialogNewState createState() => _OrderDialogNewState();
// }
//
// class _OrderDialogNewState extends State<OrderDialogNew> {
// DriverNewOrderResponse driverNewOrderResponse;
// Orders orders;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       FutureBuilder<DriverNewOrderResponse>(
//       future: ApiCall().execute<DriverNewOrderResponse, Null>(DRIVER_ORDER_URL, null),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           driverNewOrderResponse = snapshot.data;
//           orders = driverNewOrderResponse.orders.length>0?driverNewOrderResponse.orders[0]:Null;
//           return _getDriverOrdersList();
//         } else if (snapshot.hasError) {
//           return
//             // enableData();
//             errorScreen('Error: ${snapshot.error}');
//         } else {
//           return progressBar;
//         }
//       },
//     );
//   }
//
//
//
//
//
// Widget _getDriverOrdersList(){
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     child: ListView.builder(
//
//         itemCount: driverNewOrderResponse.orders.length,
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context,int index){
//           return _listOrders(driverNewOrderResponse.orders[index]);
//
//         }
//     ),
//   );
//
// }
// Widget _listOrders(Orders order) {
//   return  Container(
//       color: Colors.white,
//       width: MediaQuery.of(context).size.width,
//       child: Center(
//         child:
//         Card(
//             margin: EdgeInsets.only(left: 15,right: 15),
//             color: Colors.white,
//             elevation: 20,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10),
//               ),
//             ),
//             child:Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: double.infinity,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(color: colorPrimary,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10)
//                         )
//                     ),
//                     child: Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Text('Orders',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 20,
//                                 color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8,right: 10,left: 10,bottom: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                   Text('${'Order Id : '}${orders.orderid} ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//                             // '${task.orderId}'
//
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.access_time,
//                                 size: 20,
//                               ),
//                               SizedBox(
//                                 width: 5.0,
//                               ),
//                               Text(orders.timendate,
//                                 // task.createdAt,
//                                 style: TextStyle(
//                                     color: colorPrimary,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       orderInfo2(orders),
//                       // OrderInfo2(
//                       //   order: task.order.length < 1 ? null : task.order.first,
//                       // ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       orderInfo1(orders),
//                       // OrderInfo1(
//                       //   // order: task.order.length < 1 ? null : task.order.first,
//                       //   task: task,
//                       // ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   children: [
//                       //     Text(
//                       //       'Order status:',
//                       //       style: TextStyle(
//                       //         fontSize: 13.0,
//                       //         color: Colors.black,
//                       //         // fontWeight: FontWeight.w600,
//                       //       ),
//                       //     ),
//                       //     SizedBox(
//                       //       width: 5.0,
//                       //     ),
//                       //     // Text('',
//                       //     //   // task.statusText,
//                       //     //   style: TextStyle(
//                       //     //     fontSize: 14.0,
//                       //     //     color: Colors.black,
//                       //     //     fontWeight: FontWeight.w500,
//                       //     //   ),
//                       //     // ),
//                       //   ],
//                       // ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Expanded(
//                             flex: 1,
//                             child: RaisedButton(
//                               padding: const EdgeInsets.all(8.0),
//                               textColor: Colors.white,
//                               color: colorPrimary,
//                               onPressed: () {
//                                 // Navigator.of(context).pushNamed('/homenew');
//                                 // NextPageReplacement(context,HomeScreenNew());
//                                 // orderUpdateStatus?.update(true, task, null);
//                                 // updateTaskApi(task);
//                               },
//                               child: new Text("Accept"),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: RaisedButton(
//                               onPressed: () {
//                                 // Navigator.of(context).pushNamed('/report_reassign');
//                               },
//                               textColor: Colors.white,
//                               color: iconColor1,
//                               padding: const EdgeInsets.all(8.0),
//                               child: new Text(
//                                 "Reject",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//         ),
//       ),
//     );
//
//   }
//
//   Widget orderInfo2(Orders orders){
//     return Row(
//       children: <Widget>[
//         FadeInImage.assetNetwork(
//           width: 100.0,
//           height: 60,
//           fit: BoxFit.fitHeight,
//           placeholder: 'assets/images/homemade.jpg',
//           image: orders.image,
//           // image: order?.packageInfo?.origination?.logo ?? '',
//         ),
//         SizedBox(
//           width: 10.0,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(orders.product,
//                 // order?.packageInfo?.origination?.name ?? '',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(orders.description,
//                 // order?.packageInfo?.origination?.getAddress() ?? '',
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget orderInfo1(Orders orders){
//     return Container(
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           // color: colorGrayBg,
//             color: colorGrayBg,
//             borderRadius: BorderRadius.all(Radius.circular(5))),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Image(
//                     image: AssetImage("assets/images/quantity.png"),
//                     width: 20.0,
//                     color: iconColor1,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   // Icon(Icons.line_style,
//                   //     color: Color.fromARGB(255, 163, 148, 103)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Quantity',
//                         style: TextStyle(
//                           fontSize: 14.0,
//                           color: colorPrimary,
//                         ),
//                       ),
//                       Text('${orders.quantity}${' Nos'}',
//                         // '${order?.packageInfo?.packages?.first?.amount} Nos',
//                         // '${task.totalQuantity} Nos',
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   // Icon(Icons.line_weight, color: iconColor1),
//                   Image(
//                     image: AssetImage("assets/images/weight.png"),
//                     width: 20.0,
//                     color: iconColor1,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Weight',
//                         style: TextStyle(
//                           fontSize: 14.0,
//                           color: colorPrimary,
//                         ),
//                       ),
//                       Text("40 Kgs",
//                         // order?.packageInfo?.packages?.first?.weight ?? '',
//                         // task.totalWeight ?? '',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   // Icon(
//                   //   Icons.timelapse,
//                   //   color: iconColor1,
//                   // ),
//                   Image(
//                     image: AssetImage("assets/images/size.png"),
//                     width: 20.0,
//                     color: iconColor1,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Size',
//                         style: TextStyle(
//                           fontSize: 14.0,
//                           color: colorPrimary,
//                         ),
//                       ),
//                       Text("30 x 12",
//                         // order?.packageInfo?.packages?.first?.cost ?? '',
//                         // task.maxLength ?? '',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showItemDialog(BuildContext context, Task task) {
//     showDialog<bool>(
//       context: context,
//       builder: (_) => _buildDialog(context, task),
//     ).then((bool shouldNavigate) {
//       if (shouldNavigate == true) {
//         // _navigateToItemDetail(message);
//       }
//     });
//   }
//
//   Widget _buildDialog(BuildContext context, Task task) {
//     final _myController = TextEditingController();
//     return AlertDialog(
//       title: Text('Are you sure?'),
//       content: TextField(
//         autofocus: true,
//         controller: _myController,
//         keyboardType: TextInputType.multiline,
//         maxLines: 3,
//         decoration: new InputDecoration(
//             border: new OutlineInputBorder(
//                 borderSide: new BorderSide(color: Colors.lightGreen)),
//             labelText: 'Reason',
//             hintText: 'Enter reason'),
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: const Text('CLOSE'),
//           onPressed: () {
//             Navigator.pop(context, false);
//             _myController.dispose();
//           },
//         ),
//         FlatButton(
//           child: const Text('REJECT'),
//           // onPressed: () {
//           //   // Focus.of(context).requestFocus(FocusNode());
//           //   String reason = _myController.text.trim();
//           //   if (reason.length > 1) {
//           //     orderUpdateStatus?.update(false, task, reason);
//           //     Navigator.pop(context, true);
//           //     _myController.dispose();
//           //   } else {
//           //     ApiCall().showToast('Please enter a valid reason');
//           //   }
//           // },
//         ),
//       ],
//     );
//   }
//
//
// }
//
// abstract class OrderUpdateStatus {
//   void update(bool isAccepte, Task task, String reason);
// }
