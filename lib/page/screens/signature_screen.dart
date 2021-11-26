// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:driver_app/custom/Signature.dart';
// import 'package:http/http.dart' as http;
// import 'package:driver_app/network/ApiCall.dart';
// import 'package:driver_app/network/response/task.dart';
// import 'package:driver_app/network/response/tasks_update_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http_parser/http_parser.dart';
//
// // https://github.com/kiwi-bop/flutter_signature_pad/
// class SignatureScreen extends StatefulWidget {
//   final Task task;
//   SignatureScreen(this.task, {Key key}) : super(key: key);
//
//   @override
//   _SignaturePageState createState() => _SignaturePageState(task);
// }
//
// class _WatermarkPaint extends CustomPainter {
//   final String price;
//   final String watermark;
//
//   _WatermarkPaint(this.price, this.watermark);
//
//   @override
//   void paint(ui.Canvas canvas, ui.Size size) {
//     // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
//     //     Paint()..color = Colors.blue);
//   }
//
//   @override
//   bool shouldRepaint(_WatermarkPaint oldDelegate) {
//     return oldDelegate != this;
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is _WatermarkPaint &&
//           runtimeType == other.runtimeType &&
//           price == other.price &&
//           watermark == other.watermark;
//
//   @override
//   int get hashCode => price.hashCode ^ watermark.hashCode;
// }
//
// class _SignaturePageState extends State<SignatureScreen> {
//   final Task _task;
//   _SignaturePageState(this._task);
//   ByteData _img = ByteData(0);
//   var color = Colors.red;
//   var strokeWidth = 3.0;
//   final _sign = GlobalKey<SignatureState>();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Signature(
//                   color: color,
//                   key: _sign,
//                   onSign: () {
//                     final sign = _sign.currentState;
//                     debugPrint('${sign.points.length} points in the signature');
//                   },
//                   backgroundPainter: _WatermarkPaint("2.0", "2.0"),
//                   strokeWidth: strokeWidth,
//                 ),
//               ),
//               color: Colors.black12,
//             ),
//           ),
//           _img.buffer.lengthInBytes == 0
//               ? Container()
//               : LimitedBox(
//                   maxHeight: 200.0,
//                   child: Image.memory(_img.buffer.asUint8List())),
//           Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: MaterialButton(
//                           color: Colors.grey,
//                           onPressed: () {
//                             final sign = _sign.currentState;
//                             sign.clear();
//                             // setState(() {
//                             //   _img = ByteData(0);
//                             // });
//                             debugPrint("cleared");
//                           },
//                           child: Text("Clear")),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                         child: MaterialButton(
//                             color: Colors.green,
//                             onPressed: () async {
//                               final sign = _sign.currentState;
//                               //retrieve image data, do whatever you want with it (send to server, save locally...)
//                               final image = await sign.getData();
//                               var data = await image.toByteData(
//                                   format: ui.ImageByteFormat.png);
//                               // sign.clear();
//                               final encoded =
//                                   base64.encode(data.buffer.asUint8List());
//                               // setState(() {
//                               //   _img = data;
//                               // });
//
//                               _img = data;
//                               _update(_task, _img);
//                               debugPrint("onPressed " + encoded);
//                             },
//                             child: Text("Save"))),
//                   ],
//                 ),
//               ),
//               // Row(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               // children: <Widget>[
//               //   MaterialButton(
//               //       onPressed: () {
//               //         setState(() {
//               //           color =
//               //               color == Colors.green ? Colors.red : Colors.green;
//               //         });
//               //         debugPrint("change color");
//               //       },
//               //       child: Text("Change color")),
//               // MaterialButton(
//               //     onPressed: () {
//               //       setState(() {
//               //         int min = 1;
//               //         int max = 5;
//               //         int selection = min + (Random().nextInt(max - min));
//               //         strokeWidth = selection.roundToDouble();
//               //         debugPrint("change stroke width to $selection");
//               //       });
//               //     },
//               //     child: Text("Change stroke width")),
//               // ],
//               // ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   void _update(Task task, ByteData image) async {
//     if (_img.buffer.lengthInBytes <= 0) {
//       return;
//     }
//     var request = ApiCall().getMultipartRequest("task/update-signature");
//     request.fields['task_id'] = task.id.toString();
//     request.files.add(http.MultipartFile.fromBytes(
//         'signature',
//         image.buffer
//             .asUint8List(image.offsetInBytes, image.lengthInBytes)
//             .cast<int>(),
//         filename: 'signature_${DateTime.now().microsecondsSinceEpoch}.png',
//         contentType: MediaType('image', '*')));
//
//     TasksUpdateResponse response = await ApiCall()
//         .execute<TasksUpdateResponse, Null>("/task/update-signature", null,
//             multipartRequest: request);
//     // Provider.of<HomeChangeNotifier>(context, listen: false)
//     //     .updateItem(response?.task);
//     Navigator.of(context).pushReplacementNamed('/home');
//   }
// }
