// import 'package:driver_app/helper/constants.dart';
// import 'package:flutter/material.dart';
//
// class HistoryChangeNotifier extends ChangeNotifier {
//   bool _isLoading = false;
//   List<Task> tasks = [];
//   bool get isLoading => _isLoading;
//   set isLoading(bool isLoading) {
//     _isLoading = isLoading;
//     notifyListeners();
//   }
//
//   TasksResponse _response;
//
//   String nextPageUrl;
//   void addItems(TasksResponse response) {
//     if (response != null && response.tasks != null) {
//       if (_response == null) {
//         _response = response;
//       } else {
//         _response.tasks.tasks.addAll(response.tasks.tasks);
//       }
//       this.tasks.addAll(response.tasks.getAcceptedTask());
//       nextPageUrl = response.tasks.nextPageUrl;
//     }
//     debugPrint("$APP_TAG HistoryChangeNotifier addItems()");
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void reset() {
//     tasks = [];
//     nextPageUrl = null;
//     _response = null;
//     _isLoading = false;
//   }
// }
