// // import 'package:driver_app/custom/custom_switch.dart';
// import 'package:driver_app/helper/constants.dart';
// import 'package:driver_app/network/ApiCall.dart';
// import 'package:driver_app/network/response/success_response.dart';
// import 'package:driver_app/network/response/task.dart';
// import 'package:driver_app/network/response/tasks_response.dart';
// import 'package:driver_app/network/response/tasks_update_response.dart';
// import 'package:driver_app/notifier/home/duty_notifier.dart';
// import 'package:driver_app/notifier/home/home_notifier.dart';
// import 'package:driver_app/notifier/loading_notifier.dart';
// import 'package:driver_app/widgets/order_dialog.dart';
// import 'package:driver_app/widgets/order_info1.dart';
// import 'package:driver_app/widgets/order_info2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'dart:io' show Platform;
//
// import 'package:url_launcher/url_launcher.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => new _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with WidgetsBindingObserver
//     implements OrderUpdateStatus {
//   HomeChangeNotifier _homeChangeListener;
//   HomeLoadNotifier _homeLoadNotifier;
//   DutyChangeNotifier _dutyChangeNotifier;
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed &&
//         state != AppLifecycleState.inactive) {
//       debugPrint('MJM AppLifecycleState.resumed');
//       homeApi();
//       // }
//     }
//   }
//
//   static const EventChannel eventChannel =
//       EventChannel('com.jafseel/firebaseMessage');
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _homeChangeListener =
//         Provider.of<HomeChangeNotifier>(context, listen: false);
//     _dutyChangeNotifier =
//         Provider.of<DutyChangeNotifier>(context, listen: false);
//     _homeLoadNotifier = Provider.of<HomeLoadNotifier>(context, listen: false);
//     ApiCall().context = context;
//     getUser();
//     homeApi();
//
//     eventChannel.receiveBroadcastStream().listen((onData) {
//       // ApiCall().showToast("message received");
//       homeApi();
//     });
//   }
//
//   void _handleClick(String value) async {
//     switch (value) {
//       case 'COD balance':
//         Navigator.of(context).pushNamed('/balance');
//         break;
//       case 'Call admin':
//         {
//           String number = await ApiCall().getAdminPhone();
//           _launchUrl('tel:$number');
//         }
//         break;
//       case 'Logout':
//         {
//           _logout();
//         }
//         break;
//     }
//   }
//
//   Future<void> _launchUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<Null> homeApi([String url]) async {
//     TasksResponse response;
//     if (!_homeLoadNotifier.isLoading) {
//       _homeLoadNotifier.isLoading = true;
//     }
//     Map params = {
//       'device_token': deviceToken,
//       'device_id': deviceId,
//       'device_platform': Platform.isIOS ? '2' : '1',
//     };
//     await ApiCall()
//         .execute<TasksResponse, Null>(url ?? "tasks", params)
//         .then((value) => response = value)
//         .catchError((error, stackTrace) {});
//
//     if (response != null) {
//       if (returnReasons.isEmpty &&
//           response.reasons != null &&
//           response.reasons.isNotEmpty) {
//         returnReasons = response.reasons;
//         debugPrint('homeApi returnReasons size: ${returnReasons.length}');
//       }
//       if (response?.admin?.phone != null &&
//           response.admin.phone.trim().isNotEmpty) {
//         await ApiCall().saveAdminPhone(response?.admin?.phone);
//       }
//       // _homeChangeListener.addItems(
//       //     response, (url != null && url.trim().isNotEmpty));
//     }
//     _homeChangeListener.addItems(
//         response, (url != null && url.trim().isNotEmpty));
//     _homeLoadNotifier.isLoading = false;
//   }
//
//   void getUser() async {
//     var user = await ApiCall().getUser();
//     if (user == null ||
//         user.token == null ||
//         user.token.trim().isEmpty) {
//       Navigator.of(context).pushReplacementNamed('/login');
//     } else {
//       debugPrint('homeApi getUser() user: ${user.toJson()}');
//       userDataGlobal = user;
//       _dutyChangeNotifier.username = user.name;
//     }
//   }
//
//   void updateTaskApi(Task task) {
//     // Map params = {'status': status, 'task_id': taskId};
//     // TasksResponse response = await ApiCall()
//     //     .execute<TasksResponse, Null>("task/update-status", params);
//     // _homeChangeListener.addItems(response);
//     if (task == null || task.order == null || task.order.isEmpty) {
//       return;
//     }
//     debugPrint('updateTaskApi status: ${task.status}');
//     if (int.parse(task.status ?? '0') == 2) {
//       Navigator.of(context).pushNamed("/pickup", arguments: task);
//     } else if (int.parse(task.status ?? '0') == 4) {
//       Navigator.of(context).pushNamed("/delivery", arguments: task);
//       // } else if (int.parse(task.status ?? '0') == 6) {
//
//     } else if ((task.status ?? '0') == '7' || (task.status ?? '0') == '8') {
//       Navigator.of(context).pushNamed("/return_to_store", arguments: task);
//     }
//   }
//
//   void _updateDuty(bool isDutyOn) async {
//     _homeLoadNotifier.isLoading = true;
//     Map params = {
//       'is_on_duty': isDutyOn ? '1' : '0',
//     };
//     await ApiCall()
//         .execute<SuccessResponse, Null>("update-duty-status", params);
//     if (isDutyOn) {
//       homeApi();
//     } else {
//       _homeLoadNotifier.isLoading = false;
//       _homeChangeListener.reset();
//     }
//   }
//
//   void _logout() async {
//     await ApiCall().saveUser(null);
//     Navigator.of(context).pushReplacementNamed('/login');
//   }
//
//   Widget appBar() => AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [colorPrimary, gradientEnd],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               // stops: [0.5, 1.0],
//             ),
//           ),
//         ),
//         title: Center(
//           child: Container(
//             child: Image(
//               image: AssetImage("assets/images/logo_1.png"),
//               height: 30.0,
//               color: Colors.white,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: (String value) {
//               _handleClick(value);
//             },
//             itemBuilder: (BuildContext context) {
//               return {'COD balance', 'Call admin', 'Logout'}
//                   .map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     print("HomeScree Widget build()");
//     return Scaffold(
//       // use Scaffold also in order to provide material app widgets
//       appBar: appBar(),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           return await homeApi();
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
//                     child: Column(children: <Widget>[
//                       Consumer<DutyChangeNotifier>(
//                           builder: (context, data, child) {
//                         bool _isDuty = data.isDutyOn;
//                         debugPrint("username"
//                             // '$APP_TAG*********notifier name: ${data.username} ${data.isDutyOn}'
//                         );
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 "username",
//                                 // data.username ?? userDataGlobal.name ?? '',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                             Switch(
//                                 value: _isDuty,
//                                 onChanged: (value) {
//                                   print("VALUE : $value");
//                                   _dutyChangeNotifier.isDutyOn = value;
//                                   _updateDuty(value);
//                                 }),
//                             // CustomSwitch(
//                             //     activeColor: colorPrimary.withAlpha(150),
//                             //     value: _isDuty,
//                             //     onChanged: (value) {
//                             //       print("VALUE : $value");
//                             //       _dutyChangeNotifier.isDutyOn = value;
//                             //       _updateDuty(value);
//                             //     }),
//                           ],
//                         );
//                       }),
//                       SizedBox(height: 15.0),
//                       Expanded(
//                         child:
//                         Consumer<HomeChangeNotifier>(
//                             builder: (context, data, child) {
//                           if (data.tasks != null && data.tasks.isNotEmpty) {
//                             List<Widget> childs = [];
//                             childs.add(NotificationListener<ScrollNotification>(
//                               onNotification: (scrollInfo) {
//                                 if (!data.isPaginationLoading &&
//                                     data.nextPageUrl != null &&
//                                     data.nextPageUrl.trim().isNotEmpty &&
//                                     scrollInfo.metrics.pixels ==
//                                         scrollInfo.metrics.maxScrollExtent) {
//                                   // _loadData();
//                                   _homeChangeListener.isPaginationLoading =
//                                       true;
//                                   homeApi(data.nextPageUrl);
//                                   return true;
//                                 } else {
//                                   // print("stop loading data ${data.isLoading}");
//                                   return false;
//                                 }
//                               },
//                               child: ListView.separated(
//                                   // itemCount: data.tasks.length,
//                                   itemCount:10,
//                                   separatorBuilder: (context, index) => Divider(
//                                         color: Colors.black,
//                                       ),
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return listTile(
//                                         context, index, data.tasks[index]
//                                     );
//                                   }),
//                             ));
//                             data.newTask.forEach((element) {
//                               childs.add(OrderDialog(
//                                 task: element,
//                                 orderUpdateStatus: this,
//                               ));
//                             });
//                             return Stack(
//                               children: childs,
//                             );
//                             // } else if (data.newTask.isNotEmpty) {
//                             //   List<Widget> childs = [];
//                             //   childs.add(OrderDialog(
//                             //     task: data.newTask.first,
//                             //     orderUpdateStatus: this,
//                             //   ));
//                             //   // data.newTask.forEach((element) {
//                             //   //   childs.add(OrderDialog(
//                             //   //     task: element,
//                             //   //     orderUpdateStatus: this,
//                             //   //   ));
//                             //   // });
//                             //   return SingleChildScrollView(
//                             //     child: Stack(
//                             //       children: childs,
//                             //     ),
//                             //   );
//                           } else if (data.newTask != null &&
//                               data.newTask.isNotEmpty) {
//                             List<Widget> childs = [];
//                             data.newTask.forEach((element) {
//                               childs.add(OrderDialog(
//                                 task: element,
//                                 orderUpdateStatus: this,
//                               ));
//                             });
//                             return Stack(
//                               children: childs,
//                             );
//                           } else {
//                             return Center(
//                               child: Text(_homeLoadNotifier.isLoading
//                                   ? 'Loading'
//                                   : (_dutyChangeNotifier.isDutyOn
//                                       ? 'No data found'
//                                       : 'Duty off')),
//                             );
//                           }
//                         }),
//                         // child: ListView.separated(
//                         //     itemCount: names.length,
//                         //     separatorBuilder: (context, index) => Divider(
//                         //           color: Colors.black,
//                         //         ),
//                         //     itemBuilder: (BuildContext context, int index) {
//                         //       return listTile(context, index);
//                         //     })
//                       ),
//                     ]),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: FlatButton.icon(
//                             materialTapTargetSize:
//                                 MaterialTapTargetSize.shrinkWrap,
//                             onPressed: () {
//                               Navigator.of(context).pushNamed('/profile');
//                             },
//                             color: colorPrimary,
//                             textColor: Colors.white,
//                             padding: EdgeInsets.all(0),
//                             icon: Icon(
//                               Icons.account_circle,
//                               size: 16.0,
//                             ),
//                             label: Text(
//                               'My Profile',
//                               style: TextStyle(
//                                 fontSize: 13.0,
//                               ),
//                             ))),
//                     VerticalDivider(color: Colors.red, width: 0.5),
//                     // Expanded(
//                     //     child: FlatButton.icon(
//                     //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     //         onPressed: () {
//                     //           Navigator.of(context).pushNamed('/settings');
//                     //         },
//                     //         padding: EdgeInsets.all(0),
//                     //         textColor: Colors.white,
//                     //         color: colorPrimary,
//                     //         icon: Icon(
//                     //           Icons.settings,
//                     //           size: 16.0,
//                     //         ),
//                     //         label: Text('Settings'))),
//                     // VerticalDivider(color: Colors.red, width: 0.5),
//                     Expanded(
//                         child: FlatButton.icon(
//                             materialTapTargetSize:
//                                 MaterialTapTargetSize.shrinkWrap,
//                             onPressed: () {
//                               Navigator.of(context).pushNamed('/history');
//                             },
//                             padding: EdgeInsets.all(0),
//                             textColor: Colors.white,
//                             color: colorPrimary,
//                             icon: Icon(
//                               Icons.history,
//                               size: 16.0,
//                             ),
//                             label: Text('History')))
//                   ],
//                 )
//               ],
//             ),
//             Consumer<HomeLoadNotifier>(builder: (context, data, child) {
//               return data.isLoading
//                   ? Stack(
//                       children: [
//                         const Opacity(
//                           child: const ModalBarrier(
//                               dismissible: false, color: Colors.grey),
//                           opacity: 0.5,
//                         ),
//                         Center(child: const CircularProgressIndicator())
//                       ],
//                     )
//                   : Container(
//                       height: 0,
//                     );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     // _homeChangeListener.dispose();
//     // _dutyChangeNotifier.dispose();
//     // _homeLoadNotifier.dispose();
//   }
//
//   Widget listTile(BuildContext context, int index, Task task) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text('OrderId'
//               // 'Order Id: ${task.orderId}'
//           ),
//           Row(
//             children: <Widget>[
//               Icon(
//                 Icons.access_time,
//               ),
//               SizedBox(
//                 width: 5.0,
//               ),
//               Expanded(
//                 child: Text(
//                   task.createdAt,
//                   style: TextStyle(
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//               DecoratedBox(
//                 decoration: const BoxDecoration(color: iconColor1),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
//                   child: Text(
//                     task.paymentMethod,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 15.0,
//           ),
//           OrderInfo2(
//             order: task.order.length < 1 ? null : task.order.first,
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           OrderInfo1(
//             // order: task.order.length < 1 ? null : task.order.first,
//             task: task,
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 'Order status:',
//                 style: TextStyle(
//                   fontSize: 13.0,
//                   color: Colors.black,
//                   // fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 width: 5.0,
//               ),
//               Text(
//                 task.statusText,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 flex: 1,
//                 child: RaisedButton(
//                   padding: const EdgeInsets.all(8.0),
//                   textColor: Colors.white,
//                   color: colorPrimary,
//                   onPressed: () {
//                     updateTaskApi(task);
//                   },
//                   child: new Text("Update Status"),
//                 ),
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: RaisedButton(
//                   onPressed: () {
//                     if (task.order.length > 0) {
//                       Navigator.of(context)
//                           .pushNamed('/order_details', arguments: task);
//                     }
//                   },
//                   textColor: Colors.white,
//                   color: iconColor1,
//                   padding: const EdgeInsets.all(8.0),
//                   child: new Text(
//                     "View Details",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void update(bool isAccepted, Task task, String reason) async {
//     _homeLoadNotifier.isLoading = true;
//     debugPrint('update order status: $isAccepted');
//     Map params = {
//       'status': isAccepted ? '2' : '3',
//       'task_id': task.id.toString()
//     };
//     if (reason != null && reason.trim().isNotEmpty) {
//       // params.addAll({'reason': reason.trim()});
//       params.addAll({'reject_reason': reason.trim()});
//     }
//     TasksUpdateResponse response = await ApiCall()
//         .execute<TasksUpdateResponse, Null>("task/update-status", params);
//     _homeLoadNotifier.isLoading = false;
//     _homeChangeListener.updateItem(response?.task);
//   }
// }
//
// // import 'package:driver_app/custom/custom_switch.dart';
// // import 'package:flutter/material.dart';
//
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => new _HomeScreenState();
// // }
//
// // class _HomeScreenState extends State<HomeScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
//
// //   final appBar = AppBar(
// //     flexibleSpace: Container(
// //       decoration: BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [
// //             Color.fromARGB(255, 141, 209, 0),
// //             Color.fromARGB(255, 156, 231, 0)
// //           ],
// //           begin: Alignment.centerLeft,
// //           end: Alignment.centerRight,
// //           // stops: [0.5, 1.0],
// //         ),
// //       ),
// //     ),
// //     title: Center(
// //       child: Container(
// //         child: Image(
// //           image: AssetImage("assets/images/logo_1.png"),
// //           height: 30.0,
// //           color: Colors.white,
// //           fit: BoxFit.contain,
// //         ),
// //       ),
// //     ),
// //     actions: <Widget>[
// //       IconButton(
// //         icon: Icon(
// //           Icons.more_vert,
// //           color: Colors.white,
// //         ),
// //         onPressed: () {
// //           // do something
// //         },
// //       )
// //     ],
// //   );
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // use Scaffold also in order to provide material app widgets
// //       appBar: appBar,
// //       body: Container(
// //           child: Column(
// //         children: <Widget>[
// //           Padding(
// //             padding: const EdgeInsets.all(12.0),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: <Widget>[
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Flexible(
// //                       child: Text("data"),
// //                     ),
// //                     CustomSwitch(
// //                         activeColor: Colors.pinkAccent,
// //                         value: true,
// //                         onChanged: (value) {
// //                           print("VALUE : $value");
// //                           // setState(() {
// //                           //   status = value;
// //                           // });
// //                         }),
// //                   ],
// //                 ),
// //                 Image(
// //                   image: AssetImage("assets/images/logo_1.png"),
// //                   height: 40.0,
// //                   fit: BoxFit.contain,
// //                 ),
// //                 Image(
// //                   image: AssetImage("assets/images/logo_1.png"),
// //                   height: 40.0,
// //                   fit: BoxFit.contain,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       )),
// //     );
// //   }
// // }
